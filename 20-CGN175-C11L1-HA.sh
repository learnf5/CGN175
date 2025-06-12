    # add static routes to training server and jump host
    sudo ssh 192.168.1.31 -t ssh 172.16.20.1 ip route add 40.0.101.0/24 via 172.16.1.33
    sudo ssh 192.168.1.31 -t ssh 172.16.20.1 ip route add 40.0.102.0/24 via 172.16.2.33
    sudo ip route add 172.16.0.0/16 via 10.10.1.33

    # download config script from GitHub, copy to bigip1 and 2 and run on bigip1 and 2; make other config changes to bigip1 and 2
    curl --silent https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/2_cgnat_base_1.scf -o /tmp/2_cgnat_base_1.scf
    curl --silent https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/cgnat_base_2.scf -o /tmp/cgnat_base_2.scf
    sudo scp /tmp/2_cgnat_base_1.scf 192.168.1.31:/var/local/scf
    sudo scp /tmp/cgnat_base_2.scf 192.168.2.31:/var/local/scf
    sudo ssh 192.168.1.31 tmsh mod sys state-mirroring addr none
    sudo ssh 192.168.1.31 tmsh mod cm device bigip1.f5trn.com configsync-ip none
    sudo ssh 192.168.1.31 tmsh mod cm device bigip1.f5trn.com unicast-address none
    sudo ssh 192.168.1.31 tmsh delete net self all
    sudo ssh 192.168.1.31 tmsh delete net vlan all
    sudo ssh 192.168.1.31 tmsh load sys config merge file 2_cgnat_base_1.scf
    sudo ssh 192.168.2.31 tmsh mod sys state-mirroring addr none
    sudo ssh 192.168.2.31 tmsh mod cm device bigip2.f5trn.com configsync-ip none
    sudo ssh 192.168.2.31 tmsh mod cm device bigip2.f5trn.com unicast-address none
    sudo ssh 192.168.2.31 tmsh delete net self all
    sudo ssh 192.168.2.31 tmsh delete net vlan all
    sudo ssh 192.168.2.31 tmsh load sys config merge file cgnat_base_2.scf
