# Define a cloud-init configuration data source named "cloudinit-example"
data "cloudinit_config" "cloudinit-example" {
  # Specify options for cloud-init
  gzip          = false
  base64_encode = false

  # Define the first part of the cloud-init configuration
  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    # Use a template file to generate content, passing the AWS region as a variable
    content      = templatefile("scripts/init.cfg", {
      REGION = var.AWS_REGION
    })
  }

  # Define the second part of the cloud-init configuration
  part {
    content_type = "text/x-shellscript"
    # Use a template file to generate content, passing the instance device name as a variable
    content      = templatefile("scripts/volumes.sh", {
      DEVICE = var.INSTANCE_DEVICE_NAME
    })
  }
}
