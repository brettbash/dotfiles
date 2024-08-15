set fish_greeting "ネオンフィッシュ"

set -gx TERM xterm-256color

# Aliases
alias fishload "source ~/.config/fish/config.fish"
alias tmuxinit "TERM=screen-256color-bce tmux"
alias clear "TERM=xterm /usr/bin/clear"
alias g git
alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
alias c clear
alias t "task list"
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
# set -g fish_prompt_pwd_dir_length 0
set -g theme_display_user yes

set -g tide_os_bg_color fede5d
set -g tide_os_color 000000
set -g tide_os_icon 👽 - 碌- バッシュ
set -g tide_os_icon 👽

# ::-- PWD -------------------------:: //
set -g tide_pwd_bg_color 191726
set -g tide_pwd_color_ancors ff00ff
set -g tide_pwd_color_dirs ff7edb

set -g tide_pwd_bg_color 191726
set -g tide_pwd_color_ancors 191726
set -g tide_pwd_color_dirs 191726
set -g tide_pwd_color_truncated_dirs 191726

set -g tide_pwd_icon_home 🔮
set -g tide_pwd_icon 💀

set -g tide_git_bg_color 72f1b8
set -g tide_git_bg_color_unstable 03edf9
set -g tide_git_icon 

set -g tide_status_bg_color A148AB
set -g tide_status_color 72f1b8
set -g tide_status_icon 

set -g tide_time_bg_color bd93f9
set -g tide_time_color 1a1836
