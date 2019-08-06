## Deploy PKS with Concourse ##
1. From your home directory `cd ~` Clone the NSX-T pipeline repo and checkout the appropriate branch.

    `git clone https://github.com/garreeoke/nsx-t-ci-pipeline.git`

2. Complete and copy the pks parameters [file](pks-params.yml) for your vSphere environment.

3. Import the pks pipeline with your parameters into Concourse using [pks-setup.sh](pks-setup.sh). You will need to change the "CONCOURSE_ENDPOINT" to your concourse host `fqdn:8080` and change the PIPELINE_FILE_PATH to the full path to where you cloned the pipeline.

4. Register pipeline
    `cd ~/concourse-pipelines/pks`
    `source pks-seteup.sh`
    `fly-pks-s`
    - confirm the parameters file import with `y`
    `fly-pks-u`

5. Go back to the web browser and confirm that the pipeline has imported

6. Click on *pks-install* 

7. Verify that the pipeline is not in an *errored* state.
- You will see Maroon colored boxes if the pipline is errored out.
    - If it is in an errored state perform a `fly-pks-d` and `fly-pks-s` to destory and re-import the pipeline on the cli-vm.

8. Click on the **pks-install**

9. Execute the pipeline by clicking on the **Plus** button in the upper right-hand corner

10. Grab some coffee and watch the magic happen! 