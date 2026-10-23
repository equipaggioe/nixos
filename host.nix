# Machine-specific values. Each pending one throws so evaluation fails loudly
# until it is filled in; scripts/collect.sh gathers the hardware ones.
{
  user = throw "pending: user name";
  hostName = throw "pending: host name";
  uefi = throw "pending: confirm the machine boots in UEFI mode (scripts/collect.sh)";
  stateVersion = throw "pending: NixOS release used for the first install";
  data = {
    uuid = throw "pending: data partition UUID (scripts/collect.sh)";
    mountPoint = throw "pending: data partition mount point";
  };
}
