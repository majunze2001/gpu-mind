sudo dmesg -c
echo 1 > tracing_on
/home/sslee/gpu-mind/ctg.o > /home/sslee/gpu-mind/out
echo 0 > tracing_on
sudo dmesg > /home/sslee/gpu-mind/printk
cp /sys/kernel/debug/tracing/trace /home/sslee/gpu-mind/tracing
