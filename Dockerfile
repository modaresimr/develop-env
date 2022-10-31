FROM ubuntu-focal-dind:develop
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

RUN  apt-get update \
    && apt-get install -y apt-transport-https xfdashboard docker-compose ssh zsh \
	&& echo "ListenAddress 0.0.0.0" >> /etc/ssh/sshd_config \ 
	&& echo "PasswordAuthentication no" >> /etc/ssh/sshd_config \
	&& mkdir -p /run/sshd/


ENV DEFAULT_USER ali

COPY ./src/supervisor/* /etc/supervisor/conf.d/
COPY ./src/startup/* /$STARTUPDIR/

RUN \
	usermod -u 1001 kasm-user &&\
	useradd $DEFAULT_USER --non-unique -u 1000 -g 1000 -d /home/$DEFAULT_USER -s /bin/zsh &&\
	usermod -a -G kasm-user $DEFAULT_USER &&\
	#echo "$DEFAULT_USER:$DEFAULT_USER" | chpasswd &&\
	echo "$DEFAULT_USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers &&\
	adduser $DEFAULT_USER docker
######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/$DEFAULT_USER
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000