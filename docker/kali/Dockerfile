FROM kalilinux/kali-rolling

# Install Basic tool set
RUN apt update && apt install -y kali-linux-default

# Install packages
# RUN another command to cache kali-linux-default
# This can cause refer outdated packages because the list is cached above.
RUN apt install -y \
    iputils-ping

# Create kali user
RUN useradd -m -s /bin/bash kali && \
    echo "kali:kali" | chpasswd

# Add kali user to sudo group
RUN usermod -aG sudo kali

# Set default user to kali
USER kali
WORKDIR /home/kali

# Add aliases
# nmap uses eth1 as default and fails to icmp, so specify the network interface for nmap to use eth0
RUN echo "alias nmap='nmap -e eth0'" >> ~/.bashrc
RUN echo "" >> ~/.bashrc
