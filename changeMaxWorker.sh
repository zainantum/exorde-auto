#!/bin/bash
if [ -n "$maxWorker " ]; then
  sed -i -e "s|maxWorker *=.*|maxWorker =$1|" $HOME/.bash_profile
else
  echo 'export maxWorker ='$1 >> $HOME/.bash_profile
fi
