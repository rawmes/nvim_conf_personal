# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

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
# Standard plugins can be found in $ZSH/plugins/ # Custom plugins may be added to $ZSH_CUSTOM/plugins/ # Example format: plugins=(rails git textmate ruby lighthouse) # Add wisely, as too many plugins slow down shell startup.  
plugins=(git zsh-syntax-highlighting autojump zsh-autosuggestions you-should-use fzf emoji-clock git-extras macos git-open)
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
alias avdm="/Users/mariosaan/Library/Android/sdk/emulator/emulator"
alias start-td="avdm -avd test-device"
alias start-rtd="avdm -avd test-resizable"
alias cls="clear"
alias zconf="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias nconf="cd ~/.config/nvim && nvim ."
alias dir="ls"
alias callbreak="cd /Users/mariosaan/projects/teslatech/callbreakgodot"
alias n="nvim ."
alias reset-users="/Users/mariosaan/projects/teslatech/callbreakgodot/scripts/reset_users.sh"
alias rungame="/Users/mariosaan/projects/teslatech/callbreakgodot/run.sh"
alias preview="kitten icat" #uselss command to preview image
alias gop="git open" #opens the current working branch in remote that is if its not merged already.. take care
alias goc="git open -c" # opens the last commit in the branc in remote .. open web browser and goes to link or something stuff.. u get it
alias poke="pokemon-colorscripts --random" #echos random pokemon colored
alias rface="kitten icat https://thispersondoesnotexist.com/" #useless shit. prints random ai generated face
alias gslb="git branch | fzf |xargs -t -I {} git switch '{}'" # switches to localbranch using fzf search so i dont have to type that shit out or something
alias gdmb="git branch --merged | grep -v \* | xargs git branch -D " #deletes remote merged brances from local, dont know what happens when you are in the merged branch locally while running this command. and i am too lazy to find out... u find out yourself

eval "$(zoxide init zsh)"
export PATH="$HOME/scripts/:$HOME/projects/teslatech/callbreakserver/scripts/docker":$PATH
export GODOT_BIN="/usr/local/bin/godot"
export DYLD_FALLBACK_LIBRARY_PATH="$(brew --prefix)/lib:$DYLD_FALLBACK_LIBRARY_PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias gsrb='
  branch=$(git branch -r --no-merged | grep -v "\->" | sed "s#  origin/##" | fzf)
  if [ -z "$branch" ]; then
    echo "No branch selected."
  else
    local_branch=$(echo "$branch" | sed "s#^origin/##")
	echo "$local_branch"
    if git show-ref --verify --quiet refs/heads/"$local_branch"; then
	  echo "local"
      git switch "$local_branch"
    else
	  echo "remote"
	  wait git fetch
      git switch "$local_branch"
    fi
  fi
'
alias gclb='
  # Fetch the latest updates from the remote repository
  git fetch --prune

  # Iterate over each local branch
  for branch in $(git for-each-ref --format="%(refname:short)" refs/heads/); do
    # Check if the local branch has a corresponding upstream branch
    upstream=$(git for-each-ref --format="%(upstream:short)" refs/heads/"$branch")
    if [ -n "$upstream" ]; then
      # Check if the local branch is up-to-date with its upstream
      if [ "$(git rev-parse "$branch")" = "$(git rev-parse "$upstream")" ]; then
        # Delete the local branch
        git branch -d "$branch"
      fi
    fi
  done
'
