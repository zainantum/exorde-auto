#!/bin/bash
if [ -n "$chatid" ]; then
  sed -i -e "s|chatid*=.*|chatid=$1|" $HOME/.bash_profile
else
  echo 'export chatid='$1 >> $HOME/.bash_profile
fi
