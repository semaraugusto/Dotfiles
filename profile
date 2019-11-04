# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# eval "$(fasd --init auto)"


# set PATH so it includes user's private bin directories
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"
PATH="$HOME/bin:$HOME/.local/bin:$PATH"
export PATH="$HOME/local/bin:$PATH"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    export PATH="$HOME/bin:$PATH"
fi

# PYENV
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
# if command -v pyenv 1>/dev/null 2>&1; then
#   # eval "$(pyenv virtualenv-init -)"
# fi

# CUDA
export PATH="/usr/local/cuda/bin:$PATH"
export LD_LIBRARY_PATH="$HOME/local/lib"
export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"
export LIBRARY_PATH="/usr/local/cuda/lib64"


export PKG_CONFIG_PATH="$HOME/local/lib/pkgconfig:$PKG_CONFIG_PATH"


#export TESSDATA_PREFIX="/home/daniel/local/share"
#export SCROLLVIEW_PATH="/home/daniel/projects/tesseract/java"
#export TESSERACT_OPENCL_DEVICE=3
#alias tesseract="/home/daniel/local/bin/tesseract"

alias ls='ls --color=auto'
[ -f ~/.fzf.bash ] && source ~/.fzf.bash


source ~/term_conf.sh



