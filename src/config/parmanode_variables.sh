function parmanode_variables {
#The following code checks if in debugging mode. Mainly for developing, not client usage
#If debug is 1, then a debuging function becomes active, which pauses the
#program wherever it appears. "export" keeps variable in global memory.
if [[ $1 == "debug" || $1 == d ]] ; then export debug=1 
elif [[ $1 == d2 ]] ; then export debug=2  
elif [[ $1 == d3 ]] ; then export debug=3  #bre docker no-cache build
elif [[ $1 == d4 ]] ; then export debug=4  
elif [[ $1 == d5 ]] ; then export debug=5  
elif [[ $1 == d6 ]] ; then export debug=6  
elif [[ $1 == d7 ]] ; then export debug=7  
else export debug=0 
fi

#save position of working directory. "Export" makes the variable available everywhere.
export original_dir=$(pwd) >/dev/null 2>&1

if [[ $1 == "usertest" ]] ; then export ut=1 ; fi


if [[ $(uname) == Linux ]] ; then
export parmanode_drive="media/$USER/parmanode"
elif [[ $(uname) == Darwin ]] ; then
export parmanode_drive="/Volumes/parmanode"
fi

dp="$HOME/.parmanode"
hp="$HOME/parmanode"
pp="$HOME/parman_programs"
pn="$pp/parmanode"

parmanode_conf="${dp}/parmanode.conf"
installed_conf="${dp}/installed.conf"

}