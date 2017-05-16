## BMC Windows VM Creation and Block Device Attach Example ##

+ You must be familiar with example single-instance-windows to use this example. It is almost same as example single-instance-windows, except the attached block device is restored from an existing backup. Please provide the backup OCID to `block.tf`.
	- Timeout added, otherwise restoration progress raises exception. Restoring is much more slower than creating.
	- If volume creation still run into error with timeout in place, just run `terraform apply` twice!

+ Why the process is like this? Why not just user_data?
	- BMC provided Windows image does not comes with cloud-init or opc-init packages(at least currently we don't), user_data you assigned at instance launching will be ignored. (Just for Windows, not Linux).
	- So, for Terraform, we have to use remote execute provisoner to do it. (Of course Chef or other management tools are also feasible)

+ Why `compute.tf` file has to use a custom image?
	- If you spin up a provided Windows image instance, the default user password will be set to "must change before login", this feature effectively disable the `winrm` control scripts used by Terraform provisioner the example use.
	- As a result, you have to create a custom image after you logged-in and change the Administrator's password. 

+ Local provisioner (your machine) preparation (If you are using Windows desktop, you might already have `winrm`, skip this step):
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

+ run `terrform destroy` to bring destruction to the infra yout just created.

