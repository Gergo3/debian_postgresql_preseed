#!/bin/bash

##ssh root login
#in-target sed -i 's/^#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config; \
#in-target systemctl restart ssh0
#
##ssh belpés jelszóva
#in-target sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config; \
#in-target systemctl restart ssh
#
##sshport
#d-i preseed/late_command string \
#    in-target sed -i 's/#Port 22/Port 31453/' /etc/ssh/sshd_config; \
#    in-target systemctl restart ssh
#

#rootlogin
sed -i 's/^#PermitRootLogin.*/PermitRootLogin yes/' /target/etc/ssh/sshd_config

#jelszobelepes
sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication yes/' /target/etc/ssh/sshd_config

#sshport
sed -i 's/#Port 22/Port 31453/' /target/etc/ssh/sshd_config
