if [ -n "$mainAddress" ]; then
  sed -i -e "s|mainAddress*=.*|mainAddress=$1|" $HOME/.bash_profile
else
  echo 'export mainAddress='$1 >> $HOME/.bash_profile
fi
