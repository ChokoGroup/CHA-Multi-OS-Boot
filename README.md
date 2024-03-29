#
### THIS REPOSITORY IS OBSOLETE

We have changed to a single \.img file with a customized Batocera (and official firmware) were we can use either EmulationStation (Batocera style) or RetroArch (Lakka style) as UI.
The same .img can be used in eMMC (internal memory) and/or SD card.
CHOKO_DISK partition is still supported, although it has lost importance since there is no Lakka SO to share roms and assets.

You'll find the new dualboot system files in https://github.com/ChokoGroup/batocera-CHA


___ The following info is kept for history but should no be used to upgrade to Batocera 39 or later __

# CHA Multi OS Boot
We want that everybody get the most out of the CHA, so here are more options for the CHA: ways to boot Lakka and/or Batocera without losing the official OS.

We provide preinstalled system images so you don't have to do all the process manually, but we release all the scripts and assets for those that want to modify or just want to know how it works.

The preinstalled system images don't include any roms beside those in the offical CHA OS.

**NOTE: Before playing any games in Lakka, make sure to change the "Menu Toggle Controller Combo" or you will have no way to exit games without forcing power off. Check the video file `CHA booting Lakka.mp4`**

**NOTE 2: For Batocera, installing a fan over the CHA heatsink is HIGHLY recommended!**

Version 1.6.1:
- Fix mounting the CHOKO_DISK/remappings folder in wrong place for Batocera 38 (probably 37).


Version 1.6:
- Updated upgrade scripts to check if there is enough space in CHA_BOOT partition before starting to copy.
- Some fixes and improvements in updater scripts, like making sure writing the files in CHA is completed before exiting.


Version 1.5:
Don't use to install Batocera 36 0r older!
- Updated launch scripts for fbalpha2012 and mame2010 roms to work with python 3.11 (Batocera 37).
- Splash videos are enabled again and play correctly (without changing screen resolution) in 4K TVs. There are some in Extras folder. Avoid 1080p videos, 720p play nice.
- If CHOKO_DISK partition is available, it will also be used to save/load splash videos/images.


Version 1.4:
- Remove support for loading Lakka/Batocera in 1080p resolution, to minimize issues due to memory restrictions.
- To help with low memory, a swapfile will be used if CHOKO_DISK partition is available (both in Lakka and Batocera).
- Also in CHOKO_DISK, update folder is used to allow aumomatic download and upgrade of Lakka and Batocera.


We are still using the orangepi-plus2e builds for Lakka instead of the capcom-home-arcade, because of slugish UI.

Also, there are a couple of boot splash videos in Extras folder, in case of interest.


## 
### Quick instructions to write a new \*.img file
1. Read below the available sets, choose one and download the correspondent \*.7z file.
2. Extract the files and read the \*.txt file for important information.
3. If using SD card, write the extracted \*.img file to the SD card using a program like balenaEtcher, Win32 Disk Imager or HDD Raw Copy Tool.
4. If not using SD card, put the CHA in FEL mode ( https://github.com/lilo-san/cha-documentation#enabling-fel-mode ) and then write the extracted \*.img file to the CHA using a program like balenaEtcher, Win32 Disk Imager or HDD Raw Copy Tool.
5. Safelly eject the CHA or SD card from PC and enjoy!


## 
### Quick instructions to update Lakka or Batocera from Choko Menu
1. Download "CHA.Multi.OS.updater.7z" from https://github.com/ChokoGroup/CHA-Multi-OS-Boot/releases/latest
2. Extract the folder "CHA Multi OS updater" to the root of a USB pendisk
3. Download the latest Lakka and/or Batocera \*.img
4. Using 7zip, right click in the downloaded \*.img and:

a) For Lakka, extract the files "sun8i-h3-libretech-all-h3-cc.dtb", "KERNEL" and "SYSTEM" to the folder CHA_BOOT that is inside "CHA Multi OS updater"

b) For Batocera, extract the folder "boot" to the folder CHA_BOOT that is inside "CHA Multi OS updater"

5. Eject the pendisk safely and put it in the USB EXT port of the CHA.
6. Boot the CHA and select "Update Batocera and/or Lakka" in Choko Menu.

CAREFULL! The updater scripts won't check if there is enought space in first partition.

WARNING! If you have an old version of Lakka or Batocera, you probably can't update to Lakka 4.3 (or later) / Batocera 34 (or later) without first resizing the first partition (with a tool like gparted).
Also, updating Batocera to 34+ (or again to 37+) will require to delete `es_systems_fbalpha2012.cfg` and `es_systems_mame2010.cfg` from the folder `system/configs/emulationstation`.
That can be done by the updater scripts or manually, browsing to `\\BATOCERA\share\system\configs\emulationstation` in your home network.


## 
### Main features

