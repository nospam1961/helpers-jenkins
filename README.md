# helpers-jenkins

From Jenkins.io: https://www.jenkins.io/doc/book/installing/docker/

Helpers to install and setup jenkins

## Install: Manual

### You can build image manually using Dockerfile
``` docker build -t myjenkins-blueocean:letest . ```

### Can create docker network for jenkins manually:
`docker network create jenkins`

### Can run the container (for win substitute \ with `)
```
docker run --name jenkins-blueocean --restart=on-failure --detach \
  --network jenkins --env DOCKER_HOST=tcp://docker:2376 \
  --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 \
  --publish 8080:8080 --publish 50000:50000 \
  --volume jenkins-data:/var/jenkins_home \
  --volume jenkins-docker-certs:/certs/client:ro \
  myjenkins-blueocean:latest
```


## Install: Automated (please check Host port specified in docker-compose.yml)

### Or build and start docker container using docker-compose
`$ docker-compose up -d`


## Setup

### Navigate to https://localhost:8080/ (or any other port you specified to be visible by host)
`/var/jenkins_home/secrets/initialAdminPassword`

### Print password from within runing docker container
`$ docker exec -it jenkins-blueocean cat /var/jenkins_home/secrets/initialAdminPassword`

### Paste password and choose `Install suggested plugins`

### Create First Admin User


### Setup Proxy
Since jenkins runs in a docker container, docker host URI will not be able to reach host URI from within running container.
Special `proxy` container needed to forward traffic from Jenkins to Docker on the Host machine.
More info: ttps://stackoverflow.com/questions/47709208/how-to-find-docker-host-uri-to-be-used-in-jenkins-docker-plugin
#### Proxy container: alpine/socat
```shell
$ docker run -d --restart=always -p 127.0.0.1:2376:2375 --network jenkins -v /var/run/docker.sock:/var/run/docker.sock alpine/socat tcp-listen:2375,fork,reuseaddr unix-connect:/var/run/docker.sock
```

# Get IP address to be used from within Jenkins
```shell
$ docker inspect <container_id> | grep IPAddress
# or
$ docker inspect socat_proxy | grep IPAddress
```
