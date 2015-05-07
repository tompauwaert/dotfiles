
# $1 should be the name of the AVD configuration name

emulator -avd ${1} -qemu -m 512 -enable-kvm
