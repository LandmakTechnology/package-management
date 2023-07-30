#! /bin/bash

sudo docker run -p 8090:8080 -p 50000:50000 --restart=on-failure jenkins/jenkins:lts-jdk11
