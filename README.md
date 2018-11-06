
Snapcraft Summit Notes
======================

End of day one

pihole dnsmasq fork building
Patched to use var/lib/snap instead of /etc and /var/run

Things to fix

1. [2018-11-06 17:26:41.293] Starting config file parsing (/var/snap/pihole/common/pihole-FTL.conf)
2. Error on binding on Unix socket /var/snap/pihole/common/pihole/FTL.sock: No such file or directory (2)
3. [2018-11-06 17:26:41.294]    DBFILE: Using /etc/pihole/pihole-FTL.db

Future things

Test it works
  - Resolve and block
First run wizard 
  - whiptail added to stage packages
  - install script + gravity components to munge and install block lists
  - snapctl restart itself
Tidy up locations of config files, block lists, lock files
  - currently in /var/snap/pihole/common
Refresh block lists
Strict confinement
Web admin tool
Patch upstream pihole-ftl to ifdef $SNAP for paths rather than patch in yaml
