#!/bin/bash

cd /Users/romanberg/project/docker-conanexiles
docker-compose up -d
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' docker-conanexiles_ce0_1