All the \*.img can be written either to the internal memory (eMMC) or a SD card (if your CHA has the reader - https://github.com/lilo-san/cha-documentation#hardware-modifications ), but don't use two images with multi systems (because they use the same partition names and can cause trouble).
### 
It's safe to have only CHA OS in eMMC and CHA OS + Batocera in SD card, or CHA OS + Lakka in eMMC and Batocera in SD card, but not CHA OS + Lakka in eMMC and CHA OS + Batocera in SD card.

All the "multi boot" \*.img support loading assets and roms from a fat32 partition labeled "CHOKO_DISK".
This can be pointless if you only have either Lakka or Batocera, because those systems are already able to load from USB, but the main goal was to share the same roms and some assets between Lakka and Batocera and easily manage them from Windows.

All the "multi boot" \*.img include the FB Alpha 2012 core (in Lakka or Batocera) for better performance in some games (PGM, maybe others).

Each \*.img file in this repository has a similar named \*.txt with more details - please read it.


## 
# Select your flavor (read all before choosing)



### CHA OS (with Choko Hack) on eMMC or SD card
You'll have (some) more space available to store games for use with Choko Menu (because it uses all eMMC space), but in SD card it won't automatically expand to use all available space (use some tool line gparted).
Intended to use Choko Hack to load games from USB through Choko Menu.
Get the latest release from https://github.com/ChokoGroup/Choko-Hack/releases/latest
Read more about the hack and released system images in the repository main page at https://github.com/ChokoGroup/Choko-Hack


## 
### Lakka on eMMC or SD card (official build)
You'll boot right into Lakka UI (RetroArch) and can load games from eMMC, SD card or USB.
On first boot, Lakka will expand the ext4 partition to use all available space (either eMMC or SD card).
The official releases can be downloaded from http://www.lakka.tv/get/linux/cha/ but the UI is still buggy and unstable.
For now we should keep using the "Orange Pi Plus 2E build" ( https://www.lakka.tv/get/linux/allwinner/ ) that works perfectly.


## 
### Batocera on eMMC or SD card (official build)
You'll boot right into Batocera UI (EmulationStation) and can load games from eMMC, SD card or USB.
On first boot, Batocera will expand the ext4 partition to use all available space (either eMMC or SD card).
The official releases can be downloaded from https://batocera.org/download


## 
### CHA OS (with Choko Hack) and Lakka
a) On eMMC:
  CHA_DISK is expanded to use eMMC empty space and store games (for Choko Menu) with a small LAKKA_DISK partition. Intended to load games from USB, with or without CHOKO_DISK partition.

b) On SD card:
  CHA_DISK will have the same extra space but LAKKA_DISK partition will expand to use all SD card available. Intended to use large sets of roms with playlists, thumbnails and bezels (in Lakka).


## 
### CHA OS (with Choko Hack) and Batocera
a) On eMMC:
  CHA_DISK is expanded to use eMMC empty space and store games (for Choko Menu) with a small BATOCERA_DISK partition. Batocera can be configured to use any USB disk (with or without CHOKO_DISK partition).
  Just insert any USB disk in the "USB EXT" port of the CHA and on the Batocera's menus go to "System settings > Storage device" to set the desired disk.

b) On SD card:
  CHA_DISK will have the same extra space but BATOCERA_DISK partition will expand to use all SD card available. Intended to use large sets of roms with Batocera and all it's features.


## 
### CHA OS (with Choko Hack) and Lakka and Batocera
a) On eMMC:
  All eMMC space is used, but still CHA_DISK has very little free space to store games (for Choko Menu). The LAKKA_DISK and BATOCERA_DISK partitions are minimal.
  Can load games with Choko Menu but it's intended to use an USB disk and set Batocera and Lakka to use it (can be CHOKO_DISK or not).

b) On SD card:
  CHA_DISK has very little free space (for Choko Menu). The LAKKA_DISK and BATOCERA_DISK partitions are minimal and will NOT expand automatically.
  You are supposed to create a fat32 partition in the empty space of the SD card and label it CHOKO_DISK to share roms and other assets between Lakka and Batocera.
  You could also just move and resize LAKKA_DISK and BATOCERA_DISK using some partition tools, like gparted, and keep the three systems isolated.


# 
### All this "multi boot" \*.img can be downloaded from https://github.com/ChokoGroup/CHA-Multi-OS-Boot/releases/latest


# 
# Instructions to manually build your own \*.img
If you want to make your system image or just want to know how this was done, here are some guidelines.
You'll need some partition tool like gparted.

1. You need CHA OS and Choko Hack already installed, either in eMMC or SD card. Connect the CHA in FEL mode to PC or put the SD card in a PC.

2. Label the second partition (ext4) as CHA_DISK and move it to the right, leaving at least 500MB (for Lakka) or 1 GB (for Batocera) before it (1.5 GB if you want both Lakka and Batocera).

3. Label the first partition (fat) as CHA_BOOT and resize it to use the new free space, but leave 2 MB UNALLOCATED at the beginning of the disk - this is very important, the CHA won't boot if you overwrite this portion of the disk.

4. If you want Lakka, create an ext4 partition labeled LAKKA_DISK, after the CHA_DISK partition.

5. If you want Batocera, create an ext4 partition labeled BATOCERA_DISK, after the CHA_DISK partition.

NOTE: If you are using SD card and want Lakka and Batocera AND use another partition labeled CHOKO_DISK, you'll need to create an extended partition and then create LAKKA_DISK and BATOCERA_DISK inside this extended partition, because there's a limit of 4 primary partitions.

6. If you are using SD card and want another partition labeled CHOKO_DISK to store common roms and assets (to use with Batocera and Lakka), create a fat32 partition labeled CHOKO_DISK. Remember this partition is not really needed.

7. If you want Lakka, copy the files "sun8i-h3-libretech-all-h3-cc.dtb", "KERNEL" and "SYSTEM" to the root of CHA_BOOT partition. You extract those files from the official Lakka \*.img with 7-zip tool.

8. If you want Batocera, copy the file "batocera-boot.conf" and the folder "boot" to the root of CHA_BOOT partition. You extract them from the official Batocera \*.img with 7-zip tool.

9. Eject the CHA or SD card from PC (and put the SD card in the CHA.

10. Copy the folder "CHA Multi OS installer scripts" to the root of a pendisk and insert the pendisk in the USB EXT port.

11. Boot the CHA into Choko Menu and select the options that fit your case to finish installation of Lakka and/or Batocera. You have to run the script once per option.

That's all, folks.
Time to play!
