# Setup fzf
# ---------
if [[ ! "$PATH" == */home/semaraugusto/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/semaraugusto/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/semaraugusto/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/semaraugusto/.fzf/shell/key-bindings.bash"
