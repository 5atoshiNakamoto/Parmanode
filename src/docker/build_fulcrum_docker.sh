function build_fulcrum_docker {

cd $original_dir    #created in run_parmanode. Need to get back to build dockerfile from here.

set_terminal ; echo "
########################################################################################

    To install Fulcrum, Docker will now build a Linux/Fulcrum container, as 
    specified within the Parmanode software. Please sit back and enjoy. It will take 
    a minute or so.

########################################################################################
"
enter_continue

{ docker build -t fulcrum ./ 2>&1 | tee $HOME/.parmanode/docker_build.log ; } \
|| { log "fulcrum" "fulcrum docker build failed" && return 1 ; }

while true ; do
set_terminal ; echo "
########################################################################################

    The build process should be completed.  A log file for the process has been saved 
    to:
                    $HOME/.parmanode/docker_build.log

    You can take a look now if you want:


               L)       See log file of build process       (see controls at the 
                                                             bottom, exit with 
                                                             control-x)
    
            <enter>     Continue installation


    The installation of Fulcrum will continue when you exit the document reader.

########################################################################################                    
"
choose "xpq" ; read choice
case $choice in q|Q|Quit|QUIT) exit 0 ;; p|P) return 1 ;; l|L) nano $HOME/.parmanode/docker_build.log ;; *) set_terminal ; break ;; esac
done
return 0
}