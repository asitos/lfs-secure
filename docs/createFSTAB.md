/etc/fstab file was kinda modified against how the book wanted me to make it, since i want my lfs on dual boot 


# Begin /etc/fstab

# file system    mount-point   type     options             dump  fsck
#                                                                 order

/dev/nvme0n1p4   /             ext4     defaults            1     1

# End /etc/fstab
