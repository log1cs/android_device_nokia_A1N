#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

function blob_fixup() {
    case "${1}" in
	# Load audiosphere from the new path
    	system_ext/etc/permissions/audiosphere.xml)
            sed -i 's|/system/framework/audiosphere.jar|/system_ext/framework/audiosphere.jar|g' "${2}"
            ;;
	# Remove all unused dependencies from FP blobs
	vendor/lib64/libgoodixhwfingerprint.so)
            "${PATCHELF}" --remove-needed "libsoftkeymasterdevice.so" "${2}"
	    "${PATCHELF}" --remove-needed "libkeymaster_messages.so" "${2}"
    esac
}

# If we're being sourced by the common script that we called,
# stop right here. No need to go down the rabbit hole.
if [ "${BASH_SOURCE[0]}" != "${0}" ]; then
    return
fi

set -e

export DEVICE=A1N
export DEVICE_COMMON=msm8998-common
export VENDOR=nokia
export VENDOR_COMMON=${VENDOR}

"./../../${VENDOR_COMMON}/${DEVICE_COMMON}/extract-files.sh" "$@"
