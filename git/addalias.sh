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
git config --global alias.pl     "pull"
git config --global alias.pll    "pull"
git config --global alias.po     "push origin"
git config --global alias.rst    "reset --"
git config --global alias.rsthd  "reset HEAD~"
git config --global alias.rsthrd "reset --hard origin/master"
git config --global alias.ra     "remote add"
git config --global alias.rv     "remote -v"
git config --global alias.s      "status"

###############
# Complex alias
###############

FZF_KEYBINDING="tab:down,btab:up,ctrl-j:up,ctrl-k:down,change:top,alt-space:toggle,ctrl-a:select-all,ctrl-u:deselect-all"
FZF_PREVIEW_KEYBINDING="alt-k:preview-down,alt-j:preview-up,alt-h:preview-page-down,alt-l:preview-page-up"
FZF_OPTION_BIND="--bind $FZF_KEYBINDING --bind $FZF_PREVIEW_KEYBINDING"
FZF_OPTION_PREVIEW_WINDOW="--ansi --cycle --preview-window=right:wrap"
FZF_OPTION_PROMPT="-m --cycle --reverse --height=40%"
DIFF_CMD="delta --theme=iceberg"
ADD_ICON_CMD="deviconslookup.sh"
GIT_DIFF_NAME="git diff --name-only"
GIT_DIFF_NAME_CACHED="$GIT_DIFF_NAME --cached"
GIT_DIFF_TREE="git diff-tree -p {1}"
ALIAS_LIST=(
    ac # add modified files with fzf
    au # list all file changes with fzf, added via selection
    b  # b <file>: show git blame on a file, enter to see commit details
    d  # show unstaged changes, enter to see file change details
    ds # show staged changes, enter to commit
    f  # f <file>: show file change history with fzf, enter to see commit details
    h  # show commit graph history
    l  # list chanege details of commit with fzf, enter to see commit details
    ls # list summary of commit with fzf, enter to see compact summary
    ua # unstage file with fzf
    purge # clean untracked file
)

ac="! while read -r f; do\
 IFS=\$'\n'; git add \$f;\
 done <<< \$($GIT_DIFF_NAME --diff-filter=M\
 | $ADD_ICON_CMD\
 | fzf -0 $FZF_OPTION_PROMPT --bind $FZF_KEYBINDING\
 | cut -c5-)"

au="! cd \"\$(pwd)/\$GIT_PREFIX\"\
 && while read -r f; do\
 IFS=\$'\n'; git add \$f;\
 done <<< \$(git status -s\
 | sed -E 's/\"//g'\
 | $ADD_ICON_CMD\
 | fzf -0 $FZF_OPTION_PROMPT --bind $FZF_KEYBINDING\
 | cut -c8-)"

b="! cd \$(pwd)/\$GIT_PREFIX\
 && sh -c \"git blame \$1\
 | fzf -0 --ansi --cycle $FZF_OPTION_BIND\
 --bind 'enter:abort+execute($GIT_DIFF_TREE | $DIFF_CMD)'\""

d="! $GIT_DIFF_NAME\
 | $ADD_ICON_CMD\
 | fzf -0 $FZF_OPTION_PREVIEW_WINDOW:80 $FZF_OPTION_BIND\
 --preview 'git diff -- {2..-1} | $DIFF_CMD'\
 --bind 'enter:abort+execute(git diff -- {2..-1} | $DIFF_CMD)'"

ds="! $GIT_DIFF_NAME_CACHED\
 | $ADD_ICON_CMD\
 | fzf -0 $FZF_OPTION_PREVIEW_WINDOW:80 $FZF_OPTION_BIND\
 --preview 'git diff --cached -- {2..-1} | $DIFF_CMD'\
 --bind 'enter:abort+execute(git commit)'"

f="! cd \$(pwd)/\$GIT_PREFIX\
 && sh -c \"git log --follow --pretty=format:'%h %ad %s%d' --date=short \$1\
 | fzf -0 +s $FZF_OPTION_PREVIEW_WINDOW $FZF_OPTION_BIND\
 --preview '$GIT_DIFF_TREE | $DIFF_CMD'\
 --bind 'enter:abort+execute($GIT_DIFF_TREE | $DIFF_CMD)'\""

h="log --pretty=format:'%Cgreen%h%Creset %C(yellow)%ad%Creset | %s%d [%an]' --graph --date=short"

l="! git log --pretty=format:'%h %ad %s%d' --date=short\
 | fzf -0 +s $FZF_OPTION_PREVIEW_WINDOW $FZF_OPTION_BIND\
 --preview '$GIT_DIFF_TREE | $DIFF_CMD'\
 --bind 'enter:abort+execute($GIT_DIFF_TREE | $DIFF_CMD)'"

ls="! git log --pretty=format:'%h %ad %s%d' --date=short\
 | fzf -0 +s $FZF_OPTION_PREVIEW_WINDOW $FZF_OPTION_BIND\
 --preview 'git show --color --compact-summary {1}'\
 --bind 'enter:abort+execute(git show --compact-summary {1})'"

ua="! while read -r f; do\
 IFS=\$'\n'; git restore --staged \$f;\
 done <<< \$($GIT_DIFF_NAME_CACHED\
 | $ADD_ICON_CMD\
 | fzf -0 $FZF_OPTION_PROMPT --bind $FZF_KEYBINDING\
 | cut -c5-)"

purge="! GIT_TOP=\$(pwd)\
 && cd \$(pwd)/\$GIT_PREFIX\
 && while read -r f; do\
 IFS=\$'\n'; rm -rf \$f;\
 done <<< \$(git ls-files \"\$(realpath --relative-to=./ \$GIT_TOP)/\" --exclude-standard --others\
 | $ADD_ICON_CMD\
 | fzf -0 $FZF_OPTION_PROMPT --bind $FZF_KEYBINDING\
 | cut -c5-)"

for i in "${ALIAS_LIST[@]}"; do
    git config --global alias."${i}" "${!i}"
done
