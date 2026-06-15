packer {
  required_plugins {
    virtualbox = {
      version = "~> 1"
      source  = "github.com/hashicorp/virtualbox"
    }
  }
}

source "virtualbox-iso" "ubuntu" {
  cpus             = 4
  memory           = 16384
  guest_os_type    = "Ubuntu_64"
  iso_url          = "https://releases.ubuntu.com/resolute/ubuntu-26.04-live-server-amd64.iso"
  iso_checksum     = "file:https://releases.ubuntu.com/resolute/SHA256SUMS"
  ssh_username     = "ntomic"
  ssh_password     = "password"
  ssh_timeout      = "20m"
  shutdown_command = "echo 'password' | sudo -S shutdown -P now"
}

build {
  sources = ["sources.virtualbox-iso.ubuntu"]
}
