# Install cgroup-tools v2

sudo chmod o+w /etc/apt/sources.list
echo "deb http://cz.archive.ubuntu.com/ubuntu jammy main universe" >>/etc/apt/sources.list
sudo add-apt-repository universe
sudo apt update
sudo apt install cgroup-tools stress

# Create a unified/demo cgroup

sudo mkdir /sys/fs/cgroup/unified
sudo mount -t cgroup2 none /sys/fs/cgroup/unified
sudo cgcreate -g cpuset, memory:unified/demo 
# WORKS --> sudo mkdir /sys/fs/cgroup/demo

# Check the cgroup
sudo cgget -g cpuset unified/demo
sudo cgget -g memory unified/demo

# Set the CPU and memory limits
sudo cgset -r memory.max=100M unified/demo
sudo cgexec -g cpu:unified/demo htop
sudo cgset -r memory.max=100K unified/demo

# Run the stress tool
htop
sudo cgexec -g cpu:unified/demo stress --cpu 2 &
sudo cgset -r cpuset.cpus=0 unified/demo

# Freeze the cgroup
echo 1 | sudo tee /sys/fs/cgroup/unified/demo/cgroup.freeze

# Unfreeze the cgroup
echo 0 | sudo tee /sys/fs/cgroup/unified/demo/cgroup.freeze