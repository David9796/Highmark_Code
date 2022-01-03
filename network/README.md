# Content of this folder
 
- This network folder contains two folders called fwmgmt-glbl-vpc and git-euw4-vpc.
- git-euw4-vpc will create network, subnets, firewall rules, peering and subnet-iam-binding.
- fwmgmt-glbl-vpc will create network, subnets, firewall rules and routes.
- backend.tf file will be used during the deployment for keeping the state file inside the GCS bucket to protect the tfstate file. 
- data.tf is used to fetch the outputs from the remote state file.
- sandbox.tfvars file used to declare variable values.
- Created variables are present in variables.tf file and same values can pass in sandbox.tfvars file
- version.tf file shows the requried terraform version to run this code.
- outputs.tf containing the output needs to be reflected for the deployment.