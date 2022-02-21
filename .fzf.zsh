# Setup fzf
# ---------
if [[ ! "$PATH" == */home/semar/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/semar/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/semar/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/semar/.fzf/shell/key-bindings.zsh"
