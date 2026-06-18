#!/bin/sh -eux

OS_NAME=$(uname -s)

echo "installing updates"
echo "disable systemd apt timers/services"
systemctl stop apt-daily.timer
systemctl stop apt-daily-upgrade.timer
systemctl disable apt-daily.timer
systemctl disable apt-daily-upgrade.timer
systemctl mask apt-daily.service
systemctl mask apt-daily-upgrade.service
systemctl daemon-reload
# Disable periodic activities of apt to be safe
cat <<EOF >/etc/apt/apt.conf.d/10periodic
APT::Periodic::Enable "0";
APT::Periodic::Update-Package-Lists "0";
APT::Periodic::Download-Upgradeable-Packages "0";
APT::Periodic::AutocleanInterval "0";
APT::Periodic::Unattended-Upgrade "0";
EOF

# Disable interactive questions
export DEBIAN_FRONTEND=noninteractive

echo "disable release-upgrades"
sed -i.bak 's/^Prompt=.*$/Prompt=never/' /etc/update-manager/release-upgrades

echo "remove the unattended-upgrades and ubuntu-release-upgrader-core packages"
rm -rf /var/log/unattended-upgrades;
apt-get -y purge unattended-upgrades ubuntu-release-upgrader-core;

echo "update the package list"
apt-get -y update;

echo "upgrade all installed packages incl. kernel and kernel headers"
apt-get -y dist-upgrade -o Dpkg::Options::="--force-confnew";

# Check reboot-required
REBOOT_NEEDED=false
# Check for the /var/run/reboot-required file (common on Debian/Ubuntu)
if [ -f /var/run/reboot-required ]; then
  REBOOT_NEEDED=true
# Check for the needs-restarting command (common on RHEL based systems)
elif command -v needs-restarting > /dev/null 2>&1; then
  # needs-restarting -r: indicates a full reboot is needed (exit code 1)
  # needs-restarting -s: indicates a service restart is needed (exit code 1)
  if needs-restarting -r > /dev/null 2>&1 || needs-restarting -s > /dev/null 2>&1; then
    REBOOT_NEEDED=true
  fi
else
  echo "Unable to determine if a reboot is needed defaulting to reboot anyway"
  REBOOT_NEEDED=true
fi

if [ "$REBOOT_NEEDED" = true ]; then
  echo "pkgs installed needing reboot"
  shutdown -r now
  sleep 60
else
  echo "no pkgs installed needing reboot"
fi
