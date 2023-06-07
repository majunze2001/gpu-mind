## GPU-MIND

1. Nvidia GPU driver 
`sudo virsh net-dumpxml default | grep jeff`

```bash
wget https:////us.download.nvidia.com/XFree86/Linux-x86_64/535.43.02/NVIDIA-Linux-x86_64-535.43.02.run
sh ./NVIDIA-Linux-x86_64-535.43.02.run --no-kernel-modules
```

#### Inspect GPU
```bash
sudo lshw -C display  
lspci | grep VGA
```

```
sudo virsh shutdown Ubuntu-gpu1_jeff
sudo virsh start Ubuntu-gpu1_jeff

sudo apt install libx11-dev

sudo apt-get install xorg
```
