
# Building and Installing
```
snapcraft
snap install pihole_4.0_amd64.snap --dangerous --devmode
```

If you are developing and want to rebuild, we added a `redo` script that does everything for you.
```
./redo.sh
```

Snapcraft Summit Notes
======================

End of day one

 * pihole dnsmasq fork building
 * Patched to use var/lib/snap instead of /etc and /var/run
 * Created a patchfile rather than ninja files with sed
 * Located files in more logical directories (matching non-snap install under /var/snap/pihole/common)

```
/var/snap/pihole/common/
├── etc
│   └── pihole
│       ├── dnsmasq.conf
│       ├── gravity.list
│       ├── pihole-FTL.db
│       └── setupVars.conf
└── var
    ├── log
    │   └── pihole-FTL.log
    └── run
        ├── dnsmasq.pid
        ├── pihole
        │   └── FTL.sock
        ├── pihole-FTL.pid
        └── pihole-FTL.port
```

Future things

 * Test it works
  - Resolve and block
 * First run wizard
  - whiptail added to stage packages
  - install script + gravity components to munge and install block lists
  - snapctl restart itself
 * Tidy up locations of config files, block lists, lock files
  - currently in /var/snap/pihole/common
 * Refresh block lists
 * Strict confinement
 * Web admin tool
 * Patch upstream pihole-ftl to ifdef $SNAP for paths rather than patch in yaml
