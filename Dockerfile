FROM jenkins/jenkins:latest 
USER root # use root

# Update and install python stuff
RUN apt-get update && apt-get install -y lsb-release python3-pip

# Add docker archive keyring
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg

# Add repo to sources using keyring
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

# install docker stuff
RUN apt-get update && apt-get install -y docker-ce-cli                                      

# Using user jenkins install plugins
USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean:latest docker-workflow:latest"
