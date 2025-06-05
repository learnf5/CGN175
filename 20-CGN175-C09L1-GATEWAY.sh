# add static route to training server and jump host
sudo ssh 192.168.1.31 -t ssh 172.16.20.1 ip route add 40.0.101.0/24 via 172.16.1.33
sudo ip route add 172.16.0.0/16 via 10.10.1.33

# download config script from GitHub, copy to bigip1 and run on bigip1; make other config changes
curl --silent https://raw.githubusercontent.com/learnf5/cgnat/main/6_cgnat_alg.scf -o /tmp/6_cgnat_alg.scf
sudo scp /tmp/6_cgnat_alg.scf 192.168.1.31:/var/local/scf
sudo ssh 192.168.1.31 tmsh mod sys state-mirroring addr none
sudo ssh 192.168.1.31 tmsh mod cm device bigip1.f5trn.com configsync-ip none
sudo ssh 192.168.1.31 tmsh mod cm device bigip1.f5trn.com unicast-address none
sudo ssh 192.168.1.31 tmsh delete net self all
sudo ssh 192.168.1.31 tmsh delete net vlan all
sudo ssh 192.168.1.31 tmsh load sys config merge file 6_cgnat_alg.scf
