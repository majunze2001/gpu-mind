
# gtc
# sudo dmesg -c
# echo "" > trace
# echo 1 > tracing_on
# /home/sslee/gpu-mind/gtc.o > /home/sslee/gpu-mind/gtc.out
# echo 0 > tracing_on
# sudo dmesg > /home/sslee/gpu-mind/gtc.printk
# cp /sys/kernel/debug/tracing/trace /home/sslee/gpu-mind/gtc.tracing
# start=$(grep -n 'uvm' /home/sslee/gpu-mind/gtc.tracing | head -n 1 | cut -d: -f1)
# end=$(grep -n 'uvm' /home/sslee/gpu-mind/gtc.tracing | tail -n 1 | cut -d: -f1)
# sed -n "${start},${end}p" /home/sslee/gpu-mind/gtc.tracing > /home/sslee/gpu-mind/uvm_gtc_tracing

# ctg
sudo dmesg -c
echo "" > trace
echo 1 > tracing_on
/home/sslee/gpu-mind/ctg.o > /home/sslee/gpu-mind/ctg.out
echo 0 > tracing_on
sudo rm /home/sslee/gpu-mind/ctg.printk
sudo dmesg > /home/sslee/gpu-mind/ctg.printk
sudo rm /home/sslee/gpu-mind/ctg.tracing
cp /sys/kernel/debug/tracing/trace /home/sslee/gpu-mind/ctg.tracing
sudo rm /home/sslee/gpu-mind/uvm_ctg_tracing
start=$(grep -n 'uvm' /home/sslee/gpu-mind/ctg.tracing | head -n 1 | cut -d: -f1)
end=$(grep -n 'uvm' /home/sslee/gpu-mind/ctg.tracing | tail -n 1 | cut -d: -f1)
sed -n "${start},${end}p" /home/sslee/gpu-mind/ctg.tracing > /home/sslee/gpu-mind/uvm_ctg_tracing
