#!/usr/bin/env bash

# unset all alias
git config --global --remove-section alias

###############
# Simple alias
###############

git config --global alias.a      "add"
git config --global alias.alias  "config --get-regexp alias"
git config --global alias.br     "branch"
git config --global alias.c      "commit"
git config --global alias.ca     "commit --amend"
git config --global alias.ci     "commit -m"
git config --global alias.cm     "commit -m"
git config --global alias.cl     "clone --depth 1"
git config --global alias.co     "checkout"
git config --global alias.df     "difftool"
git config --global alias.di     "diff"
git config --global alias.p      "push"
git config --global alias.p      "push origin"
git config --global alias.pl     "pull"
git config --global alias.pll    "pull"
git config --global alias.rst    "reset --"
git config --global alias.rsthd  "reset HEAD~"
git config --global alias.rsthrd "reset --hard origin/master"
git config --global alias.s      "status"

###############
# Complex alias
###############

FZF_KEYBINDING="tab:down,btab:up,ctrl-j:up,ctrl-k:down,change:top,alt-space:toggle,ctrl-a:select-all,ctrl-u:deselect-all"
FZF_PREVIEW_KEYBINDING="alt-k:preview-down,alt-j:preview-up,alt-h:preview-page-down,alt-l:preview-page-up"
DIFF_CMD="delta --theme=iceberg"
GIT_DIFF_NAME="git diff --name-only"
GIT_DIFF_NAME_CACHED="git diff --name-only --cached"
GIT_DIFF_TREE="git diff-tree -p {1}"

# add modified files with fzf
git config --global alias.ac     "! git add \$($GIT_DIFF_NAME --diff-filter=M | fzf -0 -m --reverse --height=40% --bind $FZF_KEYBINDING --cycle)"

# list all file changes with fzf, added via selection
git config --global alias.au     '! cd $(pwd)/$GIT_PREFIX && git add $(git status -s | fzf -0 -m --reverse --height=40% --bind "'"$FZF_KEYBINDING"'" --cycle | cut -c4- | sed -E "s/[[:space:]]/\\\ /g" | sed -E "s/\(/\\\(/g" | sed -E "s/\)/\\\)/g" | awk '\''{printf "%s ",$0}'\'' | sed -E "s/[[:space:]]$//")'

# b <file>: show git blame on a file, enter to see commit details
git config --global alias.b      '! sh -c "git blame $1 | fzf -0 --ansi --bind '"$FZF_KEYBINDING"' --bind '\''enter:abort+execute('"$GIT_DIFF_TREE"' | '"$DIFF_CMD"')'\'' --cycle"'

# show unstaged changes, enter to see file change details
git config --global alias.d      "! $GIT_DIFF_NAME | fzf -0 --ansi --preview-window=right:80:wrap --preview 'git diff -- {} | $DIFF_CMD' --bind $FZF_KEYBINDING --bind $FZF_PREVIEW_KEYBINDING --bind 'enter:abort+execute(git diff -- {1} | $DIFF_CMD)' --cycle"

# show staged changes, enter to commit
git config --global alias.ds     "! $GIT_DIFF_NAME_CACHED | fzf -0 --ansi --preview-window=right:80:wrap --preview 'git diff --cached -- {} | $DIFF_CMD' --bind $FZF_KEYBINDING --bind $FZF_PREVIEW_KEYBINDING --bind 'enter:abort+execute(git commit)' --cycle"

# f <file>: show file change history with fzf, enter to see commit details
git config --global alias.f      '! sh -c "git log --follow --pretty=format:'\''%h %ad %s%d'\'' --date=short $1 | fzf +s -0 --preview-window=wrap --preview '\'''"$GIT_DIFF_TREE"' | '"$DIFF_CMD"''\'' --bind '"$FZF_KEYBINDING"' --bind '"$FZF_PREVIEW_KEYBINDING"' --bind '\''enter:abort+execute('"$GIT_DIFF_TREE"' | '"$DIFF_CMD"')'\'' --cycle"'

# show commit graph history
git config --global alias.h      "log --pretty=format:'%Cgreen%h%Creset %C(yellow)%ad%Creset | %s%d [%an]' --graph --date=short"

# list chanege details of commit with fzf, enter to see commit details
git config --global alias.l      "! git log --pretty=format:'%h %ad %s%d' --date=short | fzf +s -0 --preview-window=wrap --preview '$GIT_DIFF_TREE | $DIFF_CMD' --bind $FZF_KEYBINDING --bind $FZF_PREVIEW_KEYBINDING --bind 'enter:abort+execute($GIT_DIFF_TREE | $DIFF_CMD)' --cycle"

# list summary of commit with fzf, enter to see compact summary
git config --global alias.ls     "! git log --pretty=format:'%h %ad %s%d' --date=short | fzf +s -0 --preview-window=wrap --preview 'git show --color --compact-summary {1}' --bind $FZF_KEYBINDING --bind $FZF_PREVIEW_KEYBINDING --bind 'enter:abort+execute(git show --compact-summary {1})' --cycle"

# unstage file with fzf
git config --global alias.ua     "! git restore --staged \$($GIT_DIFF_NAME_CACHED | fzf -0 -m --reverse --height=40% --bind $FZF_KEYBINDING --cycle)"
