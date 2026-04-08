{ config, pkgs, lib, ... }:
let
  cfg = config.module.service.nftables;

in {
  options.module.service.nftables = {
    enable = lib.mkEnableOption "nftables";
    ruleset = lib.mkOption {
      type = lib.types.lines;
      default =
      ''
        table inet filter {
          chain input {
            type filter hook input priority 0; policy drop;
            ct state established,related accept
            iifname "lo" accept

            icmp type { destination-unreachable, time-exceeded, parameter-problem } accept
            icmp type echo-request limit rate 5/second accept

            icmpv6 type { destination-unreachable, packet-too-big, time-exceeded, parameter-problem, nd-router-advert, nd-neighbor-solicit, nd-neighbor-advert } accept
            icmpv6 type echo-request limit rate 5/second accept
          }
          chain forward {
            type filter hook forward priority 0; policy drop;
            ct state established,related accept
          }

          chain output {
            type filter hook output priority 0; policy drop;
            ct state established,related accept
            oifname "lo" accept

            tcp dport { 22, 53, 80, 443 } accept
            udp dport { 53, 123 } accept
          }
        }
      '';
    };
  };
  config = lib.mkIf cfg.enable {
    networking.firewall.enable = lib.mkForce false;
    networking.nftables = {
      enable = true;

      ruleset = cfg.ruleset;
    };
  };  
}
