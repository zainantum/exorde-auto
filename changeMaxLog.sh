#!/bin/bash
if [ -n "$maxLog" ]; then
  sed -i -e "s|maxLog*=.*|maxLog=$1|" $HOME/.bash_profile
else
  echo 'export maxLog='$1 >> $HOME/.bash_profile
fi
