function menu_electrs_docker {
logfile="/home/parman/run_electrs.log"
while true ; do
unset log_size
set_terminal
unset ONION_ADDR_ELECTRS E_tor E_tor_logic drive_electrs electrs_version
source $dp/parmanode.conf >/dev/null 2>&1
if [[ $OS == Linux && -e /etc/tor/torrc ]] ; then
    if sudo cat /etc/tor/torrc | grep -q "electrs" >/dev/null 2>&1 ; then
        if sudo test -e /var/lib/tor/electrs-service  && \
        sudo cat /var/lib/tor/electrs-service/hostname | grep "onion" >/dev/null 2>&1 ; then
        E_tor="${green}on${orange}"
        E_tor_logic=on
        fi
    else
        E_tor="${red}off${orange}"
        E_tor_logic=off
    fi
fi

#check it's running
if docker exec -it electrs /home/parman/parmanode/electrs/target/release/electrs --version >/dev/null 2>&1 ; then
electrs_version=$(docker exec -it electrs /home/parman/parmanode/electrs/target/release/electrs --version | tr -d '\r' 2>/dev/null )
log_size=$(docker exec -it electrs /bin/bash -c "ls -l $logfile | awk '{print \$5}' | grep -oE [0-9]+" 2>/dev/null)
log_size=$(echo $log_size | tr -d '\r\n')
if docker exec -it electrs /bin/bash -c "tail -n 10 $logfile" | grep -q "electrs failed" ; then unset electrs_version ; fi
fi
set_terminal_custom 50
debug "electrs version, $electrs_version"

echo -e "
########################################################################################
                                ${cyan}Electrs Menu $electrs_version ${orange}
########################################################################################
"
if [[ $log_size -gt 100000000 ]] ; then echo -e "$red
    THE LOG FILE SIZE IS GETTING BIG. TYPE 'logdel' AND <enter> TO CLEAR IT.
    $orange"
fi
if [[ -n $electrs_version ]] ; then echo -e "
                   ELECTRS IS$green RUNNING$orange -- SEE LOG MENU FOR PROGRESS 

                         Sync'ing to the $cyan$drive_electrs$orange drive

      127.0.0.1:50005:t    or    127.0.0.1:50006:s    or    $IP:50006:s
"
else
echo -e "
                   ELECTRS IS$red NOT RUNNING$orange -- CHOOSE \"start\" TO RUN

                         Will sync to the $cyan$drive_electrs$orange drive"
fi
echo "


      (i)        Important info / Troubleshooting

      (start)    Start electrs 

      (stop)     Stop electrs 

      (restart)  Restart electrs 

      (remote)   Choose which Bitcoin Core for electrs to connect to

      (c)        How to connect your Electrum wallet to electrs 
	    
      (log)      Inspect electrs logs

      (ec)       Inspect and edit config.toml file 

      (up)       Set/remove/change Bitcoin rpc user/pass (electrs config file updates)

      (dc)       electrs database corrupted? -- Use this to start fresh."

if [[ $OS == Linux ]] ; then echo -e "
      (tor)      Enable/Disable Tor connections to electrs -- Status : $E_tor"  ; else echo -e "
" 
fi
if grep -q "electrs_tor" < $HOME/.parmanode/parmanode.conf ; then 
get_onion_address_variable "electrs" >/dev/null ; echo -e "
    Onion adress:$bright_blue $ONION_ADDR_ELECTRS:7004 $orange


########################################################################################
"
else echo "
########################################################################################
"
fi
choose "xpmq" ; read choice ; set_terminal
case $choice in
m|M) back2main ;;
I|i|info|INFO)
info_electrs_docker
break
;;

start | START)
docker_start_electrs 
continue
;;

stop | STOP) 
docker_stop_electrs
continue
;;

logdel)
please_wait
docker_stop_electrs
docker start electrs >/dev/null 2>&1
docker exec -it electrs bash -c "rm $logfile"
docker_start_electrs
;;

restart|Restart)
docker_stop_electrs
docker_start_electrs
continue
;;

remote|REMOTE|Remote)
set_terminal
electrs_to_remote
docker_stop_electrs
docker_start_electrs
set_terminal
;;

c|C)
electrum_wallet_info
continue
;;

log|LOG|Log)

set_terminal ; log_counter
if [[ $log_count -le 15 ]] ; then
echo "
########################################################################################
    
    This will show the electrs log output in real time as it populates.
    
    You can hit <control>-c to make it stop.

########################################################################################
"
enter_continue
fi

    set_terminal_wider
    docker exec -it electrs /bin/bash -c "tail -f $logfile"      
        # tail_PID=$!
        # trap 'kill $tail_PID' SIGINT #condition added to memory
        # wait $tail_PID # code waits here for user to control-c
        # trap - SIGINT # reset the t. rap so control-c works elsewhere.
    set_terminal
    continue

;;

ec|EC|Ec|eC)
echo "
########################################################################################
    
        This will run Nano text editor to edit config.toml. See the controls
        at the bottom to save and exit. Be careful messing around with this file.

        Any changes will only be applied once you restart electrs.

########################################################################################
"
enter_continue
nano $HOME/.electrs/config.toml
 
continue
;;

up|UP|Up|uP)
set_rpc_authentication
continue
;;

p|P) 
if [[ $1 == overview ]] ; then return 0 ; fi
menu_use ;; 

q|Q|Quit|QUIT)
exit 0
;;

tor|TOR|Tor)
if [[ $OS == Mac ]] ; then no_mac ; continue ; fi
if [[ $E_tor_logic == off ]] ; then
electrs_tor
debug "line 195, meun docker electrs, in E_tor_logic"
else
electrs_tor_remove
fi
;;

dc|DC|Dc)
electrs_database_corrupted 
;;

*)
invalid
;;
esac
done

return 0
}

function waif4bitcoin {

menu_bitcoin_status >/dev/null 2>&1
if ! echo $running_text | grep -q "fully"  ; then
announce "Bitcoin needs to be fully synced and running first"
return 1
fi

}


