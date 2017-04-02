#!/bin/bash
docker rm $(docker ps -a -q)
docker build -t machozhao/db2-install db2-install
docker build -t machozhao/sds-install sds-install
docker build -t machozhao/sds-instance sds-instance

