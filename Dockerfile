FROM golang:1.22 AS builder

LABEL maintainer="Magnus Gule <magnus.gule@piscada.com>" \
    description="MediaMTX with gst-launch and gst-rstp-server included"

WORKDIR /usr/src/app

COPY . .

RUN go generate ./...

# Build for linux/amd64
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build .

################################################################################

FROM debian:sid-slim AS pipebuilder

WORKDIR /pipefolder

# Copy source files for GstPipe project folder
COPY GstPipe/pipeme.c GstPipe/stats_post.c GstPipe/stats_post.h ./

# Install GStreamer pipeline dev-dependencies
RUN apt update && apt install -y --no-install-recommends \
    build-essential \
    libgstreamer1.0-0 \ 
libgstreamer1.0-dev \ 
gstreamer1.0-tools \
    gstreamer1.0-rtsp \
    libcurl4-openssl-dev \
    gcc \
    pkg-config

# Build gst-pipe
RUN gcc pipeme.c stats_post.c -o gst-pipe $(pkg-config --cflags --libs gstreamer-1.0) -lcurl

################################################################################

FROM debian:sid-slim AS production

WORKDIR /root

# Copy the built binary
COPY --from=builder /usr/src/app/mediamtx .
COPY --from=builder /usr/src/app/config/mediamtx.yml ./config/mediamtx.yml
# VOLUME [ "/config" ]

# Install GStreamer runtime dependencies
RUN apt update && apt install -y --no-install-recommends \
    gstreamer1.0-tools \
    gstreamer1.0-rtsp \
    libcurl4-openssl-dev \
    curl

# Copy the built gst-pipe binary
COPY --from=pipebuilder /pipefolder/gst-pipe .

# Set executable permissions
RUN chmod +x ./mediamtx
RUN chmod +x ./gst-pipe

# Set the entry point to the startup script
CMD ["./mediamtx", "./config/mediamtx.yml"]
