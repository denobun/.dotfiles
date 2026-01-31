# Образ установить через rufus/dd, а не ventoy

# Разделы
cfdisk /dev/диск:
512M > Efi System 
остальной размер> Linux filesystem

# Шифрование
cryptsetup luksFormat /dev/раздел
cryptsetup open /dev/раздел cryptroot

# Форматирование
mkfs.fat -F32 /dev/раздел
mkfs.ext4 /dev/mapper/cryptroot

# Монтирование (порядок важен для genfstab)
mount  /dev/mapper/cryptroot /mnt
mkdir /mnt/boot
mount /dev/раздел /mnt/boot

# Установка системы
pacstrap /mnt base base-devel  linux-zen linux-firmware cryptsetup nvim networkmanager

genfstab -U /mnt >> /mnt/etc/fstab

# Заход в систему и установка пароля для root
arch-chroot /mnt
passwd

# Закомментировать хуки и добавить эти в /etc/mkinitcpio.conf. Udev + encrypt (systemd + sd-encrypt не нравится)
HOOKS=(base udev autodetect microcode modconf keyboard encrypt block filesystems fsck)

# Cборка initramfs
mkinitcpio -P

# Установка systemd-boot (можно игнорить предупреждения, ибо на FAT32 нельзя поставить unix права)
bootctl install

# Закидывание UUID раздела
cryptsetup luksUUID /dev/раздел >> /boot/loader/entries/zen.conf

# Конфигурация Zen ядра /boot/loader/entries/zen.conf
title   Arch Linux (Zen)
linux   /vmlinuz-linux-zen
initrd  /initramfs-linux-zen.img
options cryptdevice=UUID=<UUID>:cryptroot root=/dev/mapper/cryptroot rw

# Общий конфиг бутлоадера
/boot/loader/loader.conf:
timeout 3
editor no
console-mode keep

# Вход в ОС
exit
reboot