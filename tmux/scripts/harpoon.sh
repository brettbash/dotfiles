#!/bin/sh
#
# ⛓️ HARPOON — session bookmarks that land where you left off
#
# Drop-in fork of Chaitanyabsprip/tmux-harpoon with three fixes:
#   1. Jumps target the SESSION only, so tmux restores its last-active
#      window and pane instead of a window index frozen at bookmark time.
#   2. BSD-safe writes (upstream's `sed -i` silently fails on macOS, which
#      is why replace/remove never took effect).
#   3. Slots are fixed: replacing index N always writes line N, and stale
#      `:window.pane` suffixes left by upstream are ignored and scrubbed.
#
# Cache format: one `session name=/session/path` per line, blank = empty slot.

get_default_cache_dir() {
	if [ -n "$XDG_CACHE_HOME" ]; then
		echo "$XDG_CACHE_HOME"
	elif [ "$(uname)" = "Darwin" ]; then
		echo "$HOME/Library/Caches"
	else
		echo "$HOME/.cache"
	fi
}

cachefile="$(get_default_cache_dir)/.tmux-harpoon-sessions"

help() {
	echo
	echo "Usage:"
	echo "    ${0##*/} [options] [args]"
	echo "Options:"
	echo "    -a, -A                Track current tmux session"
	echo "    -r <index>, -R <index>"
	echo "                          Replace tracked entry at index with current session"
	echo "    -d [session_name]     Stop tracking session with session name. If"
	echo "                          session_name is not passed then remove current session"
	echo "    -l                    List tracked sessions"
	echo "    -s <index>            Switch to the session at the specified index in the"
	echo "                          list of tracked sessions"
	echo "    -e                    Edit the sessions file"
	echo "    -h                    Display this help message"
}

_notify() { tmux display "$*"; }

# Strip a trailing :window[.pane] left behind by upstream harpoon.
_clean_path() {
	printf '%s' "$1" | sed 's/:[0-9][0-9]*\(\.[0-9][0-9]*\)*$//'
}

_current_name() { tmux display -p '#{session_name}'; }
_current_path() { tmux display -p '#{session_path}'; }

# Write stdin over the cachefile, trimming trailing blank slots.
_commit() {
	tmpfile="$(mktemp)"
	awk '{ lines[NR] = $0; if ($0 != "") last = NR }
	     END { for (i = 1; i <= last; i++) print lines[i] }' >"$tmpfile"
	cat "$tmpfile" >"$cachefile"
	rm -f "$tmpfile"
}

# Blank every slot holding $1, except line $2 (pass 0 to clear them all).
_unique() {
	name="$1"
	keep="${2:-0}"
	awk -v name="$name" -v keep="$keep" -F= '
		{ if (NR != keep && $1 == name) print ""; else print }
	' "$cachefile" | _commit
}

add() {
	name="$(_current_name)"
	existing="$(awk -v name="$name" -F= '$1 == name { print NR; exit }' "$cachefile")"
	if [ -n "$existing" ]; then
		_notify "Session $name already tracked at index $existing"
		return 0
	fi

	awk -v bookmark="$name=$(_current_path)" '
		{ if ($0 == "" && !placed) { print bookmark; placed = 1 } else print }
		END { if (!placed) print bookmark }
	' "$cachefile" | _commit
	_notify "Tracking session $name"
}

replace() {
	index="$1"
	name="$(_current_name)"

	awk -v slot="$index" -v bookmark="$name=$(_current_path)" '
		{ lines[NR] = $0 }
		END {
			total = NR > slot ? NR : slot
			lines[slot] = bookmark
			for (i = 1; i <= total; i++) print lines[i]
		}
	' "$cachefile" | _commit

	_unique "$name" "$index"
	_notify "Tracking session $name in index $index"
}

remove() {
	_unique "${1:-$(_current_name)}" 0
}

_line() { awk -v n="$1" 'NR == n { print; exit }' "$cachefile"; }

_switch() {
	name="$1"
	path="$(_clean_path "$2")"

	if ! tmux has-session -t "=$name" 2>/dev/null; then
		[ -d "$path" ] || path="$HOME"
		tmux new-session -ds "$name" -c "$path" || return 1
	fi

	# No window/pane target: tmux restores the session's last-active window.
	tmux switch-client -t "=$name"
}

switch() {
	entry="$(_line "$1")"
	if [ -z "$entry" ]; then
		_notify "No harpoon bookmark at index $1"
		return 0
	fi
	_switch "${entry%%=*}" "${entry#*=}"
}

_getFZFCmd() {
	! type fzf >/dev/null 2>&1 && echo "Harpoon depends on fzf" && exit 1
	FZF_VERSION=$(fzf --version | cut -d ' ' -f1)
	REQUIRED_VERSION="0.53.0"

	version_gt() { [ "$(printf '%s\n' "$@" | sort -V | head -n1)" != "$1" ] || [ "$1" = "$2" ]; }

	if version_gt "$FZF_VERSION" "$REQUIRED_VERSION"; then
		echo "fzf --tmux 50%"
		return 0
	fi
	if type fzf-tmux >/dev/null 2>&1; then
		echo "fzf-tmux -p '50%,50%'"
		return 0
	fi
	echo "fzf"
	return 0
}

view() {
	FZF_CMD="$(_getFZFCmd)"
	index="$(awk -v home="$HOME" -v bold="$(tput setaf 4)" -v sgr0="$(tput sgr0)" -F= '
		$0 == "" { next }
		{
			value = substr($0, index($0, "=") + 1)
			sub(/:[0-9]+(\.[0-9]+)?$/, "", value)
			sub(home "/", "", value)
			printf "%d\t%s%s%s %s\n", NR, bold, $1, sgr0, value
		}
	' "$cachefile" | $FZF_CMD --ansi --delimiter '\t' --with-nth 2.. | cut -f1)"
	[ -z "$index" ] && return 0
	switch "$index"
}

edit_file() { exec tmux popup -E "${EDITOR:-vi} $cachefile"; }

main() {
	! [ -f "$cachefile" ] && touch "$cachefile"
	while getopts ":haAr:R:d:ls:e" opt; do
		case "$opt" in
		h | :) help && exit 0 ;;
		a | A) add ;;
		r | R) replace "$OPTARG" ;;
		d) remove "$OPTARG" ;;
		l) view ;;
		s) switch "$OPTARG" ;;
		e) edit_file ;;
		\?) help && exit 1 ;;
		esac
	done
}

main "$@"
