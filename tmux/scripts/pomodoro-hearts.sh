#!/usr/bin/env bash

POMODORO_DIR="/tmp/pomodoro"
START_FILE="$POMODORO_DIR/start_time.txt"
PAUSED_FILE="$POMODORO_DIR/paused_time.txt"
TIME_PAUSED_FOR_FILE="$POMODORO_DIR/time_paused_for.txt"
FROZEN_DISPLAY_FILE="$POMODORO_DIR/frozen_display.txt"
STATUS_FILE="$POMODORO_DIR/current_status.txt"
INTERVAL_FILE="$POMODORO_DIR/interval_count.txt"
SKIPPED_FILE="$POMODORO_DIR/skipped.txt"

HEART_FILLED="󰋑  "
HEART_EMPTY="${HEART_FILLED}"
TOTAL_HEARTS=5

read_file() {
	if [ -f "$1" ]; then cat "$1"; else echo 1; fi
}

file_exists() { [ -f "$1" ]; }

get_tmux_option() {
	local val
	val=$(tmux show-option -gqv "$1")
	if [ -z "$val" ]; then echo "$2"; else echo "$val"; fi
}

get_seconds() { date +%s; }

minutes_to_seconds() { echo $(($1 * 60)); }

get_pomodoro_duration() { get_tmux_option "@pomodoro_mins" "25"; }
get_pomodoro_break() { get_tmux_option "@pomodoro_break_mins" "5"; }
get_pomodoro_long_break() { get_tmux_option "@pomodoro_long_break_mins" "25"; }
get_pomodoro_intervals() { get_tmux_option "@pomodoro_intervals" "4"; }
get_pomodoro_granularity() { get_tmux_option "@pomodoro_granularity" "off"; }

format_seconds() {
	local total_seconds=$1
	local minutes=$((total_seconds / 60))
	local seconds=$((total_seconds % 60))

	if [ "$(get_pomodoro_granularity)" == 'on' ]; then
		printf "%02d:%02d" $minutes $seconds
	else
		printf "%sm" "$(((total_seconds + 59) / 60))"
	fi
}

time_paused_for() {
	if file_exists "$TIME_PAUSED_FOR_FILE"; then
		read_file "$TIME_PAUSED_FOR_FILE"
	else
		echo "0"
	fi
}

intervals_reached() {
	local val
	val=$(read_file "$INTERVAL_FILE")
	[ "$val" -eq "$(get_pomodoro_intervals)" ]
}

break_length() {
	if intervals_reached; then
		minutes_to_seconds "$(get_pomodoro_long_break)"
	else
		minutes_to_seconds "$(get_pomodoro_break)"
	fi
}

show_intervals() {
	local fmt
	fmt=$(get_tmux_option "@pomodoro_interval_display" "0")
	local count
	count=$(echo "$fmt" | grep -o "%s" | wc -l)

	if [ "$count" -eq 1 ]; then
		printf "$fmt" "$(read_file "$INTERVAL_FILE")"
	elif [ "$count" -eq 2 ]; then
		printf "$fmt" "$(read_file "$INTERVAL_FILE")" "$(get_pomodoro_intervals)"
	fi
}

render_hearts() {
	local time_left=$1
	local duration=$2
	local seconds_per_heart=$((duration / TOTAL_HEARTS))
	local hearts_remaining=$(((time_left + seconds_per_heart - 1) / seconds_per_heart))

	if [ "$hearts_remaining" -gt "$TOTAL_HEARTS" ]; then
		hearts_remaining=$TOTAL_HEARTS
	fi
	if [ "$hearts_remaining" -lt 0 ]; then
		hearts_remaining=0
	fi

	local hearts_empty=$((TOTAL_HEARTS - hearts_remaining))
	local output="  "
	local i
	local switched=false
	for ((i = 0; i < TOTAL_HEARTS; i++)); do
		if [ "$i" -lt "$hearts_empty" ]; then
			if [ "$switched" = false ]; then
				output+="#[fg=color8]"
				switched=true
			fi
			output+="$HEART_EMPTY"
		else
			if [ "$switched" = true ] || { [ "$hearts_empty" -eq 0 ] && [ "$i" -eq 0 ]; }; then
				output+="#[fg=color13]"
				switched=false
			fi
			output+="$HEART_FILLED"
		fi
	done
	output+="#[fg=color6] "
	echo -n "$output"
}

