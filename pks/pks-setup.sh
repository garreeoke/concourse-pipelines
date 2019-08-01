#!/bin/bash
# EDIT name and domain
CONCOURSE_ENDPOINT=10.173.61.53:8080
CONCOURSE_TARGET=pks-concourse
PIPELINE_NAME=pks-install
PIPELINE_FILE_PATH="/home/nsx-t-ci-pipeline/pipelines/install-pks-pipeline.yml"
CONCOURSE_USER=vmware
CONCOURSE_PW=vmware

alias fly-pks-s="fly -t $CONCOURSE_TARGET set-pipeline -p $PIPELINE_NAME -c $PIPELINE_FILE_PATH -l pks-params.yml"
alias fly-pks-d="fly -t $CONCOURSE_TARGET destroy-pipeline -p $PIPELINE_NAME" 
alias fly-pks-l="fly -t $CONCOURSE_TARGET containers | grep $PIPELINE_NAME"
alias fly-pks-h="fly -t $CONCOURSE_TARGET hijack -b "
echo "Concourse target set to $CONCOURSE_ENDPOINT"
echo "Login using fly"
echo ""

fly --target $CONCOURSE_TARGET login -u $CONCOURSE_USER -p $CONCOURSE_PW --concourse-url http://${CONCOURSE_ENDPOINT} -n main
