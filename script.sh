rm -rf device/xiaomi/munch
rm -rf device/xiaomi/sm8250-common
rm -rf vendor/xiaomi/munch
rm -rf vendor/xiaomi/sm8250-common
rm -rf kernel/xiaomi/sm8250

# Initiating the Rising OS
repo init -u https://github.com/RisingTechOSS/android -b fourteen --git-lfs --depth=1
/opt/crave/resync.sh


# DT & VT & KT
git clone -b main https://github.com/DeadlyShroud/dt.git --depth 1 device/xiaomi/munch
git clone -b main https://github.com/DeadlyShroud/cvt.git --depth 1 device/xiaomi/sm8250-common
git clone -b main https://gitea.com/deadlyshroud/vt.git --depth 1 vendor/xiaomi/munch
git clone -b main https://gitea.com/deadlyshroud/cvt.git --depth 1 vendor/xiaomi/sm8250-common
#git clone https://github.com/EmanuelCN/kernel_xiaomi_sm8250.git -b munch kernel/xiaomi/sm8250
git clone -b lineage-21 https://github.com/LineageOS/android_kernel_xiaomi_sm8250.git --depth 1 kernel/xiaomi/sm8250
#cd kernel/xiaomi/sm8250
#git submodule init && git submodule update 
#rm -rf KernelSU/userspace/su
# Go back to the original directory
#cd ../../..

# Meme Cam & ViperFX & KProfiles
git clone https://gitea.com/hdzungx/android_vendor_xiaomi_miuicamera.git -b uqpr3 vendor/xiaomi/miuicamera
git clone https://github.com/TogoFire/packages_apps_ViPER4AndroidFX.git -b v4a packages/apps/ViPER4AndroidFX
rm -rf packages/apps/KProfiles
git clone https://github.com/yaap/packages_apps_KProfiles.git -b fourteen packages/apps/KProfiles

# I don't know what is this 
rm -rf hardware/qcom-caf/sm8250/display
git clone https://github.com/hdzungx/android_hardware_qcom-caf_sm8250_display hardware/qcom-caf/sm8250/display
rm -rf hardware/xiaomi
git clone -b 14.0 https://github.com/crdroidandroid/android_hardware_xiaomi.git hardware/xiaomi

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
