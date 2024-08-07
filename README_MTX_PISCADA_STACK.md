# Piscada MTX Stack

- PiscadaMTX : .NET/C# for Windows NT Service handling, log dumping.
- GstPipe : Custom gstreamer pipeline gcc/msvc compiled binary used in MediaMTX
- MediaMTX : Modified bluenviron/mediamtx with addition features like:
  - REST endpoints for mediamtx.yml (config)
  - GstPipe Server:
    - Direct REST endpoint for reading GstPipe metrics
    - Integrates with Prometheus Metrics server (:9998)

## Build docker

    docker build -t piscada/mtx:alpha .
    docker push piscada/mtx:alpha
    docker compose up


## Runtime
### Windows

1. Install gstreamer from binaries on internet (.msi installer)
2. Use the production artifacts from the Github Actions

## Debian


sudo apt install -y gstreamer1.0-tools gstreamer1.0-rtsp
./mediamtx /path/to/mediamtx.yml

## How to build with in Powershell (Windows)

```powershell
    # Clone and cd
    git clone https://github.com/bluenviron/mediamtx
    cd mediamtx
    go generate ./...

    # Produce Windowsy binary: mediamtx.exe file
    $env:CGO_ENABLED = "0"; go build .


    # Run build:
    .\mediamtx .\config\mediamtx.yml
```

## How to build Linux amd64 binary: (in powershell and bash)

```powershell
$env:CGO_ENABLED="0"; $env:GOOS="linux"; $env:GOARCH="amd64"; go build .
```

```bash
CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build .

```

## SETUP VC++

1. ENVS
   GSTREAMER_1_0_ROOT_MSVC_X86_64
   C:\gstreamer\1.0\msvc_x86_64


2. .\vcpkg.exe install curl
