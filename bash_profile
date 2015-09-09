export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias gs='git status'
alias ls='ls -GFh'
alias ll=clear
amend () {
  git add $1
  git commit --amend -C HEAD
}
multiPush() {
  currBranch=$(git branch)
  currBranch=${currBranch:2}
  if [ "$1" == "$currBranch" ]
  then
    git push origin "$currBranch"
    shift 
    for var in "$@"
    do
      git checkout "$var"
      git pull origin "$currBranch"
      git push origin "$var"
    done
    git checkout "$currBranch"
  else
    echo "First argument must be the current branch"
  fi
}
commitAll() {
  if [ -z "$1" ]
  then
    echo "Must provide a commit message"
  else
    git add -A
    git commit -m $1
  fi  
}
test () {
}
