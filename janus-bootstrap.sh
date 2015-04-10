#!/bin/bash


function die()
{
  echo "${@}"
  exit 1
}

which rake || die "rake not found.  install it."

[[ $1 == "--nobackup" ]] && nobackup=true

$nobackup || \
for i in $HOME/.vim $HOME/.vimrc $HOME/.gvimrc; do
  if [[ ( -e $i ) || ( -h $i ) ]]; then
    echo "${i} has been renamed to ${i}.old"
    mv "${i}" "${i}.old" || die "Could not move ${i} to ${i}.old"
  fi
done 

# Clone Janus into .vim
git clone https://github.com/carlhuda/janus.git $HOME/.vim \
|| die "Could not clone the repository to ${HOME}/.vim"

# Run rake inside .vim
cd $HOME/.vim || die "Could not go into the ${HOME}/.vim"
rake || die "Rake failed."
