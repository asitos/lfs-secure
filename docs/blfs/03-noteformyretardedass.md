my shitty internet doesnt work and i cant even download 90% of the packages atm, im making this note to remember where to continue from when i chroot in the next time

unpacked make-ca tarball and performed the sed commmand to remove -t option from mktemp commands in the script
then installed the package with 755? perms at /etc/ssl/local

need to install important dependencies for it, like p11-kit, which requires libtasn1

make sure to install those first, then continue with make-ca
