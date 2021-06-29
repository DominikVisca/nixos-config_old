# Installation von NixOS

## Tastaturlayout und Session etablieren
Standardmäßig ist ein US-Tastaturlayout eingestellt, welches mit folgendem Befehl geändert werden kann:

```
loadkeys de-latin1
```

Anschließend die aktuelle Sitzung als root ausführen, damit man sich das voranstellen von sudo sparen kann.

```
sudo -i
```

## Laufwerk vorbereiten
Sicherheitshalber sollte das Laufwerk einmal überschrieben werden.

```
sudo wipefs -a /dev/sda
```

## Partitionieren
Neue Partitionstabelle anlegen:

```
parted /dev/sda -- mklabel gpt
```

Boot-Partition anlegen:

```
parted /dev/sda -- mkpart ESP fat32 1MiB 512MiB
parted /dev/sda -- set 1 boot on
```

Hauptpartition anlegen:

```
parted /dev/sda -- mkpart primary 512MiB 100%
```

## Hauptpartition verschlüssen
Die Partition wird mit LUKS verschlüssel und trägt den Namen `crypted`.

```
cryptsetup luksFormat /dev/sda2
cryptsetup luksOpen /dev/sda2 crypted
```

Das physische Laufwerk wird gemappt und anschließend wird eine Laufwerkgruppe sowie zwei logische Laufwerke für root und swap angelegt.

```
pvcreate /dev/mapper/crypted
vgcreate vg /dev/mapper/crypted
lvcreate -L 8G -n swap vg
lvcreate -l '100%FREE' -n nixos vg
```

## Festplatte formatieren
Boot erhält FAT32, das Hauptsystem ext4. Außerdem folgt noch eine swap-Partition:

```
mkfs.fat -F 32 -n boot /dev/sda1
mkfs.ext4 -L nixos /dev/vg/nixos
mkswap -L swap /dev/vg/swap
```

## Laufwerke einbinden
Das Hauptsystem wird in /mnt eingebunden, die UEFI-Boot-Partition in /mnt/boot. Anschließend wird noch die swap-Parition aktiviert:

```
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
swapon /dev/vg/swap
```

## Konfigurationsdateien erstellen
```
nixos-generate-config --root /mnt
```

## Rest
Verzeichnis klonen und install.sh ausführen. Anschließend noch die UUID von /dev/sda2 in der Konfiguration anpassen.

Installation mit `nixos-install` beenden.

## Quelle
https://gist.github.com/walkermalling/23cf138432aee9d36cf59ff5b63a2a58