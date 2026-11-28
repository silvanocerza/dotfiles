# Fish conversion of zsh/zshrc
# Kept intentionally in the same order as zshrc where it makes sense.

# Start X11 if we're on tty1 and no graphical session is up yet
if command -q systemctl
    and systemctl -q is-active graphical.target
    and not set -q DISPLAY
    and set -q XDG_VTNR
    and test "$XDG_VTNR" -eq 1
    exec startx
end

# Checks if running on WSL, there's no DISPLAY env var on WSL
# so this is the only way to run tmux straight away
if grep -qE "(Microsoft|WSL|Windows)" /proc/version 2>/dev/null
    if test -z "$TMUX"
        command -q tmux; and tmux
    end
end

# Launches tmux if not already inside
if test -n "$DISPLAY"; and test -z "$TMUX"; and command -q tmux
    tmux
end

# I hate that I need to do this shit ffs
# Fucking GitHub
set -gx GH_TELEMETRY false
set -gx DO_NOT_TRACK true

# ssh-agent: reuse a saved agent across fish sessions, start one if needed.
# Never loads keys itself (no prompt/block): Plasma's ssh-add autostart or a
# manual `ssh-add` handles that.
function _start_ssh_agent
    set -l env_file ~/.ssh/agent.fish

    if test -f $env_file
        source $env_file
        if set -q SSH_AUTH_SOCK; and test -S $SSH_AUTH_SOCK
            return 0
        end
    end

    ssh-agent -c \
        | sed -n 's/^setenv \(SSH_AUTH_SOCK\|SSH_AGENT_PID\) \(.*\);/set -gx \1 \2/p' \
        | tee $env_file \
        | source
end

if not set -q SSH_AUTH_SOCK; or not test -S "$SSH_AUTH_SOCK"
    _start_ssh_agent
end

set -gx VISUAL vim

# Common aliases (matching the oh-my-zsh defaults)
function l --wraps ls --description 'alias l ls -lah'
    ls -lah $argv
end
function ll --wraps ls --description 'alias ll ls -lh'
    ls -lh $argv
end
function la --wraps ls --description 'alias la ls -lAh'
    ls -lAh $argv
end
function g --wraps git --description 'alias g git'
    git $argv
end

# I don't want rg to be a smartass
function rg --wraps rg
    command rg -uu $argv
end

# Loads Homebrew
if test -d /opt/homebrew/bin/
    set -gx PATH $PATH /opt/homebrew/bin
end

# Colored ls (dircolors is GNU-only; fish uses LS_COLORS)
if command -q dircolors; and test -f $HOME/.dircolors
    dircolors -c $HOME/.dircolors | string replace "setenv LS_COLORS" "set -gx LS_COLORS" | source
end

# fd must do what I want it to do and not be a smartass
function fd --wraps fd
    command fd --hidden --no-ignore $argv
end

# fzf configs
if test -f /usr/share/fzf/key-bindings.fish
    source /usr/share/fzf/key-bindings.fish
end
if test -f ~/.fzf.fish
    source ~/.fzf.fish
end
if command -q fzf
    fzf --fish | source
end

# Uses fd as default command showing also hidden files
set -gx FZF_DEFAULT_COMMAND "fd --hidden --no-ignore"

# ctrl+o opens Visual Studio Code on current folder or file
set -gx FZF_DEFAULT_OPTS "--bind='ctrl-o:execute-silent(code {})+abort'"

# If current selection is a text file shows its content,
# if it's a directory shows its content, the rest is ignored.
# (Preview runs through $SHELL, so keep the snippet POSIX/sh.)
set -gx FZF_CTRL_T_OPTS "--preview-window wrap --preview 'if [ -f {} ]; then file --mime {} | grep -q \"text/\" && bat --color always {} || (tput setaf 1; file --mime {}); elif [ -d {} ]; then ls -l --color=auto {}; else tput setaf 1; echo YOU ARE NOT SUPPOSED TO SEE THIS!; fi'"

# Golang
if command -q go
    set -gx GOPATH $HOME/go
    set -gx PATH $PATH (go env GOPATH)/bin
end

if test -d $HOME/.local/bin
    set -gx PATH $PATH $HOME/.local/bin
end

# XAuthority
if test -f $HOME/.Xauthority
    set -gx XAUTHORITY $HOME/.Xauthority
end

if test -d /usr/lib/jvm/java-8-openjdk
    set -gx JAVA_HOME /usr/lib/jvm/java-8-openjdk
end

if test -d /opt/homebrew/opt/openjdk
    set -gx PATH /opt/homebrew/opt/openjdk/bin $PATH
end

# Binaries installed with Yarn
set -gx PATH $PATH $HOME/.yarn/bin

# Dart
if test -d /usr/lib/dart/bin
    set -gx PATH $PATH /usr/lib/dart/bin
end

# Flutter
set -gx PATH $PATH $HOME/flutter/bin

# Rust
if test -d $HOME/.cargo/bin
    set -gx PATH $HOME/.cargo/bin $PATH
end

# Overrides all system tools with ones installed by brew
if test -d /opt/homebrew/bin
    set -gx PATH /opt/homebrew/bin $PATH
end

if command -q direnv
    direnv hook fish | source
end

if command -q jenv
    jenv init - | source
end

if command -q pyenv
    set -gx PYENV_ROOT "$HOME/.pyenv"
    set -gx PATH $PYENV_ROOT/bin $PATH
    pyenv init - | source
end

if command -q aws_completer
    set -gx PATH (string dirname (command aws_completer)) $PATH
    complete -c aws -f -a '(begin; set -lx COMP_SHELL bash; set -lx COMP_LINE (commandline -cp); command aws_completer; end)'
end

if command -q zoxide
    zoxide init fish | source
end

if command -q hatch
    function h --wraps hatch
        hatch $argv
    end
end

# pnpm (macOS)
if test -d $HOME/Library/pnpm
    set -gx PNPM_HOME $HOME/Library/pnpm
    set -gx PATH $PATH $PNPM_HOME
end

# Disable stupidly annoying homebrew auto updating when I just want to install a single package
set -gx HOMEBREW_NO_AUTO_UPDATE 1

if command -q jj
    jj util completion fish | source
end

# Initialise Ruby version manager if found
if command -q rbenv
    rbenv init - | source
end

# Initialise Perl version manager if found
if command -q plenv
    plenv init - | source
end

function claude
    set -l profile $argv[1]

    if test -z "$profile"
        echo "Usage: claude <profile>" >&2
        echo "Example: claude personal" >&2
        return 1
    end

    if string match -q -- '-*' $profile
        echo "Error: profile name cannot start with '-'" >&2
        return 1
    end

    set -l config_dir $HOME/.claude-$profile
    mkdir -p $config_dir

    CLAUDE_CONFIG_DIR=$config_dir command claude $argv[2..-1]
end

# bun
if test -d "$HOME/.bun/bin"
    set -gx BUN_INSTALL "$HOME/.bun"
    set -gx PATH $BUN_INSTALL/bin $PATH
end
