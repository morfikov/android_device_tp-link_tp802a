#
# Copyright (C) 2017 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# https://forum.xda-developers.com/android/software/twrp-flags-boardconfig-mk-t3333970
# http://rootzwiki.com/topic/23903-how-to-compile-twrp-from-source/

LOCAL_PATH := device/tp-link/tp802a

### Platform
# TARGET_NO_BOOTLOADER tells TWRP, that the phone doesn't have a fastboot mode. If you set this
# flag to true, TWRP will hide the "Reboot to Bootloader/Fastboot" Button
TARGET_NO_BOOTLOADER := false

TARGET_BOARD_PLATFORM := msm8909
TARGET_BOARD_PLATFORM_GPU := qcom-adreno304
TARGET_BOOTLOADER_BOARD_NAME := msm8909

TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := cortex-a7
TARGET_CPU_SMP := true
ARCH_ARM_HAVE_TLS_REGISTER := true

TARGET_GLOBAL_CFLAGS += -mfpu=neon -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS += -mfpu=neon -mfloat-abi=softfp

### Kernel
BOARD_KERNEL_BASE := 0x80000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_OFFSET := 00008000
BOARD_RAMDISK_OFFSET := 0x01000000
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_KERNEL_SEPARATED_DT := false
BOARD_KERNEL_CMDLINE := console=ttyHSL0,115200,n8 androidboot.console=ttyHSL0 androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x237 ehci-hcd.park=3 androidboot.bootdevice=7824900.sdhci lpm_levels.sleep_disabled=1 earlyprintk
#BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
BOARD_MKBOOTIMG_ARGS := \
	--base $(BOARD_KERNEL_BASE) \
	--pagesize $(BOARD_KERNEL_PAGESIZE) \
	--kernel_offset $(BOARD_KERNEL_OFFSET) \
	--ramdisk_offset $(BOARD_RAMDISK_OFFSET) \
	--tags_offset $(BOARD_KERNEL_TAGS_OFFSET) \
	--cmdline '$(BOARD_KERNEL_CMDLINE)'
TARGET_PREBUILT_KERNEL := $(LOCAL_PATH)/kernel

### Qualcomm
#BOARD_USES_QCOM_HARDWARE := true
#COMMON_GLOBAL_CFLAGS += -DQCOM_HARDWARE
TARGET_ENABLE_QC_AV_ENHANCEMENTS := true
TARGET_USE_QCOM_BIONIC_OPTIMIZATION := true
# It has to point to /sys/devices/ directory without /sys/
TARGET_PLATFORM_DEVICE_BASE := /devices/soc.0/
#TARGET_INIT_VENDOR_LIB := libinit_msm
#TARGET_LIBINIT_DEFINES_FILE := $(LOCAL_PATH)/init/...

# Use qcom power hal
TARGET_POWERHAL_VARIANT := qcom
TARGET_USES_CPU_BOOST_HINT := true

### Encryption
TARGET_HW_DISK_ENCRYPTION := true
#TARGET_CRYPTFS_HW_PATH := device/qcom/common/cryptfs_hw
TW_INCLUDE_CRYPTO := true
TARGET_KEYMASTER_WAIT_FOR_QSEE := true
TARGET_PROVIDES_KEYMASTER := false

### Partitions
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PERSISTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_BOOTIMAGE_PARTITION_SIZE     :=   0x2000000 # (32 MiB)
BOARD_RECOVERYIMAGE_PARTITION_SIZE :=   0x2000000 # (32 MiB)
BOARD_SYSTEMIMAGE_PARTITION_SIZE   :=  0x74CCD000 # (~1.8 GiB)
BOARD_CACHEIMAGE_PARTITION_SIZE    :=  0x10000000 # (256 MiB)
BOARD_PERSISTIMAGE_PARTITION_SIZE  :=   0x2000000 # (32 MiB)
BOARD_OEMIMAGE_PARTITION_SIZE      :=   0x4000000 # (64 MiB)
BOARD_USERDATAIMAGE_PARTITION_SIZE := 0x307CF7C00 # Enctypted footer included (-16384): 0x307CFBC00-0x4000
BOARD_FLASH_BLOCK_SIZE := 131072                  # (BOARD_KERNEL_PAGESIZE * 64)
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TW_INCLUDE_NTFS_3G := true
TW_NO_EXFAT := false
TW_NO_EXFAT_FUSE := false

