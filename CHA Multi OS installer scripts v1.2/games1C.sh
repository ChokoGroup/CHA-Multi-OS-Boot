# ! /bin/sh
# For Choko Hack 12.0.0+

# Simple string compare, since until 10.0.0 CHOKOVERSION wasn't set
# Future versions need to keep this in mind
if [ "$CHOKOVERSION" \< "12.0.0" ]
then
  echo -e "\nYou are running an outdated version of Choko Hack.\nYou need v12.0.0 or later.\n";
  COUNTDOWN=5
  while [ $COUNTDOWN -ge 0 ]
  do
    echo -ne "\rRebooting in $COUNTDOWN seconds... "
    COUNTDOWN=$((COUNTDOWN - 1))
    sleep 1
  done
  echo -ne "\r\e[K"
  if [ "$CHOKOVERSION" \< "10.0.0" ]
  then
    reboot -f
  else
    exit 200
  fi
fi

if [ -f "/.choko/Run Lakka 720p.nfo" ]
then
  rm "/.choko/Run Lakka 720p."*
  echo "Menu option \"Run Lakka (720p)\" deleted (Lakka system files and partition were not deleted)."
else
  echo "\"/.choko/Run Lakka 720p.*\" not found."
fi
sleep 3
# Go back to Choko Menu
exit 202
