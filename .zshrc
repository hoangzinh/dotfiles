# Path to your oh-my-zsh installation.
export ZSH=/Users/devops/.oh-my-zsh
ZSH_THEME="my-theme"
plugins=(git ruby heroku bundler)
source $ZSH/oh-my-zsh.sh

# User configuration
export PATH="/Users/devops/.rbenv/shims:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/devops/.rbenv/shims"
export EDITOR='vim'
export BUNDLER_EDITOR='subl'

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias config="vim ~/.zshrc"
alias reload="source ~/.zshrc"
alias bo='reattach-to-user-namespace bundle open'
