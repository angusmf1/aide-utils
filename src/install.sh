#!/bin/bash
#
# install.sh

# Download and install the mkcert binary
wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.4/mkcert-v1.4.4-linux-amd64 && \
    chmod +x mkcert-v1.4.4-linux-amd64 && \
    sudo mv mkcert-v1.4.4-linux-amd64 /usr/local/bin/mkcert

