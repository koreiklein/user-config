
for rcfile in `ls -A ./home_hidden_files/` ; do
  homerc=~/$rcfile

  if ! [ -e $homerc ]; then
    ln -s `pwd`/home_hidden_files/$rcfile $homerc
  fi
done

# Link the .config directory to this repo
if ! [ -e ~/.config ]; then
  ln -s `pwd`/config ~/.config
fi
