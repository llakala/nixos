{ pkgs, ... }:
{
  # Fixes this warning:
  # qt.qpa.services: Failed to register with host portal QDBusError("org.freedesktop.portal.Error.Failed", "Could not register app ID: App info not found for 'org.kde.ksshaskpass'")
  environment.systemPackages = [
    pkgs.kdePackages.ksshaskpass
  ];
}
