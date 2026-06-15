packer {
  required_plugins {
    virtualbox = {
      version = "~> 1"
      source  = "github.com/hashicorp/virtualbox"
    }
  }
}

source "virtualbox-iso" "ubuntu" {
  # LAB 1
  iso_url       = "https://releases.ubuntu.com/resolute/ubuntu-26.04-live-server-amd64.iso"
  iso_checksum  = "file:https://releases.ubuntu.com/resolute/SHA256SUMS"
  guest_os_type = "Ubuntu_64"

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

  accelerator = "kvm"
  format      = "qcow2"
}

build {
  sources = [
    "sources.virtualbox-iso.ubuntu",
    "sources.qemu.ubuntu"
  ]

  provisioner "shell" {
    pause_before = "10s"
    scripts      = ["${path.root}/scripts/print_env.sh"]
  }
}
