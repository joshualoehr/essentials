#!/bin/bash
# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

source ~/.local/bin/scripts/misc
source ~/.local/bin/scripts/git
source ~/.local/bin/scripts/dirs

# Set npm to install global packages locally
NPM_PACKAGES=${HOME}/.npm_global
PATH="$NPM_PACKAGES/bin:$PATH"

