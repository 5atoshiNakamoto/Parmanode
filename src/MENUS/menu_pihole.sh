function menu_pihole {
while true ; do 

if docker ps | grep -q pihole ; then
local running="Running"
else
local running="Not Running"
fi

set_terminal ; echo -e "
########################################################################################
                 $cyan               PiHole Menu            $orange                   
########################################################################################

                          Your PiHole is$pink $running$orange


         (start)                Start PiHole 

         (stop)                 Stop PiHole

         (i)                    Important information


    To access PiHole, navigate to$green $IP/admin/

########################################################################################
"


choose "xpq" ; read choice ; set_terminal
case $choice in 
q|Q|QUIT|Quit) exit 0 ;;
p|P) return 1 ;;

start|Start|START|S|s)
start_pihole
return 0 ;;

stop|Stop|STOP)
stop_pihole
return 0 ;;

i|I|info|Info)
info_pihole
return 0 ;;

*)
invalid
;;

esac
done
} 