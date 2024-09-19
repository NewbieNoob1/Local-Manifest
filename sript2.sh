rm -rf device/xiaomi/munch
rm -rf device/xiaomi/sm8250-common
rm -rf vendor/xiaomi/munch
rm -rf vendor/xiaomi/sm8250-common
rm -rf kernel/xiaomi/sm8250

# Initiating the Rising OS
repo init -u https://github.com/RisingTechOSS/android -b fourteen --git-lfs
/opt/crave/resync.sh

# Trees
git clone https://github.com/NewbieNoob1/device_xiaomi_munch.git --depth=1 -b 14-rising device/xiaomi/munch 
git clone https://github.com/NewbieNoob1/device_xiaomi_sm8250-common.git --depth=1 -b 14-rising device/xiaomi/sm8250-common
cd frameworks/native
git fetch https://github.com/Project-PixelStar/frameworks_native
git cherry-pick 21bd93f82538a10df34e0747e6326a74a3b1336b
cd ../../
# Clone common repositories
rm -rf hardware/xiaomi
git clone https://github.com/Mudit200408/hardware_xiaomi --depth=1 hardware/xiaomi
git clone https://gitea.com/hdzungx/android_vendor_xiaomi_miuicamera --depth=1 vendor/xiaomi/miuicamera
git clone https://github.com/TheParasiteProject/packages_apps_KProfiles --depth=1 packages/apps/KProfiles 
git clone https://gitlab.com/Mudit200408/vendor_xiaomi_munch --depth=1 vendor/xiaomi/munch
git clone https://gitlab.com/Mudit200408/vendor_xiaomi_sm8250-common --depth=1 vendor/xiaomi/sm8250-common
git clone https://github.com/Mudit200408/android_hardware_dolby --depth=1 hardware/dolby

# Remove and replace directory
rm -rf hardware/qcom-caf/sm8250/display
git clone https://github.com/Project-PixelStar/hardware_qcom-caf_sm8250_display --depth=1 hardware/qcom-caf/sm8250/display

# Clone and setup kernel
git clone https://github.com/kvsnr113/xiaomi_sm8250_kernel --depth=1 kernel/xiaomi/sm8250
cd kernel/xiaomi/sm8250
git submodule init && git submodule update 
rm -rf KernelSU/userspace/su

# Go back to the original directory
cd ../../..

# Setup Clang toolchain
cd prebuilts/clang/host/linux-x86
mkdir clang-neutron
cd clang-neutron
curl -LO "https://raw.githubusercontent.com/Neutron-Toolchains/antman/main/antman"
chmod +x antman
./antman -S=05012024
./antman --patch=glibc

# Go back to the original directory again
cd ../../../../..

# Modify the AndroidManifest.xml
sed -i 's/android:minSdkVersion="19"/android:minSdkVersion="21"/' prebuilts/sdk/current/androidx/m2repository/androidx/preference/preference/1.3.0-alpha01/manifest/AndroidManifest.xml

#Start Building
. build/envsetup.sh
riseup munch userdebug
rise b
