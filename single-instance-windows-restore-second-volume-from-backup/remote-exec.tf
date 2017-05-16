resource "null_resource" "remote-exec" {
    depends_on = ["baremetal_core_instance.TFInstanceW","baremetal_core_volume_attachment.TFBlock0Attach"]
    provisioner "remote-exec" {
      connection {
        type = "winrm"
        agent = false
        timeout = "5m"
        host = "${data.baremetal_core_vnic.InstanceVnic.public_ip_address}"
        https = false
        port = "5985"
        user = "Administrator"
        password = "${var.admin_password}"
    }
      inline = [
        "powershell Set-Service -Name msiscsi -StartupType Automatic",
        "  powershell Start-Service msiscsi",
        "  powershell New-IscsiTargetPortal –TargetPortalAddress ${baremetal_core_volume_attachment.TFBlock0Attach.ipv4}",
        "powershell Connect-IscsiTarget -NodeAddress ${baremetal_core_volume_attachment.TFBlock0Attach.iqn} -TargetPortalAddress ${baremetal_core_volume_attachment.TFBlock0Attach.ipv4} -IsPersistent 1 "
      ]
    }
}

