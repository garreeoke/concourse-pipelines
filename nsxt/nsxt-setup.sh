#!/bin/bash

# EDIT names and domain
CONCOURSE_ENDPOINT=10.173.61.53:8080 #CHANGE_ME
CONCOURSE_TARGET=pks-concourse
PIPELINE_NAME=install-nsx-t
PIPELINE_FILE_PATH="/home/nsx-t-datacenter-ci-pipelines/pipelines/nsx-t-install.yml"
CONCOURSE_USER=vmware
CONCOURSE_PW=vmware

alias fly-nsx-s="fly -t $CONCOURSE_TARGET set-pipeline -p $PIPELINE_NAME -c $PIPELINE_FILE_PATH -l nsbu-nsx-t-params.yml"
alias fly-nsx-d="fly -t $CONCOURSE_TARGET destroy-pipeline -p $PIPELINE_NAME"
alias fly-nsx-l="fly -t $CONCOURSE_TARGET containers | grep $PIPELINE_NAME"
alias fly-nsx-h="fly -t $CONCOURSE_TARGET hijack -b "
alias fly-nsx-u="fly -t $CONCOURSE_TARGET unpause-pipeline -p $PIPELINE_NAME"
alias fly-nsx-p="fly -t $CONCOURSE_TARGET pause-pipeline -p $PIPELINE_NAME"

echo "Concourse target set to $CONCOURSE_ENDPOINT"
echo "Login using fly"
echo ""

fly --target $CONCOURSE_TARGET login -u $CONCOURSE_USER -p $CONCOURSE_PW --concourse-url http://${CONCOURSE_ENDPOINT} -n main
