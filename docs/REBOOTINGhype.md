REBOOTING IN A FEW MINS I edited the grub file on my arch host and used grub-mkconfig after putting my lfs entry in /etc/grub.d/40_custom

here's the part:

'''bash
menuentry "Linux From Scratch (systemd)" {
    insmod part_gpt
    insmod ext2
    set root='hd0,gpt4'
    linux /boot/vmlinuz-6.18.10-lfs-13.0-systemd root=/dev/nvme0n1p4 ro
}
'''

either its boots up without any significant errors the first time
or i break my fragile arch+gentoo+lfs triple boot system for the third time ;-;
goodnight 
im so excited tho holy shit
