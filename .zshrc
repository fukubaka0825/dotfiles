# JAVA_HOME
export JAVA_HOME=$(/usr/libexec/java_home -v 11)

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

# kubectl
alias k=kubectl

# STS KEY BROKERRRRRRRRRRR
alias sts_stage_engage='cd ~/src/github.com/eure/arch/scripts/aws && ./get_sts.sh -a stage-engage -u takashi.narikawa -r infra_developer;cd -'
alias sts_prod_engage='cd ~/src/github.com/eure/arch/scripts/aws && ./get_sts.sh -a prod-engage -u takashi.narikawa -r infra_developer;cd -'
alias sts_pairs_jp='cd ~/src/github.com/eure/arch/scripts/aws && ./get_sts.sh -a pairs-jp -u takashi.narikawa -r infra_developer;cd -'
alias sts_eureka='cd ~/src/github.com/eure/arch/scripts/aws && ./get_sts.sh -a eureka -u takashi.narikawa -r infra_developer;cd -'
alias sts_eureka_shindan_pairs='cd ~/src/github.com/eure/arch/scripts/aws && ./get_sts.sh -a eureka-shindan-pairs -u takashi.narikawa -r infra_developer;cd -'
alias sts_eureka_paid='cd ~/src/github.com/eure/arch/scripts/aws && ./get_sts.sh -a eureka-paid -u takashi.narikawa -r infra_developer;cd -'
alias sts_prod_wordpress='cd ~/src/github.com/eure/arch/scripts/aws && ./get_sts.sh -a prod-wordpress -u takashi.narikawa -r infra_developer;cd -'
alias sts_stage_wordpress='cd ~/src/github.com/eure/arch/scripts/aws && ./get_sts.sh -a stage-wordpress -u takashi.narikawa -r infra_developer;cd -'
alias sts_couples='cd ~/src/github.com/eure/arch/scripts/aws && ./get_sts.sh -a couples -u takashi.narikawa -r infra_developer;cd -'
alias sts_eureka_sandbox='cd ~/src/github.com/eure/arch/scripts/aws && ./get_sts.sh -a eureka-sandbox -u takashi.narikawa -r infra_developer;cd -'
alias sts_eureka_sec='cd ~/src/github.com/eure/arch/scripts/aws && ./get_sts.sh -a eureka-security -u takashi.narikawa -r infra_developer;cd -'
alias sts_eureka_mis='cd ~/src/github.com/eure/arch/scripts/aws && ./get_sts.sh -a eureka-mis -u takashi.narikawa -r infra_developer;cd -'
alias sts_stage_mg_mod='cd ~/src/github.com/eure/arch/scripts/aws && ./get_sts.sh -a stage-mg-eureka-moderation -u takashi.narikawa -r infra_developer;cd -'
alias sts_prod_mg_mod='cd ~/src/github.com/eure/arch/scripts/aws && ./get_sts.sh -a prod-mg-eureka-moderation -u takashi.narikawa -r infra_developer;cd -'
alias sts_prod_middle='cd ~/src/github.com/eure/arch/scripts/aws && ./get_sts.sh -a prod-pairsmiddle -u takashi.narikawa -r infra_developer;cd -'
alias sts_stage_middle='cd ~/src/github.com/eure/arch/scripts/aws && ./get_sts.sh -a stage-pairsmiddle -u takashi.narikawa -r infra_developer;cd -'

alias ssm_port_forwarder.sh="$HOME/src/github.com/eure/utility-scripts/aws/gateway/ssm_port_forwarder.sh"
alias ssm_gateway_connector.sh="$HOME/src/github.com/eure/utility-scripts/aws/gateway/ssm_gateway_connector.sh"
# rbenv
eval "$(rbenv init -)"

function _func_dfimage() {
    IMAGE="$1"
    BASE_IMAGE=`docker inspect -f "{{len .RepoDigests }}" $IMAGE`
    if [ $BASE_IMAGE -eq 0 ]; then
        BASE_IMAGE=`docker inspect -f "{{ .Config.Image }}" $IMAGE`
    else
        BASE_IMAGE=`docker inspect -f "{{index .RepoDigests 0}}" $IMAGE`
    fi
    
    USER="root"
    if [ -n "$2" ]; then
        USER="$2"
    fi
    
    # Print base image
    echo "FROM $BASE_IMAGE"

    # Get bash history commands
    docker run -it -u $USER $IMAGE cat /USERS/takashi.narikawa/.zhistory | sed 's/\r$//g' > .tmp.txt
    HEAD_CMD=$(head -n 1 .tmp.txt)
    sed -i '1d' .tmp.txt
    TAIL_CMD=$(tail -n 1 .tmp.txt)
    sed -i '$d' .tmp.txt

    # make commands
    echo "RUN $HEAD_CMD && \\"
    cat .tmp.txt | while read cmd; do
        cmd=`echo $cmd | sed -e 's/apt\-get/apt/g' -e 's/apt/apt\ \-y/g'`
        if [ "$cmd" = "ls" ]; then
            continue
        fi
        echo "    $cmd && \\"
    done
    echo "    $TAIL_CMD"

    # Delete tempolary file
    rm .tmp.txt
}

alias dfimage=_func_dfimage

# go
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin

# direnv
eval "$(direnv hook zsh)"

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

# setting hbrl
bindkey '^[' hbrl-src

function hbrl-src(){
  local src=$(hbrl)
  if [ -n"$src" ]; then
    BUFFER="cd $src"
    zle accept-line
  fi
  zle -R -c
}
zle -N hbrl-src

# gtag
alias gtag='git tag -l --sort=version:refname "*"'

# goの設定
export GOPATH=$HOME/src
export PATH=$PATH:$GOPATH/bin
export GO111MODULE=on
export GOENV_DISABLE_GOPATH=1; export GOENV_DISABLE_GOROOT=1

# export GONOPROXY=bitbucket.org/wanocoltd
# export GOPRIVATE=bitbucket.org/wanocoltd
# export GOPROXY=https://proxy.golang.org
# export GONOSUMDB=bitbucket.org/wanocoltd


ZSH_THEME="candy"
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

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
export ZSH=$HOME/.oh-my-zsh
 
plugins=(git)
source $ZSH/oh-my-zsh.sh

bindkey "^p" history-beginning-search-backward
bindkey "^n" history-beginning-search-forward
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

# 現在の作業リポジトリをブラウザで表示する
alias hbr='hub browse'

# リポジトリの一覧の中からブラウザで表示したい対象を検索・表示する
alias hbrl='hub browse $(ghq list | peco | cut -d "/" -f 2,3)'

# リポジトリのディレクトリへ移動
alias gcd='cd $(ghq root)/$(ghq list | peco)'

alias rm='rmtrash'

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
export PATH="$HOME/Library/Python/2.7/bin:$PATH"

# The next line enables shell command completion for gcloud.
if [ -f '/Users/takashi.narikawa/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/takashi.narikawa/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
