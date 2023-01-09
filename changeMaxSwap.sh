#!/bin/bash
if [ -n "$maxSwap" ]; then
  sed -i -e "s|maxSwap*=.*|maxSwap=$1|" $HOME/.bash_profile
else
  echo 'export maxSwap='$1 >> $HOME/.bash_profile
fi
