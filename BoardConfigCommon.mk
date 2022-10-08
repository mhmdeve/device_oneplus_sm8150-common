#
# Copyright (C) 2018-2019 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

BOARD_VENDOR := oneplus

VENDOR_PATH := device/oneplus/sm8150-common

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a-dotprod
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := cortex-a55

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a55

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := msmnile
TARGET_NO_BOOTLOADER := true

# Kernel
BOARD_BOOT_HEADER_VERSION := 2
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_CMDLINE := androidboot.hardware=qcom androidboot.console=ttyMSM0 androidboot.memcg=1 lpm_levels.sleep_disabled=1 msm_rtb.filter=0x237 service_locator.enable=1 swiotlb=2048 loop.max_part=7 androidboot.usbcontroller=a600000.dwc3  kpti=off
BOARD_KERNEL_CMDLINE += androidboot.vbmeta.avb_version=1.0
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_SEPARATED_DTBO := true
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_RAMDISK_USE_LZ4 := true
KERNEL_DEFCONFIG := vendor/sm8150-perf_defconfig
KERNEL_CUSTOM_LLVM := true

# A/B
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    odm \
    system \
    vendor \
    vbmeta

ifeq ($(PRODUCT_USE_DYNAMIC_PARTITIONS),true)
AB_OTA_PARTITIONS += \
    product \
    recovery \
    system_ext \
    vbmeta_system
endif

# FOD
TARGET_USES_FOD_ZPOS := true
TARGET_SURFACEFLINGER_UDFPS_LIB := //device/oneplus/common:libudfps_extension.oneplus

# HIDL
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += \
    $(VENDOR_PATH)/configs/vintf/oneplus_vendor_framework_compatibility_matrix.xml

DEVICE_MATRIX_FILE += device/qcom/common/compatibility_matrix.xml

DEVICE_MANIFEST_FILE += $(VENDOR_PATH)/configs/vintf/manifest.xml
ODM_MANIFEST_FILES += $(VENDOR_PATH)/configs/vintf/manifest-qva.xml

# Init
TARGET_INIT_VENDOR_LIB := //$(VENDOR_PATH):libinit_oneplus-sm8150
TARGET_RECOVERY_DEVICE_MODULES := libinit_oneplus-sm8150

# Metadata
BOARD_USES_METADATA_PARTITION := true

# Partitions
ifeq ($(PRODUCT_USE_DYNAMIC_PARTITIONS),true)
BOARD_SUPER_PARTITION_SIZE := 15032385536
BOARD_SUPER_PARTITION_GROUPS := oneplus_dynamic_partitions
BOARD_ONEPLUS_DYNAMIC_PARTITIONS_PARTITION_LIST := odm product system system_ext vendor
BOARD_ONEPLUS_DYNAMIC_PARTITIONS_SIZE := 7511998464
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := erofs
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
else
BOARD_ODMIMAGE_PARTITION_SIZE := 104857600
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3640655872
BOARD_USERDATAIMAGE_PARTITION_SIZE := 115601780736
BOARD_VENDORIMAGE_PARTITION_SIZE := 1073741824
endif
BOARD_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_DTBOIMG_PARTITION_SIZE := 25165824
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 100663296
BOARD_USERDATAIMAGE_PARTITION_SIZE := 115601780736
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := erofs
PRODUCT_FS_COMPRESSION := 1
BOARD_EROFS_COMPRESSOR := lz4
BOARD_EROFS_PCLUSTER_SIZE := 262144
TARGET_COPY_OUT_ODM := odm
TARGET_COPY_OUT_VENDOR := vendor

# Power
TARGET_TAP_TO_WAKE_NODE := "/proc/touchpanel/double_tap_enable"

# Recovery
ifeq ($(PRODUCT_USE_DYNAMIC_PARTITIONS),true)
TARGET_RECOVERY_FSTAB := $(VENDOR_PATH)/init/etc/fstab.qcom
else
BOARD_USES_RECOVERY_AS_BOOT := true
TARGET_NO_RECOVERY := true
TARGET_RECOVERY_FSTAB := $(VENDOR_PATH)/init/etc/fstab_non_dynamic.qcom
endif
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_INCLUDE_RECOVERY_DTBO := true
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_F2FS := true

# Init
SOONG_CONFIG_NAMESPACES += ONEPLUS_MSMNILE_INIT
SOONG_CONFIG_ONEPLUS_MSMNILE_INIT := PARTITION_SCHEME
ifeq ($(PRODUCT_USE_DYNAMIC_PARTITIONS),true)
SOONG_CONFIG_ONEPLUS_MSMNILE_INIT_PARTITION_SCHEME := dynamic
else
SOONG_CONFIG_ONEPLUS_MSMNILE_INIT_PARTITION_SCHEME := non_dynamic
endif

# Display
TARGET_RECOVERY_UI_MARGIN_HEIGHT := 80

# Sepolicy
BOARD_VENDOR_SEPOLICY_DIRS += $(VENDOR_PATH)/sepolicy/vendor
PRODUCT_PRIVATE_SEPOLICY_DIRS += $(VENDOR_PATH)/sepolicy/private
PRODUCT_PUBLIC_SEPOLICY_DIRS += $(VENDOR_PATH)/sepolicy/public

# Sensors
SOONG_CONFIG_NAMESPACES += ONEPLUS_MSMNILE_SENSORS
SOONG_CONFIG_ONEPLUS_MSMNILE_SENSORS := ALS_POS_X ALS_POS_Y

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

ifeq ($(PRODUCT_USE_DYNAMIC_PARTITIONS),true)
BOARD_AVB_VBMETA_SYSTEM := system product system_ext
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 1
endif

# WiFi
BOARD_WLAN_DEVICE := qcwcn
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
WIFI_DRIVER_DEFAULT := qca_cld3
WIFI_DRIVER_STATE_CTRL_PARAM := "/dev/wlan"
WIFI_DRIVER_STATE_OFF := "OFF"
WIFI_DRIVER_STATE_ON := "ON"
WIFI_HIDL_FEATURE_AWARE := true
WIFI_HIDL_FEATURE_DUAL_INTERFACE := true
WIFI_HIDL_UNIFIED_SUPPLICANT_SERVICE_RC_ENTRY := true
WPA_SUPPLICANT_VERSION := VER_0_8_X
