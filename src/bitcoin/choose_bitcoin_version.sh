function choose_bitcoin_version {
if [[ $OS == Mac ]] ; then
export bitcoin_compile=false
export version="26.0"
return 0
fi

while true ; do
clear ; echo -e "
########################################################################################
$cyan
    THERE ARE SEVERAL WAYS TO INSTALL BITCOIN WITH PARMANODE. PLEASE CHOOSE...
$orange
########################################################################################
$red
       1)  v25.0 orange (Download and verify 'trusted' releases)
$green
       2)  v26.0 orange (Download and verify 'trusted' releases) - quickest method
$red
       3)  Guided compile v25.0/v26.0 
$green
       4)  Guided compile v25.0/v26.0 (FILTER-ORDINALS patch, by Luke Dashr Jr)
$red
       5)  Guided compile Knots Bitcoin (Luke Dashr Jr's version of Bitcoin Core,
           which also has FILTER-ORDINALS patch) version v25.1.knots20231115
$red
       6)  BYO Bitcoin binary installation (imports to Parmanode) - not available yet

       7)  Guided compile of most recent Github update, ie pre-release
           (for testing only)
$orange
########################################################################################   
"
choose "xpmq" 
unset bitcoin_compile version ordinals_patch knotsbitcoin byo_bitcoin
read choice

case $choice in
q|Q) exit 0 ;; p|P) return 1 ;; m|M) back2main ;;
1|25) 
parmanode_conf_add "bitcoin_choice=precompiled"
export version="25.0" ; export bitcoin_compile=false ; break ;;
2|26) 
parmanode_conf_add "bitcoin_choice=precompiled"
export version="26.0" ; export bitcoin_compile=false ; break ;;
3) 
parmanode_conf_add "bitcoin_choice=compiled"
export bitcoin_compile=true ; export version=choose ; break ;;
4)
parmanode_conf_add "bitcoin_choice=compiled"
export bitcoin_compile=true ; export version=choose ; export ordinals_patch=true ; break ;;
5)
parmanode_conf_add "bitcoin_choice=knots"
export knotsbitcoin=true ; export version="v25.1.knots20231115" ; break ;;
6)
parmanode_conf_add "bitcoin_choice=byo"
export byo_bitcoin=true ; break ;;
7)
parmanode_conf_add "bitcoin_choice=compiled"
export bitcoin_compile=true ; export version=latest ; break ;;
*) 
invalid ;;
esac
done

if [[ $bitcoin_compile != "false" ]] ; then
# $hp/bitcoin directory made earlier for downloading compiled bitcoin. Can delete.
sudo rm -rf $hp/bitcoin >/dev/null 2>&1
fi

}