# Return if zsh is called from Vim
# if [[ -n $VIMRUNTIME ]]; then
#     return 0
# fi

if [[ -x ~/bin/tmuxx ]]; then
    ~/bin/tmuxx
fi

source <(pkg load)

printf "\n"
printf "${fg_bold[cyan]} ${SHELL} ${fg_bold[red]}${ZSH_VERSION}"
printf "${fg_bold[cyan]} - DISPLAY on ${fg_bold[red]}${TMUX:+$(tmux -V)}${reset_color}\n\n"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH o Path to your oh-my-zsh installation.
export ZSH="/Users/takafk9/.oh-my-zsh"
# setting peco
bindkey '^]' peco-src

function peco-src(){
  local src=$(ghq list --full-path | peco --query "$LBUFFER")
  if [ -n"$src" ]; then
    BUFFER="cd $src"
    zle accept-line
  fi
  zle -R -c
}
zle -N peco-src


# can use hub
eval "$(hub alias -s)"

# gtag
alias gtag='git tag -l --sort=version:refname "*"'

# pi用の環境変数
export DEVICE_ID=ca0001ce-fe73-e13c-e7aa-c9d19272a23f
export AUTHORIZATION_TOKEN="v3HS8MVtQmeSIfUUxP9JlTDaKl0A-rSX8D9sW3LFAImOE65ov8claascrWCZn33emMdziWYE0TNs"
export PASSWORD=password

# gitを禁止する
# alias git='imgcat ~/pictures/gopher.jpeg'

[[ -d ~/.rbenv  ]] && \
  export PATH=${HOME}/.rbenv/bin:${PATH} && \
  eval "$(rbenv init -)"


# goの設定
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export GO111MODULE=on
export GOENV_DISABLE_GOPATH=1; export GOENV_DISABLE_GOROOT=1
export GOPATH=$HOME/go
export GONOPROXY=bitbucket.org/wanocoltd
export GOPRIVATE=bitbucket.org/wanocoltd
export GOPROXY=https://proxy.golang.org
export GONOSUMDB=bitbucket.org/wanocoltd

# cd魔改造
# function gocd(){
#  \cd $1;
#  source ~/project/udemy/demo/gopher.sh;
# }
# alias cd=gocd
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/candy/oh-my-zsh/wiki/Themes
ZSH_THEME="candy"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "candy" "agnoster" )

# direnvの設定
export EDITOR=vim
eval "$(direnv hook zsh)"

# pathを1.12.4のbinにも
export PATH=$PATH:$HOME/go/1.12.4/bin
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
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
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting zsh-completions)
# ゴミ箱にrm
alias rm="rmtrash"

# zsh-completionsの設定
autoload -U compinit && compinit -u

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

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#export PATH=/usr/local/Cellar/openssl/1.0.2q/bin:$PATH
export PATH="/usr/local/opt/openssl/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"

# goenv setting
export GOENV_ROOT=$HOME/.goenv
export PATH=$GOENV_ROOT/bin:$PATH
eval "$(goenv init -)"

# gopath
export GOPATH=$HOME/go
PATH=$PATH:$GOPATH/bin
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

# direnv
eval "$(direnv hook zsh)"