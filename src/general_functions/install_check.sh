function install_check { 
program_name="$1"

if [[ "$2" == "continue" ]] ; then 
    if grep -q "$program_name" $HOME/.parmanode/installed.conf 2>/dev/null
    then
    return 1
    else
    return 0
    fi
fi

    if grep -q "$program_name" $HOME/.parmanode/installed.conf 2>/dev/null
        then 
            log "$program_name" "Install error. Already installed"
            install_error "$program_name"
            previous_menu
            return 1 
        else 
            log "$program_name" "Install check passed; not installed. Continuing."
            return 0
        fi
}

function install_error {
program_name="$1"
if [[ $program_name == "parmanode" ]] ; then
set_terminal
echo "
########################################################################################
	
                                    Install Error

    Parmanode cannot be re-installed unless fully uninstalled first (there may be 
    remnants which an proper uninstall will clearn up). Try running 
    uninstall-parmanode from the menu, once more, even if you've done it (it's quick
    and won't hurt anything). If that desn't work, I'd apprciate feedback and I'll 
    help fix it.

            If you're trying to add Bitcoin, or another program, go via
            the \"Add more programs\" menu.

########################################################################################
"
return 0

else
set_terminal ; echo "
########################################################################################
                                    
                                    Install Error

    Previous installation detected. Please cleanly uninstall before trying again. 

    This is precaution to reduce the chance of errors.

########################################################################################
"
return 0
fi
}

