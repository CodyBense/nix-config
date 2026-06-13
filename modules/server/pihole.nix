{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.pihole-ftl = {
    enable = true;
    openFirewallDNS = true;
    openFirewallDHCP = true;
    openFirewallWebserver = true;
    queryLogDeleter.enable = true;

    settings = {
      dhcp = false;
      ipv6 = false;
      dns.upstream = [ "9.9.9.9" "1.1.1.1" "8.8.8.8" ];
      hosts = [ "192.168.1.232" ];
    };

    lists = [
      {
        url = "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";
        type = "block";
        enabled = true;
        description = "Migrated from /etc/pihole/adlists.list";
      }
      {
        url = "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/pro.txt";
        type = "block";
        enabled = true;
        description = "HaGeZi's Pro DNS Blocklist";
      }
    ];
  };

  services.pihole-web = {
    enable = true;
    ports = [ "9080" ];
  };
}
