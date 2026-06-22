broke my lfs 4 times lol

1. first two times were mostly gcc16 conflicts while building gcc15.2 for lfc, fixed by using gcc15.2 i accidentally installed on my arch host system instead of lfs chroot environment

2.  used root outside of chroot while building some packages, which leaked into my arch host distro, broke my system, had to repair via live usb

3. set environment variables like CFlags and CXXFlags to permanently use gcc-15, forgot to unset them for later packages, which caused issues while entering chroot environment

4. permission issues while restarting the project, had to transfer back ownership from root to user lfs after messing up
