## Deploy NSX-T with Concourse

1. From your home directory `cd ~` Clone the NSX-T pipeline repo and checkout the appropriate branch.

    `git clone https://github.com/vmware/nsx-t-datacenter-ci-pipelines.git`

2. Complete and copy the nsx-t parameters [file](nsbu-nsx-t-params.yml) for your vSphere environment.


3. Import the NSX pipeline using the `fly` cli command on your concourse host.

    * `cd ~/concourse-pipelines/nsxt`
    * Edity nsxt-setup.sh
    	* Change CONCOURSE_ENDPOINT to your concourse host `fqdn:8080`
    	* Change PIPELINE_FILE_PATH to the full path to the pipeline yml
    * `source nsxt-seteup.sh`
    * `fly-nsxt-s`
    * confirm the parameters file import with `y`
    * `fly-nsxt-u`

4. Go back to the web browser and confirm that the pipeline has imported

5. Click on *install-nsx-t* 

6. Verify that the pipeline is not in an *errored* state.
- You will see Maroon colored boxes if the pipline is errored out.
    - If it is in an errored state perform a `fly-nsx-d` and `fly-nsx-s` to destory and re-import the pipeline on the cli-vm.

7. Click on the **install-nsx-t**

8. Execute the pipeline by clicking on the **Plus** button in the upper right-hand corner

9. Grab some coffee and watch the magic happen! 

10. Verify NSX-T (Below)

## Verify NSX-T ##

### TEP to TEP Communication ###
1. ssh in to two esx hosts that are prepped for NSX
2. On each host:
    * List vmknics: $ esxcfg-vmknic -l
    * Look for IP address of vmk10
    * Ping vmk10 of other host: $ vmkping ++netstack=vxlan -I vmk10 x.x.x.x
    * Ping vmk10 of other host with MTU 1600: $ vmkping ++netstack=vxlan -d -s 1572 -I vmk10 x.x.x.x 

### Within NSX Manager ###
1. Login, go to Fabric from the left menu
    * Verify all hosts have deployment status of NSX Installed
2. Select Edges from the top menu
    * Deployment, Controller, and Manager status should be green
3. Select Transport Nodes from top menu
    * Configuration should be Succes and status should be up
    * Click on one of the nodes that is Fabric Node Type = Host - ESXi *
    * Click edit on the Overview 
    * Click nVDS on top to switch view
    * Make sure uplink profile and the correct vmnic are selected. Remember the name for next step
4. Verify uplink profile
    * From the left menu, select Fabric->Profiles
    * Verify the vlan column has the correct vlan for the tep network for the profile found in previous step
5. Select Networking/Routers from left menu
    * Verify routers creation of T0 and T1 routers (one T0 and two T1s)

### Test ingress/egress ###
1. On a VM or ssh session not deployed on NSX logical switch (your desktop)
    * Ping the logical switch gateways.  In the nsbu-nsx-t-params.yml file, search for logical_switch_gw. Try pinging each one (Should be two).
2. On the pks-client VM or another vm that is deployed on the logical switch
    * Connect the unused nic to the pks-mgmt logical switch (Use last available IP in the PKS-MGMT block)
    * Ping logical switch gateways (see above)
    * Ping edge gateway vip (search for tier0_ha_vip: in params file)
    * Ping physical switch gateway

[Read this for a good article on what is configured for NSX-T](http://keithlee.ie/2018/11/24/pks-nsx-t-home-lab-part-8-configure-nsx-t/)


