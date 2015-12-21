# Path to your oh-my-zsh installation.
export ZSH=/Users/devops/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="my-theme"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git ruby heroku bundler)

# User configuration

export PATH="/Users/devops/.rbenv/shims:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/devops/.rbenv/shims"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

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
# export SSH_KEY_PATH="~/.ssh/dsa_id"

#Function
my_current_date () {
        echo `date +'%d-%m-%y'`
}

app_mapping () {
        case "$1" in
                ("eh"|"employmenthero") happ="employmenthero"  ;;
                ("eh-jobs") happ="eh-jobs"  ;;
                (*) happ=$1  ;;
        esac
}

hbk () {
        if [ $# -ne 1 ]
        then
                echo "Need a heroku app input"
        else
                app_mapping $1
                heroku pg:backups capture --app $happ
        fi
}

hbkshow () {
        if [ $# -ne 1 ]
        then
                echo "Need a heroku app input"
        else
                app_mapping $1
                heroku pg:backups --app $happ
        fi
}

hbkdl () {
        if [ $# -ne 2 ]
        then
                echo "Need a backup id & heroku app"
        else
                app_mapping $2
                current_date=$(my_current_date)
                heroku pg:backups public-url $1 --app $happ
                curl -o "/Users/devops/Downloads/pg_backups/$happ-$current_date.dump" `heroku pg:backups public-url -a $happ`
        fi
}

dbres () {
        if [ $# -lt 1 ]
        then
                echo "Need project name <eh, eh-jobs>"
        else
                app_mapping $1
                if [ -z "$2" ]
                then
                        current_date=$(my_current_date)
                else
                        current_date=$2
                fi
                pg_restore --verbose --clean --no-acl --no-owner -h localhost -d $happ"_development" "/Users/devops/Downloads/pg_backups/$happ-$current_date.dump"
                rake db:migrate
        fi
}

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias config="vim ~/.zshrc"
alias reload="source ~/.zshrc"
alias dbdrop="rake db:drop RAILS_ENV=development"
alias pstaging="git push staging staging:master"
