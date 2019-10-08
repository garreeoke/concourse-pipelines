Concourse Installation and Setup

## Overview

Concourse is an Open source CI/CD pipeline tool used to perform Day 1 and 2 Ops on the CNA platform.
The NSX-T and PKS Pipelines were created to allow our customers a simple way to deploy NSX-T and PKS end to end in a click of a button and to create a repeatable deployment process.

## Concourse Setup

Concourse can be stoodup in many different ways. In this tutorial we will stand it up using a combination of docker images with docker-compose.

### Prereq's:

- Ubuntu 16.04 or later
- Docker 18.06 or later
- Docker-compose
- Git
- [Fly](https://github.com/concourse/concourse/releases/tag/v5.0.0)


1. Clone this repo

    `cd ~`
    `git clone https://github.com/garreeoke/concourse-pipelines.git`

2. Make [generate-keys.sh](generate-keys.sh) file executable

    `cd concourse-nsxt && chmod +x generate-keys.sh`
    
3. Generate keys for Concourse by executing the `generate-keys.sh` file. This will create a keys directory inside of concourse-pipelines.

    `./generate-keys.sh`

4. Download the NSX-T unified ova and ovftools from My.Vmware and copy them in a directory
    1. mkdir /root/nsxt
    2. Download & copy ovas for NSX-T unified installer and the ovftool to /root/nsxt

5. Edit the docker-compose file
    1. Look for the **CHANGE_ME** for items to modify
    2. Edit the domain name and DNS server parameters. This will need to match the host that you are running concourse on and the DNS server that can resolve things like vCenter and the outside world. 

6. Now you're ready to standup Concourse with docker-compose.

    `docker-compose up -d`

7. Login into Concourse from a web browser with the "CONCOURSE_EXTERNAL_URL=http://CHANGEME:8080/" parameter you set here and credentials "CONCOURSE_ADD_LOCAL_USER=nsx:vmware" So in this instance it would be nsx for the user name and vmware for the password.

### If this all worked you have successfully setup Concourse and can move on to running the pipelines for NSX-T and PKS

* [Setup and run NSX pipeline](https://github.com/garreeoke/concourse-pipelines/blob/master/nsxt/NSX-T-README.md)
* [Setup and run PKS pipeline](https://github.com/garreeoke/concourse-pipelines/blob/master/pks/PKS-README.md)



