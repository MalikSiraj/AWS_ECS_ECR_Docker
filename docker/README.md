How to deploy Nodejs Dockerised Applicaion on AWS ECS cluster
This is divided in two steps  
First Step: How to deploy Nodejs Dockerised Applicaion on local docker container 

Prerequisite

Install docker (https://www.docker.com/products/docker-desktop/)
Install nodejs (https://nodejs.org/en/download/)

Clone this repository and go inside the the docker folder

Run command 
npm install
node server.js

Open other terminal and type
curl http://localhost:8080

Now you have run the nodejs app on your desktop

Next step is to create a Dockerfile and .dockerignore (which is already present) 

Write the following command
docker container ls 
(You will find no contianer running)

Now build the docker image from the source code
docker build -t nodejs-app .
check the image
docker image ls
Run the docker container 
docker run -p 49160:8080 -d nodejs-app:latest

To check container working, type the following command
curl http://localhost:49160 


Second Step: How to deploy Nodjs container on ECR and depoy it on ECS cluster

Now go to ECR and create a repository (Name of repository should be same as docker container image name)

Once repository is created open the repository
On top click on "View push commands"
Type these commands


