# Docker image for building AIC22 Python client
# source code should be mounted to /src

FROM ubuntu:22.04

SHELL ["/bin/bash", "-c"]

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    vim

# Install dependencies
COPY AIC22-Client-Python/requirements.txt /requirements.txt
RUN pip3 install -r /requirements.txt

# Clean up
RUN rm /requirements.txt \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

CMD cd /src && rm -rf build dist client.spec && pyinstaller --onefile src/client.py
