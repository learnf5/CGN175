# confirm bigip1 is active
for i in {1..30}; do [ "$(sudo ssh root@192.168.1.31 cat /var/prompt/ps1)" = "Active" ] && break; sleep 5; done

# confirm bigip2 is active, if this is an HA lab
[[ "$LAB_NUMBER" =~ "-HA" ]] && for i in {1..30}; do [ "$(sudo ssh root@192.168.2.31 cat /var/prompt/ps1)" = "Active" ] && break; sleep 5; done
