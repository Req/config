## This is just the custom bits to be placed after the usual bashrc

# My binariez!
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Quick incognito
function ddg {
    google-chrome --incognito "https://ddg.gg?q=$1"
}

# New and improved, converts http to ssh
function gco() {
    GCO_PATH=$1
    if grep -q "http" <<< $GCO_PATH; then
        echo "HTTP? Eww, converting to SSH"
        GCO_PATH=$(echo $GCO_PATH | sed -r "s/https:\/\/github.com\//git@github.com:/" | sed -r "s/$/.git/")
    fi

    git clone $GCO_PATH && code "$(ls -t | head -1)"
}

# Yes, I am _that_ lazy
alias cn='code ~/_notes'
alias cdp='cd ~/projects'

# History
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s histappend
HISTCONTROL=ignoreboth

# Bash prompt
PROMPT_DIRTRIM=2
PROMPT_COMMAND=__prompt_command    # Function to generate PS1 after CMDs
__prompt_command() {
    local EXIT="$?"
    PS1=""
    if [ $EXIT != 0 ]; then
        PS1+="\[\e[0;31m\]✗\[\e[0m\] "        # Add red if exit code non 0
    else
        PS1+="\[\e[0;32m\]✓\[\e[0m\] "
    fi

    PS1+='\[\e[38;5;245;2m\]\A \[\e[0;32m\]\w \[\e[0m\]$(git branch 2>/dev/null | grep '"'"'*'"'"' | colrm 1 2) \$ '
}
