# syntax=docker/dockerfile:1

# Use Ubuntu as the default base; override with --build-arg DISTRO=debian:latest if desired.
ARG DISTRO=ubuntu:latest
FROM ${DISTRO}

# Set APT to noninteractive mode.
ENV DEBIAN_FRONTEND=noninteractive

# Install prerequisites including sudo, curl, and git.
RUN apt-get update && apt-get install -y \
    sudo \
    git \
    && rm -rf /var/lib/apt/lists/*

# Create two fake users: fakeuser1 and fakeuser2.
RUN useradd -m fakeuser1 && \
    useradd -m fakeuser2 && \
    echo "fakeuser1 ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Copy your dotfiles repo into the container.
COPY . /home/fakeuser1/.dotfiles
WORKDIR /home/fakeuser1/.dotfiles

# Ensure the files are accessible to fakeuser1.
RUN chown -R fakeuser1:fakeuser1 /home/fakeuser1/.dotfiles

# Make your install script executable.
RUN chmod +x install.sh

# Switch to fakeuser1. This simulates "logging in" as that user.
USER fakeuser1

# Start an interactive shell as fakeuser1 when the container runs.
# CMD ["/bin/bash"]
