# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="jaischeema"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time


# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git colored-man-pages)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias tangit=git
alias prrrrrr="npx tsx ~/poc/azure-automatize/src/index.ts"
#alias prrrrrr='(cd ~/poc/azure-automatize/src && npx tsx index.ts)'



export PATH="$HOME/.symfony5/bin:$PATH"

# Android config.
export ANDROID_HOME="/opt/android-sdk"
export PATH="$PATH:$ANDROID_HOME/tools"
export PATH="$PATH:$ANDROID_HOME/platform-tools"

alias hyprland="start-hyprland"

export CLASSPATH=.:/usr/share/tomcat10/lib/*
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk

export PATH=$HOME/.local/bin:$PATH

# pnpm
export PNPM_HOME="/home/neo/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# bun completions
[ -s "/home/neo/.bun/_bun" ] && source "/home/neo/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# cabal
export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"

# flutter
export PATH="$HOME/flutter/bin:$PATH"
# pub dart
export PATH="$PATH":"$HOME/.pub-cache/bin"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$HOME/.pyenv/shims:$PATH"

[ -f ~/.config/kitty/shell-integration/zsh/kitty-integration ] && source ~/.config/kitty/shell-integration/zsh/kitty-integration


# pdftex
export PATH="/usr/local/texlive/2025/bin/x86_64-linux:$PATH"
export PATH=$PATH:/home/neo/.venv/bin



export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add JBang to environment
alias j!=jbang
export PATH="$HOME/.jbang/bin:$PATH"

# opencode
export PATH=/home/neo/.opencode/bin:$PATH

# CLAUDE
alias claude-perso="CLAUDE_CONFIG_DIR=~/.claude-perso command claude"
alias claude-taf="CLAUDE_CONFIG_DIR=~/.claude-taf command claude"
alias claude="echo 'Utilise claude-perso ou claude-taf'"


# airpods
alias airpods-music="pactl set-card-profile bluez_card.74_3F_8E_89_C1_FE a2dp-sink"
alias airpods-call="pactl set-card-profile bluez_card.74_3F_8E_89_C1_FE headset-head-unit"

# ssh -> wrap from kitty to aliasing the zshrc to the remote session
[[ "$TERM" == "xterm-kitty" ]] && alias ssh='kitten ssh'

# Supprime les branches locales dont la remote a été supprimée (merge + delete)
# Usage : gprune        → suppression safe (-d)
#         gprune -D     → force la suppression des branches non mergées
gprune() {
    git fetch --prune
    git branch -vv | awk '/: gone]/ && $1 != "*" {print $1}' | xargs -r git branch "${1:--d}"
}

# Config propre à cette machine ou au travail, non versionnée
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
