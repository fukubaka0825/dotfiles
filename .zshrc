# JAVA_HOME
export JAVA_HOME=$(/usr/libexec/java_home -v 11)


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
export PATH="$HOME/Library/Python/2.7/bin:$PATH"


source ~/.zplug/init.zsh

# Make sure to use double quotes
zplug "zsh-users/zsh-history-substring-search"

# Use the package as a command
# And accept glob patterns (e.g., brace, wildcard, ...)
zplug "Jxck/dotfiles", as:command, use:"bin/{histuniq,color}"

# Can manage everything e.g., other person's zshrc
zplug "tcnksm/docker-alias", use:zshrc

# Disable updates using the "frozen" tag
zplug "k4rthik/git-cal", as:command, frozen:1

# Grab binaries from GitHub Releases
# and rename with the "rename-to:" tag
zplug "junegunn/fzf", \
    from:gh-r, \
    as:command, \
    use:"*darwin*amd64*"

# Supports oh-my-zsh plugins and the like
zplug "plugins/git",   from:oh-my-zsh

# Also prezto
zplug "modules/prompt", from:prezto

# Load if "if" tag returns true
zplug "lib/clipboard", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"

# Run a command after a plugin is installed/updated
# Provided, it requires to set the variable like the following:
# ZPLUG_SUDO_PASSWORD="********"
zplug "jhawthorn/fzy", \
    as:command, \
    rename-to:fzy, \
    hook-build:"make && sudo make install"

# Supports checking out a specific branch/tag/commit
zplug "b4b4r07/enhancd", at:v1
zplug "mollifier/anyframe", at:4c23cb60

# Can manage gist file just like other packages
zplug "b4b4r07/79ee61f7c140c63d2786", \
    from:gist, \
    as:command, \
    use:get_last_pane_path.sh

# Support bitbucket
zplug "b4b4r07/hello_bitbucket", \
    from:bitbucket, \
    as:command, \
    use:"*.sh"

# Rename a command with the string captured with `use` tag
zplug "b4b4r07/httpstat", \
    as:command, \
    use:'(*).sh', \
    rename-to:'$1'

# Group dependencies
# Load "emoji-cli" if "jq" is installed in this example
zplug "stedolan/jq", \
    from:gh-r, \
    as:command, \
    rename-to:jq
zplug "b4b4r07/emoji-cli", \
    on:"stedolan/jq"
# Note: To specify the order in which packages should be loaded, use the defer
#       tag described in the next section

# Set the priority when loading
# e.g., zsh-syntax-highlighting must be loaded
# after executing compinit command and sourcing other plugins
# (If the defer tag is given 2 or above, run after compinit command)
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Can manage local plugins
zplug "~/.zsh", from:local

# Load theme file
zplug 'dracula/zsh', as:theme

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

PROMPT="%D %* %d %#"
