# ------------------------------------------------------------------------------
# Pull base image
FROM ubuntu:20.04

# ------------------------------------------------------------------------------
# Arguments
ARG WORKDIR=/root

# ------------------------------------------------------------------------------
# Install tools via apt-get
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update && \
    apt-get -y install git \
    wget \
    python3 \
    python3-dev \
    python3-setuptools \
    python3-usb \
    python3-pip \
    software-properties-common \
    build-essential \
    astyle \
    mercurial \
    ninja-build \
    libssl-dev && \
    wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | sudo tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null && \
    add-apt-repository 'deb https://apt.kitware.com/ubuntu/ focal main' && \
    apt-get -y update && \
    apt-get -y install cmake && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists

# Set up mbed environment
WORKDIR /root/
RUN wget https://github.com/ARMmbed/mbed-os/raw/latest/requirements.txt && \
    pip3 install -r requirements.txt

# ------------------------------------------------------------------------------
# Install Python modules (which are not included in requirements.txt)
RUN pip3 install \
    'pyyaml>=5.1,<6.0' \
    mbed-tools \
    pyocd

# ------------------------------------------------------------------------------
# Install arm-none-eabi-gcc
WORKDIR /root/
RUN wget -q https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/RC2.1/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2 && \
    tar -xjf gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2 && \
    rm gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2
ENV PATH="/root/gcc-arm-none-eabi-9-2019-q4-major/bin:${PATH}"


# ------------------------------------------------------------------------------
# Display and save environment settings
RUN python3 --version | tee env_settings && \
    arm-none-eabi-gcc --version | tee -a env_settings && \
    (echo -n 'mbed-tools ' && mbed-tools --version) | tee -a env_settings && \
    (echo -n 'mbed-greentea ' && mbedgt --version) | tee -a env_settings && \
    (echo -n 'mbed-host-tests ' && mbedhtrun --version) | tee -a env_settings && \
    (echo -n 'pyocd ' && pyocd --version) | tee -a env_settings


WORKDIR /root
