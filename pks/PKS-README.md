## Deploy PKS with Concourse ##
1. From your home directory `cd ~` Clone the NSX-T pipeline repo and checkout the appropriate branch.

    `git clone https://github.com/garreeoke/nsx-t-ci-pipeline.git`

2. Complete and copy the pks parameters [file](pks-params.yml) for your vSphere environment.

3. Setup and Register pipeline

    * `cd ~/concourse-pipelines/pks`
    * Edity pks-setup.sh
    	* Change CONCOURSE_ENDPOINT to your concourse host `fqdn:8080`
    	* Change PIPELINE_FILE_PATH to the full path to the pipeline yml
    * `source pks-seteup.sh`
    * `fly-pks-s`
    * confirm the parameters file import with `y`
    * `fly-pks-u`

4. Go back to the web browser and confirm that the pipeline has imported

5. Click on *pks-install* 

6. Verify that the pipeline is not in an *errored* state.
- You will see Maroon colored boxes if the pipline is errored out.
    - If it is in an errored state perform a `fly-pks-d` and `fly-pks-s` to destory and re-import the pipeline on the cli-vm.

7. Click on the **pks-install**

8. Execute the pipeline by clicking on the **Plus** button in the upper right-hand corner

9. Grab some coffee and watch the magic happen! 