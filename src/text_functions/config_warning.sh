function config_warning {
# argument 1 should be the program name
clear
echo -e "
########################################################################################
    
    Please$pink be aware$orange, if you have or will install $1 separate 
    to the Parmanode installation, both editions will work from the same configuration
    directory.

    This might be good or bad, but you should be aware.

########################################################################################
"
enter_abort || return 1
}