### Logs
TARGET_USES_LOGD := true
TWRP_INCLUDE_LOGCAT := true

### SELinux
TWHAVE_SELINUX := true
include device/qcom/qcom-sepolicy/sepolicy.mk

BOARD_SEPOLICY_DIRS += \
	$(LOCAL_PATH)/sepolicy

#BOARD_SEPOLICY_UNION += \

### MISC
BOARD_USES_QC_TIME_SERVICES := true
BOARD_CHARGER_ENABLE_SUSPEND := true

# Init of the devices boots under 1s but just in case it is hot and charging...
TARGET_INCREASES_COLDBOOT_TIMEOUT := true

### Recovery
TARGET_RECOVERY_FSTAB := $(LOCAL_PATH)/recovery.fstab
#TARGET_RECOVERY_PIXEL_FORMAT := "RGB_565"
#TARGET_RECOVERY_PIXEL_FORMAT := "RGBA_8888"
BOARD_SUPPRESS_SECURE_ERASE := true
RECOVERY_VARIANT := twrp

### TWRP
RECOVERY_GRAPHICS_USE_LINELENGTH := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TARGET_USE_CUSTOM_LUN_FILE_PATH :=  /sys/devices/platform/msm_hsusb/gadget/lun1/file
TW_BRIGHTNESS_PATH := /sys/class/leds/lcd-backlight/brightness
TW_MAX_BRIGHTNESS := 255
TW_DEFAULT_BRIGHTNESS := 10
#TW_NO_SCREEN_TIMEOUT := false
#TW_NO_SCREEN_BLANK := false
TW_NEVER_UNMOUNT_SYSTEM := true

#TW_TARGET_USES_QCOM_BSP := true
#COMMON_GLOBAL_CFLAGS += -DQCOM_BSP

TW_EXTRA_LANGUAGES := true
TW_DEFAULT_LANGUAGE := en
#TW_EXCLUDE_SUPERSU := false
#TW_NO_REBOOT_BOOTLOADER := false
#TW_NO_REBOOT_RECOVERY := false
TW_HAS_DOWNLOAD_MODE := false
#TW_NO_BATT_PERCENT := false
#TW_NO_CPU_TEMP := false
TW_MTP_DEVICE := "/dev/mtp_usb"
TW_CUSTOM_CPU_TEMP_PATH := /sys/class/thermal/thermal_zone1/temp
TW_HAS_USB_STORAGE := true
# For people who would want to have ToyBox rather than Busybox
TW_USE_TOOLBOX := false
TW_USE_MODEL_HARDWARE_ID_FOR_DEVICE_ID := true
# An awesome way to take screenshots. Back-end improvement, no noticeable user side changes.
# Screenshots work without it too
TW_INCLUDE_FB2PNG := true

BOARD_HAS_NO_REAL_SDCARD := false
RECOVERY_SDCARD_ON_DATA := true

#TW_INTERNAL_STORAGE_PATH := "/data/media"
#TW_INTERNAL_STORAGE_MOUNT_POINT := "data"
#TW_EXTERNAL_STORAGE_PATH := "/sdcard1"
#TW_EXTERNAL_STORAGE_MOUNT_POINT := "sdcard1"

#
# portrait_mdpi  = 320x480 480x800 480x854 540x960
# portrait_hdpi  = 720x1280 800x1280 1080x1920 1200x1920 1440x2560 1600x2560
# watch_mdpi     = 240x240 280x280 320x320
# landscape_mdpi = 800x480 1024x600 1024x768
# landscape_hdpi = 1280x800 1920x1200 2560x1600
TW_THEME := portrait_hdpi
TWRP_NEW_THEME := true
