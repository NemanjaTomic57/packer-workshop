packer {
  required_plugins {
    virtualbox = {
      version = "~> 1"
      source  = "github.com/hashicorp/virtualbox"
    }
    qemu = {
      version = "~> 1"
      source  = "github.com/hashicorp/qemu"
    }
  }
}

locals {
  iso_url = "https://releases.ubuntu.com/resolute/ubuntu-26.04-live-server-amd64.iso"

  execute_command = "echo 'password' | sudo -S sh -c '{{ .Vars }} {{ .Path }}'"

  environment_variables = {
    FOO      = "BAR"
    HELLO    = "WORLD"
    HOME_DIR = "/home/ntomic"
  }

}

source "virtualbox-iso" "ubuntu" {
  # LAB 1
  iso_url      = local.iso_url
  iso_checksum = "file:https://releases.ubuntu.com/resolute/SHA256SUMS"

  cpus      = 4
  memory    = 16384
  disk_size = 20000

  ssh_username     = "ntomic"
  ssh_password     = "password"
  ssh_timeout      = "20m"
  communicator     = "ssh"
  shutdown_command = "echo 'password' | sudo -S shutdown -P now"

  # LAB 2
  boot_command     = ["<wait>e<wait><down><down><down><end> autoinstall ds=nocloud-net\\;s=http://{{.HTTPIP}}:{{.HTTPPort}}/<wait><f10><wait>"]
  output_directory = "${path.root}/builds/build_files/packer-virtualbox"
  http_directory   = "${path.root}/http"

  # Virtualbox spezifische Parameter
  guest_os_type = "Ubuntu_64"
}

source "qemu" "ubuntu" {
  # LAB 1
  iso_url      = "https://releases.ubuntu.com/resolute/ubuntu-26.04-live-server-amd64.iso"
  iso_checksum = "file:https://releases.ubuntu.com/resolute/SHA256SUMS"

  cpus      = 4
  memory    = 16384
  disk_size = 20000

  ssh_username     = "ntomic"
  ssh_password     = "password"
  ssh_timeout      = "20m"
  communicator     = "ssh"
  shutdown_command = "echo 'password' | sudo -S shutdown -P now"

  # LAB 2
  boot_command     = ["<wait>e<wait><down><down><down><end> autoinstall ds=nocloud-net\\;s=http://{{.HTTPIP}}:{{.HTTPPort}}/<wait><f10><wait>"]
  output_directory = "${path.root}/builds/build_files/packer-qemu"
  http_directory   = "${path.root}/http"

  # QEMU spezifische Parameter
  accelerator = "kvm"
  format      = "qcow2"
}

build {
  sources = [
    "sources.virtualbox-iso.ubuntu",
    # "sources.qemu.ubuntu"
  ]

  # Linux Shell scripts
  # Install updates + guest tools and reboot
  # provisioner "shell" {
  #   execute_command   = local.execute_command
  #   pause_before      = "10s"
  #   expect_disconnect = true
  #   env               = local.environment_variables
  #   scripts = [
  #     "${path.root}/scripts/update_packages.sh",
  #     "${path.root}/scripts/guest_tools_virtualbox.sh"
  #   ]
  # }

  # Print environment variables
  provisioner "shell" {
    execute_command = "echo 'password' | sudo -S sh -c '{{ .Vars }} {{ .Path }}'"
    pause_before    = "10s"
    env = {
      FOO      = "BAR"
      HELLO    = "WORLD"
      HOME_DIR = "/home/ntomic"
    }
    scripts = ["${path.root}/scripts/print_env.sh"]
  }
}
