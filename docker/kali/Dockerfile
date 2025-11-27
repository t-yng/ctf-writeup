FROM kalilinux/kali-rolling

# Install packages
RUN apt update && apt install -y \
    kali-linux-default \  # Basic tool set
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
