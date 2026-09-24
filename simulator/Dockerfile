FROM rust:1.90-trixie AS builder

# TODO: follow up on pinning simulator
ARG SIMULATOR_COMMIT=7ba870e1206530d1b23e8be58d3e1dbd4365d908

RUN apt-get update && apt-get install -y --no-install-recommends \
    git ca-certificates pkg-config libx11-dev libxkbcommon-dev \
    libxrandr-dev libxi-dev libxcursor-dev libxinerama-dev libxfixes-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /build

# TODO: implement our sponsor's cache system instead of bullying the hub
RUN git clone https://github.com/vexide/vex-v5-qemu.git simulator \
    && cd simulator \
    && git checkout "$SIMULATOR_COMMIT" \
    && cargo build --release --manifest-path packages/kernel/Cargo.toml \
    && cargo build --release --package client-cli

FROM debian:trixie-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates make gcc-arm-none-eabi libstdc++-arm-none-eabi-newlib \
    qemu-system-arm xvfb x11vnc novnc websockify openbox \
    libxkbcommon0 libxkbcommon-x11-0 libx11-6 libxcb1 libxrandr2 libxi6 libxcursor1 \
    libxinerama1 libxfixes3 libxrender1 libxext6 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /build/simulator/packages/kernel/target/armv7a-none-eabi/release/kernel /opt/simulator/kernel
COPY --from=builder /build/simulator/target/release/client-cli /opt/simulator/client-cli
COPY entrypoint.sh /opt/simulator/entrypoint.sh

ENV DISPLAY=:99
EXPOSE 6080
ENTRYPOINT ["/bin/sh", "/opt/simulator/entrypoint.sh"]
