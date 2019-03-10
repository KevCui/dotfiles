# Key bindings for command snippet
# --------------------------------
if [[ $- == *i* ]]; then

# CTRL-S - Paste the selected command from command.md into the command line
__csel() {
  local cmd="${FZF_CTRL_S_COMMAND}"
  setopt localoptions pipefail 2> /dev/null
  eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS" $(__fzfcmd) | sed -e 's/.*\]: //'
  local ret=$?
  echo
  return $ret
}

__fzf_use_tmux__() {
  [ -n "$TMUX_PANE" ] && [ "${FZF_TMUX:-0}" != 0 ] && [ ${LINES:-40} -gt 15 ]
}

__fzfcmd() {
  __fzf_use_tmux__ &&
    echo "fzf-tmux -d${FZF_TMUX_HEIGHT:-40%}" || echo "fzf"
}

fzf-command-widget() {
  LBUFFER="${LBUFFER}$(__csel)"
  local ret=$?
  zle redisplay
  typeset -f zle-line-init >/dev/null && zle zle-line-init
  return $ret
}
zle     -N   fzf-command-widget
bindkey '^S' fzf-command-widget

fi
