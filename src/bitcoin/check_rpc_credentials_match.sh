function check_rpc_credentials_match {

source_rpc_global

if [[ -n $BREdocker_rpcuser ]] && [[ $BREdocker_rpcuser != $rpcuser || $BREdocker_rpcpassword != $rpcpassword ]] ; then
program="${cyan}BTC RPC Explorer (Docker)$orange"
while true ; do
set_terminal ; echo -e "
########################################################################################
    
    The urser/password credentials for $program do not match your Bitcoin
    configuration. 

    Would you like Parmanode to fix that up for you? If so, $program 
    will be restarted.
$green
                      y)    Yes thanks, how good is that?
$orange
                      n)    Nah, I know what I'm doing and I'll manage it.
                    
########################################################################################
"
choose "xmq" ; read choice ; set_terminal
case $choice in
q|Q) exit 0 ;; p|P|M|m) back2main ;;
y)
unset file && local file="$HOME/parmanode/bre/.env"
bre_docker_stop
swap_string "$file" "BTCEXP_BITCOIND_USER" "BTCEXP_BITCOIND_USER=$rpcuser"
swap_string "$file" "BTCEXP_BITCOIND_PASS" "BTCEXP_BITCOIND_PASS=$rpcpassword"
bre_docker_start
break
;;
n)
break ;;
*)
invalid ;;
esac 
done
fi

if [[ -n $BRE_rpcuser ]] && [[ $BRE_rpcuser != $rpcuser || $BRE_rpcpassword != $rpcpassword ]] ; then
program="${cyan}BTC RPC Explorer$orange"
while true ; do
set_terminal ; echo -e "
########################################################################################
    
    The urser/password credentials for $program do not match your Bitcoin
    configuration. 

    Would you like Parmanode to fix that up for you? If so, $program will be
    restarted.
$green
                      y)    Yes thanks, how good is that?
$orange
                      n)    Nah, I know what I'm doing and I'll manage it.
                    
########################################################################################
"
choose "xmq" ; read choice ; set_terminal
case $choice in
q|Q) exit 0 ;; p|P|M|m) back2main ;;
y)
unset file && local file="$HOME/parmanode/btc-rpc-explorer/.env"
stop_bre
swap_string "$file" "BTCEXP_BITCOIND_USER" "BTCEXP_BITCOIND_USER=$rpcuser" 
swap_string "$file" "BTCEXP_BITCOIND_PASS" "BTCEXP_BITCOIND_PASS=$rpcpassword"
restart_bre
break
;;
n)
break ;;
*)
invalid ;;
esac 
done
fi


if [[ -n $LND_rpcuser ]] && [[ $LND_rpcuser != $rpcuser || $LND_rpcpassword != $rpcpassword ]] ; then
program="${cyan}LND$orange"
while true ; do
set_terminal ; echo -e "
########################################################################################
    
    The urser/password credentials for $program do not match your Bitcoin
    configuration. 

    Would you like Parmanode to fix that up for you? If so, $program will be
    restarted.
$green
                      y)    Yes thanks, how good is that?
$orange
                      n)    Nah, I know what I'm doing and I'll manage it.
                    
########################################################################################
"
choose "xmq" ; read choice ; set_terminal
case $choice in
q|Q) exit 0 ;; p|P|M|m) back2main ;;
y)
unset file && local file="$HOME/.lnd/lnd.conf"
stop_lnd
swap_string "$file" "bitcoind.rpcpass" "bitcoind.rpcpass=$rpcpassword"
swap_string "$file" "bitcoind.rpcuser" "bitcoind.rpcuser=$rpcuser"
start_lnd
break
;;
n)
break ;;
*)
invalid ;;
esac 
done
fi


if [[ -n $nbxplorer_rpcuser ]] && [[ $nbxplorer_rpcuser != $rpcuser || $nbxplorer_rpcpassword != $rpcpassword ]] ; then
program="${cyan}BTCPay Server$orange"
while true ; do
set_terminal ; echo -e "
########################################################################################
    
    The urser/password credentials for $program do not match your Bitcoin
    configuration. 

    Would you like Parmanode to fix that up for you? If so, $program will be
    restarted.
$green
                      y)    Yes thanks, how good is that?
$orange
                      n)    Nah, I know what I'm doing and I'll manage it.
                    
########################################################################################
"
choose "xmq" ; read choice ; set_terminal
case $choice in
q|Q) exit 0 ;; p|P|M|m) back2main ;;
y)
unset file && local file="$HOME/.nbxplorer/Main/settings.config"
stop_btcpay
swap_string "$file" "btc.rpc.user"     "btc.rpc.user=$rpcuser"
swap_string "$file" "btc.rpc.password" "btc.rpc.password=$rpcpassword"
start_btcpay
break
;;
n)
break ;;
*)
invalid ;;
esac 
done
fi

