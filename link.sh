#!/usr/bin/bash

PATH="$HOME/home"

#lets check for submodules that have not been grabbed yet (ie this is a new clone)
cd `dirname $0`
if [[ `git submodule | grep '^-'` ]]; then
  git submodule update --init
fi
cd -

/bin/ln -nfs $PATH/vim ~/.vim
/bin/ln -nfs $PATH/vimrc ~/.vimrc
/bin/ln -nfs $PATH/screenrc ~/.screenrc
/bin/ln -nfs $PATH/tmux.conf ~/.tmux.conf
/bin/ln -nfs $PATH/fonts ~/.fonts
/bin/ln -nfs $PATH/bashrc ~/.bashrc
/bin/ln -nfs $PATH/profile ~/.profile
/bin/ln -nfs $PATH/gitconfig ~/.gitconfig

if [ -e ~/.kde4/share/apps/konsole ]; then
    /bin/ln -nfs $PATH/Zenburn.schema ~/.kde4/share/apps/konsole
fi

if [ ! -e /etc/profile.d/perlbrew.sh ]; then
    cp $PATH/perlbrew.sh /etc/profile.d/perlbrew.sh
fi

if [ ! -e ~/.Xdefaults ]; then
    /bin/ln -nfs $PATH/Xdefaults ~/.Xdefaults
    /bin/ln -nfs $PATH/xrdb ~/.xrdb
fi
