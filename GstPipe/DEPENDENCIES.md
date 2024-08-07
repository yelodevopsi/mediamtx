# Setup Guide Gstreamer + libcurl dependencies (Visual Studio)

This document provides a step-by-step guide to setting up the environment using Chocolatey, GStreamer, and vcpkg.

## Steps

### 1. Install Chocolatey

Run the following command to install Chocolatey:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

### 2. Install GStreamer

#### Install GStreamer runtime + development package

#### Install GStreamer development

Run the following command to install the GStreamer development and runtime MSI:

```powershell
choco install gstreamer -y

# To bind the needed env to the msvc folder: (e.g C:\gstreamer\1.0\msvc_x86_64)
# Look at the output from the choco install for the correct folder

echo "GSTREAMER_1_0_ROOT_MSVC_X86_64=C:\gstreamer\1.0\msvc_x86_64" >> $env:GITHUB_ENV

choco install gstreamer-devel -y
```

### 3. Bootstrap vcpkg

Bootstrap vcpkg from an existing directory:

```powershell
cd C:\vcpkg
.\bootstrap-vcpkg.bat
```

### 4. Integrate vcpkg

Integrate vcpkg with the following command:

```powershell
.\vcpkg.exe integrate install
```

### 5. Install curl with vcpkg

Install curl using vcpkg:

```powershell
.\vcpkg.exe install curl
```

## Summary

By following these steps, you will set up Chocolatey, GStreamer, and vcpkg, and ensure that the necessary packages are installed and cached for efficient use.
