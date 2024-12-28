<<<<<<< HEAD
alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts'

alias vc='nvim $HOME/.config/nvim'
alias v='nvim .'

alias pubip='curl http://ipecho.net/plan; echo'

alias mvn='mvn -gs "$XDG_CONFIG_HOME"/maven/settings.xml'
alias sbt='sbt -ivy "$XDG_DATA_HOME"/ivy2 -sbt-dir "$XDG_DATA_HOME"/sbt'
alias nvidia-settings='nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings'


=======
alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"
alias sbt="sbt -ivy $XDG_DATA_HOME/ivy2 -sbt-dir $XDG_DATA_HOME/sbt"
alias mvn="mvn -gs $XDG_CONFIG_HOME/maven/settings.xml"
alias nvidia-settings="nvidia-settings --config=$XDG_CONFIG_HOME/nvidia/settings"
>>>>>>> b1d9b7a (feat: some tidying and moving away from dwm)
