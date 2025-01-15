set fish_greeting "ネオンフィッシュ"

set -gx TERM xterm-256color

# Aliases
alias fishload "source ~/.config/fish/config.fish"
alias tmuxinit "set TERM tmux-256color && tmux"
alias clear "TERM=xterm /usr/bin/clear"
alias g git
alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
alias c clear
alias neomail neomutt
alias pint "./vendor/bin/pint"
alias notes "cd ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/バッシュ"
command -qv vim && alias vim nvim

# alias finder "open -R $(fzf --height 40%)"
# open . --> This can just open the current directory (pwd) in Finder

alias tw task
alias twa "task add "
alias tmw timew
alias tmws "timew start "
alias tmwc "timew continue "
alias tmwp "timew stop"
alias tmwm "timew modify "
alias tmwst "timew summary :ids today"
alias tmwsy "timew summary :ids yesterday"
alias tmwsw "timew summary :ids week"
alias tmwsm "timew summary :ids month"
alias tmwsq "timew summary :ids quarter"
alias tmwsum "timew summary :ids "

if type -q eza
    alias ll "eza -l -g --icons"
    alias lla "ll -a"
end

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH

function fish_user_key_bindings
    fish_vi_key_bindings
end

# Tmux
fish_add_path $HOME/.tmux/plugins/t-smart-tmux-session-manager/bin

# NodeJS
set -gx PATH node_modules/.bin $PATH
# Herd
# fish_add_path -U $HOME/Library/Application\ Support/Herd/bin/

# π ---------------------------------------------------------//
# // :: THEME
# // : ----------------------------------------------------- #}
set -U fish_prompt_pwd_dir_length 50
set -U theme_display_user yes

set -U tide_os_bg_color fede5d
set -U tide_os_color 000000
set -U tide_os_icon 👽 - 碌- バッシュ
#set -U tide_os_icon 👽

set -U tide_pwd_bg_color 463465
set -U tide_pwd_color 463465
set -U tide_pwd_color_truncated_dirs 00ffff
set -U tide_pwd_color_dirs 03edf9
set -U tide_pwd_color_anchors e5fe5d
set -U tide_pwd_anchors italic
set -U tide_pwd_icon_home 🔮
set -U tide_pwd_icon 💀

set -U tide_vi_mode_bg_color_default 5f3fff
set -U tide_vi_mode_color_default ffffff
set -U tide_vi_mode_icon_default 󰊠
set -U tide_vi_mode_bg_color_insert ff00ff
set -U tide_vi_mode_color_insert ffffff
set -U tide_vi_mode_icon_insert 󰢚
set -U tide_vi_mode_bg_color_replace 038AF9
set -U tide_vi_mode_color_replace ffffff
set -U tide_vi_mode_icon_replace 󱥒
set -U tide_vi_mode_bg_color_visual 03edf9
set -U tide_vi_mode_icon_visual 

set -U tide_git_bg_color 72f1b8
set -U tide_git_bg_color_unstable ff8b39
set -U tide_git_icon 
#
set -U tide_status_bg_color 191726
set -U tide_status_bg_color_failure fe4450
set -U tide_status_color 72f1b8
set -U tide_status_color_failure ffffff
set -U tide_status_icon  ╶┄┄
set -U tide_status_icon_failure 

set -U tide_cmd_duration_bg_color fede5d

set -U tide_node_bg_color 7ee787
set -U tide_php_bg_color 3F59FF
set -U tide_php_color ffefae

set -U tide_time_bg_color ff7edb
set -U tide_time_color 191726
