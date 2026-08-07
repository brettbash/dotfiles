#!/usr/bin/env bash
#
# 󱚥 CRUSH WATCH — one robot per running Crush instance, colored by state
#
# Detection: each Crush instance's project db (.crush/crush.db) holds the
# truth. Last assistant message unfinished = generating. Finished with
# reason tool_use = tool phase; a crush child process younger than the
# tool phase (or elevated CPU) = executing, otherwise a dialog is up.
# Anything else = ready.

C_READY='#03edf9'
C_WORK='#ff7edb'
C_WAIT='#e5fe5d'
C_GHOST='#5f3fff'

I_ROBOT='󱚤'
I_GHOST='🜏'
I_WORK='󱐋'
I_READY=''
I_WAIT=''

CACHE="/tmp/crush-status-cwd-cache"
STALE_GEN_SECS=180
CPU_BUSY=5.0

# One ps snapshot for everything: crush pids, their children, etimes, CPU.
# (pgrep is unusable here: BSD pgrep silently excludes its own ancestors.)
PS_SNAPSHOT=$(ps -axo pid=,ppid=,etime=,%cpu=,comm=)

pids=$(awk '$5 ~ /(^|\/)crush$/ { print $1 }' <<<"$PS_SNAPSHOT" | sort -n)
[ -z "$pids" ] && printf '#[fg=%s,bg=default,nobold]%s#[default]' "$C_GHOST" "$I_GHOST" && exit 0

# ── pid → cwd (lsof is slow; cache it) ────────────────────────────────
declare -A CWD
if [ -f "$CACHE" ]; then
	while IFS=$'\t' read -r p c; do
		[ -n "$p" ] && CWD[$p]=$c
	done <"$CACHE"
fi

unknown=""
for p in $pids; do
	[ -z "${CWD[$p]:-}" ] && unknown+="${unknown:+,}$p"
done
if [ -n "$unknown" ]; then
	cur=""
	while IFS= read -r line; do
		case $line in
		p*) cur=${line#p} ;;
		n*) CWD[$cur]=${line#n} ;;
		esac
	done < <(lsof -a -p "$unknown" -d cwd -Fn 2>/dev/null)
fi

for p in $pids; do
	[ -n "${CWD[$p]:-}" ] && printf '%s\t%s\n' "$p" "${CWD[$p]}"
done >"$CACHE"

# ── etime ([[dd-]hh:]mm:ss) → seconds ─────────────────────────────────
etime_secs() {
	echo "$1" | awk -F'[-:]' '{
		if (NF == 4)      print $1*86400 + $2*3600 + $3*60 + $4
		else if (NF == 3) print $1*3600 + $2*60 + $3
		else              print $1*60 + $2
	}'
}

now=$(date +%s)
out=""

for pid in $pids; do
	state="ready"
	cwd=${CWD[$pid]:-}
	db="$cwd/.crush/crush.db"

	if [ -n "$cwd" ] && [ -f "$db" ]; then
		IFS='|' read -r verdict tool_start upd_age <<<"$(sqlite3 -readonly "$db" "
			WITH latest AS (
				SELECT COALESCE(parent_session_id, id) AS root
				FROM sessions
				ORDER BY (CASE WHEN updated_at > 100000000000 THEN updated_at ELSE updated_at * 1000 END) DESC
				LIMIT 1
			),
			fam AS (
				SELECT s.id FROM sessions s, latest l
				WHERE s.id = l.root OR s.parent_session_id = l.root
			),
			m AS (
				SELECT finished_at, updated_at, parts FROM messages
				WHERE session_id IN (SELECT id FROM fam) AND role = 'assistant'
				ORDER BY created_at DESC LIMIT 1
			)
			SELECT
				CASE WHEN finished_at IS NULL THEN 'gen'
					ELSE COALESCE((SELECT json_extract(j.value, '\$.data.reason')
						FROM json_each(m.parts) AS j
						WHERE json_extract(j.value, '\$.type') = 'finish'
						LIMIT 1), 'unknown') END,
				CASE WHEN COALESCE(finished_at, 0) > 100000000000
					THEN finished_at / 1000 ELSE COALESCE(finished_at, 0) END,
				strftime('%s', 'now') - (CASE WHEN updated_at > 100000000000
					THEN updated_at / 1000 ELSE updated_at END)
			FROM m;" 2>/dev/null)"

		case "$verdict" in
		gen)
			if [ "${upd_age:-999999}" -lt "$STALE_GEN_SECS" ]; then
				state="working"
			fi
			;;
		tool_use)
			# A child process born after the tool phase began means the
			# tool is executing. LSP/MCP servers are older and ignored.
			while read -r _ _ et _; do
				[ -z "$et" ] && continue
				child_start=$((now - $(etime_secs "$et")))
				if [ "$child_start" -ge $((tool_start - 3)) ]; then
					state="working"
					break
				fi
			done < <(awk -v p="$pid" '$2 == p' <<<"$PS_SNAPSHOT")
			if [ "$state" != "working" ]; then
				cpu=$(awk -v p="$pid" '$1 == p { print $4 }' <<<"$PS_SNAPSHOT")
				if awk -v c="${cpu:-0}" -v t="$CPU_BUSY" 'BEGIN { exit !(c >= t) }'; then
					state="working"
				else
					state="waiting"
				fi
			fi
			;;
		esac
	fi

	echo "$(date +%s) pid=$pid verdict=${verdict:-none} upd_age=${upd_age:-none} state=$state" >>/tmp/crush-status-debug.log
	case "$state" in
	working) seg="#[fg=$C_WORK,bg=default,nobold]$I_ROBOT $I_WORK" ;;
	waiting) seg="#[fg=$C_WAIT,bg=default,nobold]$I_ROBOT $I_WAIT" ;;
	*) seg="#[fg=$C_READY,bg=default,nobold]$I_ROBOT $I_READY" ;;
	esac
	out+="${out:+  }$seg"
done

[ -n "$out" ] && printf '%s#[default]' "$out"
