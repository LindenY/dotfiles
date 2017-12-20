
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time root_indicator background_jobs time)
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='black'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='003'


# Load zplug, clone if not found
if [[ ! -d ~/.zplug ]];then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

source ~/.zplug/init.zsh

zplug "robbyrussell/oh-my-zsh", use:"lib/*.zsh", defer:0
zplug "plugins/git",   from:oh-my-zsh
#zplug "plugins/brew",   from:oh-my-zsh
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme
zplug "zsh-users/zsh-completions"
zplug "tarruda/zsh-autosuggestions"
zplug "teancom/k"

# auto-closes, deletes and skips over matching delimiters in zsh intelligently
zplug "hlissner/zsh-autopair", defer:2, if:"[[ $OSTYPE == *darwin* ]]"

export CACHE_DIR="${HOME}/.cache"
[[ ! -d "${CACHE_DIR}" ]] && mkdir -p "${CACHE_DIR}"
fasd_cache="${CACHE_DIR}/fasd-init-cache"
zplug "clvv/fasd", \
    as:command, \
    use:fasd, \
    hook-build:"./fasd --init auto >| $fasd_cache"

zplug "zdharma/fast-syntax-highlighting", defer:2

zplug "zsh-users/zsh-history-substring-search", defer:3

# Let zplug manage itself, has bug so not enabled
#zplug "zplug/zplug", hook-build:'zplug --self-manage'

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# fasd
source "$fasd_cache"
unset fasd_cache

# autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'

# source .porfile
source ~/.profile
