> [!todo] Finish writing proper README
# Installation
# Post Installation Steps
## WayDroid
>[!warning] 
> Installing WayDroid on your system before running nixos-generate-config will create unnecessary fstab entries that may interfere with system functionality
### Initialize WayDroid
 To fetch WayDroid images run the command below. To include Google Apps (GApps) support, add the parameters -s GAPPS -f:
```bash
sudo waydroid init
```
### GPU Adjustments
For NVIDIA GPU, Disable GBM and mesa-drivers by adding the text below to /var/lib/waydroid/waydroid_base.prop:
```text
ro.hardware.gralloc=default
ro.hardware.egl=swiftshader
```