PLUGIN_SCRIPT="$HOME/.tmux/plugins/tmux-pomodoro-plus/scripts/pomodoro.sh"

main() {
	local start_time
	start_time=$(read_file "$START_FILE")

	if [ "$start_time" -eq 1 ]; then
		return 0
	fi

	# Let the plugin handle state transitions (completion, break start, etc.)
	"$PLUGIN_SCRIPT" > /dev/null 2>&1

	# Re-read state after plugin may have changed it
	start_time=$(read_file "$START_FILE")
	if [ "$start_time" -eq 1 ]; then
		return 0
	fi

	local current_time
	current_time=$(get_seconds)
	local pomodoro_status
	pomodoro_status=$(read_file "$STATUS_FILE")
	local paused_for
	paused_for=$(time_paused_for)
	local elapsed_time=$((current_time - start_time - paused_for))
	local pomodoro_duration
	pomodoro_duration=$(minutes_to_seconds "$(get_pomodoro_duration)")

	# Paused with frozen display
	if file_exists "$PAUSED_FILE" && file_exists "$FROZEN_DISPLAY_FILE"; then
		printf "%s%s" "  #[fg=color14]󱙝  " "$(read_file "$FROZEN_DISPLAY_FILE")"
		show_intervals
		return 0
	fi

	# Waiting prompts
	if [ "$pomodoro_status" == "waiting_for_pomodoro" ]; then
		printf "%s" "  #[fg=color2]󰢚 Start an Adventure?"
		show_intervals
		return 0
	fi
	if [ "$pomodoro_status" == "waiting_for_break" ]; then
		printf "%s" "  #[fg=color2]⛧  Hail Satan"
		show_intervals
		return 0
	fi

	# Pomodoro completed or skipped?
	local pomodoro_completed=false
	if [ "$elapsed_time" -ge "$pomodoro_duration" ] || { file_exists "$SKIPPED_FILE" && [ "$(read_file "$SKIPPED_FILE")" == "pomodoro" ]; }; then
		pomodoro_completed=true
	fi

	# Pomodoro in progress
	if [ "$pomodoro_completed" = false ] && [ "$pomodoro_status" == "in_progress" ]; then
		local time_left=$((pomodoro_duration - elapsed_time))

		if file_exists "$PAUSED_FILE"; then
			if ! file_exists "$FROZEN_DISPLAY_FILE"; then
				echo "$(format_seconds $time_left)" >"$FROZEN_DISPLAY_FILE"
			fi
			printf "%s%s" "  #[fg=color14]󱙝  " "$(format_seconds $time_left)"
		else
			render_hearts "$time_left" "$pomodoro_duration"
			printf "%s" "$(format_seconds $time_left)"
		fi

		show_intervals
		return 0
	fi

	# Break completed or skipped?
	local break_complete=false
	if [ "$elapsed_time" -ge "$(break_length)" ] || { file_exists "$SKIPPED_FILE" && [ "$(read_file "$SKIPPED_FILE")" == "break" ]; }; then
		break_complete=true
	fi

	# Break in progress
	if [ "$break_complete" = false ] && { [ "$pomodoro_status" == "break" ] || [ "$pomodoro_status" == "long_break" ]; }; then
		local time_left=$(($(break_length) - elapsed_time))

		if file_exists "$PAUSED_FILE"; then
			if ! file_exists "$FROZEN_DISPLAY_FILE"; then
				echo "$(format_seconds $time_left)" >"$FROZEN_DISPLAY_FILE"
			fi
			printf "%s%s" "  #[fg=color14]󱙝  " "$(format_seconds $time_left)"
		else
			printf "%s%s" "  #[fg=color17]⛧  " "$(format_seconds $time_left)"
		fi

		show_intervals
		return 0
	fi
}

main
