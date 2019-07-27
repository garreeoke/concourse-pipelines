## Deploy NSX-T with Concourse

1. From your home directory `cd ~` Clone the NSX-T pipeline repo and checkout the appropriate branch.

    `git clone https://github.com/vmware/nsx-t-datacenter-ci-pipelines.git`
    `git checkout [branch]`
    `git pull`

    The branch you use should correspond to the version of nsx-t (i.e 2.4.0 for NSX 2.4.x)

2. Complete and copy the nsx-t parameters [file](nsbu-nsx-t-params.yml) for your vSphere environment.

3. Import the nsx-t pipeline with your parameters into Concourse using [nsxt-setup.sh](nsxt-setup.sh). You will need to change the "CONCOURSE_ENDPOINT" to your concourse host `fqdn:8080`. You may also have to change this line `alias fly-s="fly -t $CONCOURSE_TARGET set-pipeline -p $PIPELINE_NAME -c ~/nsx-t-datacenter-ci-pipelines/pipelines/nsx-t-install.yml -l nsbu-nsx-t-params.yml"` to match where your repo was cloned to and where you saved the parameters file.

    `source nsxt-setup.sh`

4. Import the NSX pipeline using the `fly` cli command on your concourse host.

    `cd ~/concourse-pipelines/nsxt`

    `source nsxt-setup.sh`

    `fly-s`
    - confirm the parameters file import with `y`
    `fly-u`

5. Go back to the web browser and confirm that the pipeline has imported

6. Click on *install-nsx-t* 

7. Verify that the pipeline is not in an *errored* state.
- You will see Maroon colored boxes if the pipline is errored out.
    - If it is in an errored state perform a `fly-d` and `fly-s` to destory and re-import the pipeline on the cli-vm.

8. Click on the **install-nsx-t**

9. Execute the pipeline by clicking on the **Plus** button in the upper right-hand corner

10. Grab some coffee and watch the magic happen! 

