#!/bin/bash

# this script will clone code from repo and deploy application


clone_code(){
     echo "clonning the code"
     git clone https://github.com/LondheShubham153/django-notes-app.git
}

install_requirements(){
    echo "install dependencies"
    
    sudo apt-get update
    
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    
    sudo apt install nginx -y
}

required_restart(){
    sudo usermod -aG docker $USER
    sudo chmod 666 /var/run/docker.sock
    sudo chown $USER var/run/docker.sock
    sudo systemctl enable docker
    sudo systemctl enable nginx
    sudo systemctl restart docker
}

deploy(){
   docker build -t nodes-app .
   docker run -d -p 8000:8000 nodes-app
}


echo "****************** Deployment start *************************"
if ! clone_code; then
        echo "the code directory already exists"
        cd django-notes-app
fi
install_requirements
if ! required_restart; then
        echo "System fault intrepted"
        exit 1
fi
if ! deploy; then
        echo "deployment failed"
        exit 1
fi
echo "***************** Deployment Done **************************"
