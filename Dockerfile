FROM debian:stable

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update
RUN apt-get -y install sudo ssh screen

RUN useradd -m -s /bin/bash screen && \
    chmod u+s /usr/bin/screen && \
    chmod 755 /var/run/screen

RUN echo 'screen:changeme' | chpasswd  

ADD screenrc /home/screen/.screenrc
ADD add-screen-user.sh /usr/local/bin/add-screen-user.sh

RUN chmod +x /usr/local/bin/add-screen-user.sh && \
    chown screen:screen /home/screen/.screenrc

# make screen a sudo all account
RUN echo "screen  ALL = /usr/local/bin/add-screen-user.sh " >>/etc/sudoers

RUN echo "echo" >>/home/screen/.bashrc
RUN echo "echo \"to add user: sudo add-screen-user.sh\"" >>/home/screen/.bashrc
RUN echo "echo \"to start multiuser screen: screen -d -m -S shared && screen -r share\"" >>/home/screen/.bashrc


RUN mkdir /var/run/sshd
CMD /usr/sbin/sshd -D

