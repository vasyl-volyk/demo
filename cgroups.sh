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

# Check the cgroup
sudo cgget -g cpuset unified/demo
sudo cgget -g memory unified/demo

# Set the CPU and memory limits
sudo cgset -r memory.max=100M unified/demo
sudo cgexec -g cpu:unified/demo htop
sudo cgset -r memory.max=100K unified/demo