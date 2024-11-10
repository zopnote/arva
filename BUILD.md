# Build instructions
**Instructions to build the Arva SDK for the development platforms.**
The Arva SDK can be build for Windows, MacOS and Linux. 
The resulting SDK is capable of cross compiling the supported configurations (e.g. Windows -> Windows, Web & Android).



## Content
- [Recommend: Building a portable SDK](#building-portable-sdk)
- [Building a standalone SDK](#building-portable-sdk)
- [Building artifacts bundle](#building-artifacts-bundle)
    - [Ubuntu 22.04 or later](#ubuntu-2204-or-later)
    - [Windows](#windows)
    - [MacOS](#macos)



## Building portable SDK
The portable SDK is the regular kit. It comes with the tool and the engine, but an internet connection is required to cache necessary artifacts and binaries at first launch.

Make sure these dependencies are in your path:
- Python 3.1+
- Dart 3.0+

Building the SDK is simple. Head over to the ``build/scripts/`` folder and run the ``build.py`` script:
````bash
py build.py --config=release --portable
````
Anyway, a ``--help`` argument is available.

## Building standalone SDK
The standalone SDK comes with all necessary parts and doesn't need to cache anything at launch. Intended for an independent environment instead of using the Arva services.

At first, you should have built an [artifacts bundle](#building-artifacts-bundle) for your desired platform. Keep it ready for later.

## Building artifacts bundle
### Ubuntu 22.04 or later
Install all dependencies:
````bash
sudo apt-get install libasound2-dev libpulse-dev libaudio-dev \
  libjack-dev libsndio-dev libx11-dev libxext-dev libdecor-0-dev \
  libxrandr-dev libxcursor-dev libxfixes-dev libxi-dev libxss-dev \
  libxkbcommon-dev libdrm-dev libgbm-dev libgl1-mesa-dev libgles2-mesa-dev \
  libegl1-mesa-dev libdbus-1-dev libibus-1.0-dev libudev-dev fcitx-libs-dev \
  libwayland-dev libpipewire-0.3-dev git python3 curl xz-utils
````
Clone Chromium's depot tools and make sure they are in the path for Dart:
````bash
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
export PATH="$PATH:$PWD/depot_tools"
````
Now run the build script at ``build/scripts/``:
````bash
py build.py --config=release --artifacts_bundle
````
### Windows
Install Visual Studio
### MacOS