#!/bin/bash
# git comma - like git commit, but adds unknown files automatically

added=()

# add unknown files...
for arg; do
  if [[ -f $arg && -n $(git ls-files -o $arg) ]]; then
    git add $arg
    added+=($arg)
  fi
done

# ...reset them when commit is aborted
git commit ${@:+-o} "$@" || git reset -q -- $added
