#!/bin/bash
if [ -n "$makeSwap" ]; then
  sed -i -e "s|makeSwap*=.*|makeSwap=$1|" $HOME/.bash_profile
else
  echo 'export makeSwap='$1 >> $HOME/.bash_profile
fi
