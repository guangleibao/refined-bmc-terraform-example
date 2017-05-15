## BMC Windows VM Creation and Block Device Attach Example ##

+ Why the process is like this? Why not just user_data?
	- BMC provided Windows image does not comes with cloud-init or opc-init packages(at least currently we don't), user_data you assigned at instance lunching will be ignored. (Just for Windows, not Linux).
	- So, for Terraform, we have to use remote execute provisoner to do it. (Of course Chef or other management tools are also feasible)

+ Local provisioner (your machine) preparation:
	- https://github.com/masterzen/winrm-cli

+ Windows VM image preparation:
	- Spin up a Windows VM.
	- Change firewall to allow inbound port 5985.
	- Execute following commands:

			winrm quickconfig
			y
			winrm set winrm/config/service/Auth '@{Basic="true"}'
			winrm set winrm/config/service '@{AllowUnencrypted="true"}'
			winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="1024"}'

	- Give administrator a password.
	- Burn as a new image.
	- Record the image OCID, you will need it.

+ Assign values to variabels in env-vars file.

+ Set variables by using env-vars.

+ Set the image id in compute.tf file.

+ run `terraform plan`. Toubleshoot if needed.

+ run `terraform apply`. Toubleshoot if needed.
