resource "baremetal_core_volume" "TFBlock0" {
  availability_domain = "${lookup(data.baremetal_identity_availability_domains.ADs.availability_domains[var.AD - 1],"name")}" 
  compartment_id = "${var.compartment_ocid}"
  display_name = "TFBlock0"
  size_in_mbs = "${var.256GB}"
  volume_backup_id = "<BACKUP_OCID>"
  timeouts {
    create = "60m"
  }
}

resource "baremetal_core_volume_attachment" "TFBlock0Attach" {
    depends_on = ["baremetal_core_volume.TFBlock0", "baremetal_core_instance.TFInstanceW"]
    attachment_type = "iscsi"
    compartment_id = "${var.compartment_ocid}"
    instance_id = "${baremetal_core_instance.TFInstanceW.id}" 
    volume_id = "${baremetal_core_volume.TFBlock0.id}"
}