if [[ -n $electrs_rpcuser ]] && [[ $electrs_rpcuser != $rpcuser || $electrs_rpcpassword != $rpcpassword ]] ; then
program="${cyan}electrs$orange"
while true ; do
set_terminal ; echo -e "
########################################################################################
    
    The urser/password credentials for $program do not match your Bitcoin
    configuration. 

    Would you like Parmanode to fix that up for you? If so, $program will be
    restarted.
$green
                      y)    Yes thanks, how good is that?
$orange
                      n)    Nah, I know what I'm doing and I'll manage it.
                    
########################################################################################
"
choose "xmq" ; read choice ; set_terminal
case $choice in
q|Q) exit 0 ;; p|P|M|m) back2main ;;
y)
unset file && local file="$HOME/.electrs/config.toml"
if grep -q "electrs-end" < $ic ; then stop_electrs ; fi
if grep -q "electrsdkr-end" < $ic ; then stop_electrs ; fi
swap_string "$file" "auth" "auth = \"$rpcuser:$rpcpassword\""
if grep -q "electrs-end" < $ic ; then start_electrs ; fi
if grep -q "electrsdkr-end" <$ic ; then docker_start_electrs ; fi
break
;;
n)
break ;;
*)
invalid ;;
esac 
done
fi

if [[ -n $fulcrum_rpcuser ]] && [[ $fulcrum_rpcuser != $rpcuser || $fulcrum_rpcpassword != $rpcpassword ]] ; then
program="${cyan}Fulcrum$orange"
while true ; do
set_terminal ; echo -e "
########################################################################################
    
    The urser/password credentials for $program do not match your Bitcoin
    configuration. 

    Would you like Parmanode to fix that up for you? If so, $program will be
    restarted.
$green
                      y)    Yes thanks, how good is that?
$orange
                      n)    Nah, I know what I'm doing and I'll manage it.
                    
########################################################################################
"
choose "xmq" ; read choice ; set_terminal
case $choice in
q|Q) exit 0 ;; p|P|M|m) back2main ;;
y)
unset file && local file="$hp/fulcrum/fulcrum.conf"
stop_fulcrum
swap_string "$file" "rpcuser" "rpcuser = $rpcuser"
swap_string "$file" "rpcpassword" "rpcpassword = $rpcpassword"
start_fulcrum
break
;;
n)
break ;;
*)
invalid ;;
esac 
done
fi

if [[ -n $sparrow_rpcuser ]] && [[ $sparrow_rpcuser != $rpcuser || $sparrow_rpcpassword != $rpcpassword ]] ; then
program="${cyan}Sparrow Wallet$orange"
while true ; do
set_terminal ; echo -e "
########################################################################################
    
    The urser/password credentials for $program do not match your Bitcoin
    configuration. 

    Would you like Parmanode to fix that up for you? If so, $program will 
    be restarted.
$green
                      y)    Yes thanks, how good is that?
$orange
                      n)    Nah, I know what I'm doing and I'll manage it.
                    
########################################################################################
"
choose "xmq" ; read choice ; set_terminal
case $choice in
q|Q) exit 0 ;; p|P|M|m) back2main ;;
y)
unset file && local file="$HOME/.sparrow/config"
set_terminal ; echo "Please ensure Sparrow has been shut down before continuing." ; enter_continue
swap_string "$file" "coreAuth\"" "    \"coreAuth\": \"$rpcuser:$rpcpassword\","
break
;;
n)
break ;;
*)
invalid ;;
esac 
done
fi

if [[ -n $mempool_rpcuser ]] && [[ $mempool_rpcuser != $rpcuser || $mempool_rpcpassword != $rpcpassword ]] ; then
program="${cyan}Mempool Space$orange"
while true ; do
set_terminal ; echo -e "
########################################################################################
    
    The urser/password credentials for $program do not match your Bitcoin
    configuration. 

    Would you like Parmanode to fix that up for you? If so, $program will be
    restarted.
$green
                      y)    Yes thanks, how good is that?
$orange
                      n)    Nah, I know what I'm doing and I'll manage it.
                    
########################################################################################
"
choose "xmq" ; read choice ; set_terminal
case $choice in
q|Q) exit 0 ;; p|P|M|m) back2main ;;
y)
unset file && local file="$hp/mempool/docker/docker-compose.yml"
stop_mempool
swap_string "$file" "CORE_RPC_USERNAME" "      CORE_RPC_USERNAME: \"$rpcuser\"" #docker compose file, indentation is criticial
swap_string "$file" "CORE_RPC_PASSWORD" "      CORE_RPC_PASSWORD: \"$rpcpassword\"" 
start_mempool
break
;;
n)
break ;;
*)
invalid ;;
esac 
done
fi

}