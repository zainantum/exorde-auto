#!/bin/bash
if [ -n "$dockerInstall" ]; then
  sed -i -e "s|dockerInstall*=.*|dockerInstall=$1|" $HOME/.bash_profile
else
  echo 'export dockerInstall='$1 >> $HOME/.bash_profile
fi
