## GPU-MIND

1. Nvidia GPU driver 
`sudo virsh net-dumpxml default | grep jeff`

```bash
wget https:////us.download.nvidia.com/XFree86/Linux-x86_64/535.43.02/NVIDIA-Linux-x86_64-535.43.02.run
```

#### Inspect GPU
```bash
sudo lshw -C display  
lspci | grep VGA
```

```bash
sudo virsh list
sudo virsh shutdown Ubuntu-gpu1_jeff
sudo virsh start Ubuntu-gpu1_jeff

sudo apt install libx11-dev

sudo apt-get install xorg
```


##### Uninstall previous GPU driver
```bash
# list nvidia related drivers
dpkg -l | grep -i nvidia 
sudo apt-get purge "nvidia*"
```


#### Install Custom Driver
```bash 
cd open-gpu-kernel-modules-mind
sudo sh ./NVIDIA-Linux-x86_64-535.43.02.run --no-kernel-modules
sudo make modules -j$(nproc)
sudo make modules_install -j$(nproc)
modprobe nvidia NVreg_OpenRmEnableUnsupportedGpus=1
echo options nvidia NVreg_OpenRmEnableUnsupportedGpus=1  | sudo tee -a /etc/modprobe.d/nvidia-open.conf


sudo apt-get install xorg-dev
sudo apt-get install xserver-xorg


lsmod | head -n 1; lsmod | grep nvidia

ps aux | grep nvidia


sudo modprobe nvidia-drm
sudo modprobe nvidia-uvm
sudo modprobe nvidia-modeset
sudo modprobe nvidia
sudo modprobe nvidia-peermem

sudo rmmod nvidia_drm
sudo rmmod nvidia_modeset
sudo rmmod nvidia

sudo apt-get install nvidia-cuda-toolkit
sudo apt-get autoremove

sudo nvidia-xconfig 
sudo dmesg -c


sed -n '137832,394220p' tracing > uvm_tracing

awk '/uvm/{flag=1} flag; /uvm/{mark=1} END{if(mark) print}' tracing > uvm_tracing2

```



on Ubuntu 18.04.4 LTS through cli

```bash
mount | grep tracefs
cd /sys/kernel/debug/tracing
echo 23107 > set_ftrace_pid

# add a filtered function to be skipped
# pci_get_dev_by_id
echo 'pci_get_dev_by_id' | sudo tee -a set_ftrace_notrace
echo 'kmem_cache_free' | sudo tee -a set_ftrace_notrace

```