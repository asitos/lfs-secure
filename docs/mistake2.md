its easy to forget mounting the virtual file systems while using chroot for the lfs environment, which causes the package builds to silently fail why configuring or while using make.

make sure to mount virtual filesystems whenever using chroot to enter the clean sterile environment to link the kernel
