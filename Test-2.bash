#!/bin/bash
#Should be added in "~/.bashrc"

#Since we can't add this feature as alias 
#We add it as function.
function read_user () {
    read -p "Are you sure you wish to force delete it? [y,n] :" USER_INPUT
    if [ $USER_INPUT == y ]; then
     echo "Deleted."
     /bin/rm "$@"
    else
     return 1
    fi
}

#Checking if the user is using rm with the -rf options
#If they are we redirect them to our function above.
#If they don't use with "-rf" option they continue to use as intented.
rm () {
  if [[ $1 =~ -(rf|fr) ]]; then
    read_user $1 $2
  else
    /bin/rm "$@"
  fi
}

#Now if user uses the "rm -rf" command it will pop confirmation message.