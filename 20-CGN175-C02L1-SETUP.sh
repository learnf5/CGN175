# add route to training server
sudo ssh 192.168.1.31 -t ssh 172.16.20.1 ip route add 40.0.101.0/24 via 172.16.1.33

# download archive from github, copy it to bigip1 and load it
curl --silent https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/1_cgnat_start.scf --output /tmp/1_cgnat_start.scf
sudo scp /tmp/1_cgnat_start.scf 192.168.1.31:/var/local/scf
sudo ssh 192.168.1.31 tmsh load sys config file 1_cgnat_start.scf
