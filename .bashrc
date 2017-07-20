#!/bin/bash
# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

source ~/.local/bin/scripts/git
source ~/.local/bin/scripts/dirs
source ~/.local/bin/scripts/misc
source ~/.local/bin/scripts/sparkcognition
