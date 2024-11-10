### SDL3 Build Process for all Platforms: Dependencies and Setup

To build SDL3 artifacts, you need to install specific dependencies depending on your platform. Below are the step-by-step instructions for **Ubuntu**, **Windows**, and **macOS**.

---

## Ubuntu Setup (bash)

1. **Update and Install Dependencies**:
   Run the following commands to update your system and install necessary packages:

   ```bash
   sudo apt-get update
   ```

2. **Download and Extract the Android NDK**:
   Download the Android NDK and extract it to the current working directory:

   ```bash
   wget https://dl.google.com/android/repository/android-ndk-r25b-linux.zip
   unzip android-ndk-r25b-linux.zip
   ```

3. **Set the NDK Environment Variable**:
   Set the `ANDROID_NDK_HOME` environment variable to point to the extracted NDK:

   ```bash
   export ANDROID_NDK_HOME=$PWD/android-ndk-r25b
   ```

4. **Install Required Packages**:
   Install the necessary tools and libraries for building SDL3:

   ```bash
   sudo apt-get install build-essential git make \
             pkg-config cmake ninja-build \
             libasound2-dev libpulse-dev libjack-dev \
             libx11-dev libxext-dev libxrandr-dev libxcursor-dev \
             libxfixes-dev libxi-dev libxss-dev libxkbcommon-dev \
             libdrm-dev libgbm-dev libgl1-mesa-dev libgles2-mesa-dev \
             libegl1-mesa-dev libdbus-1-dev libibus-1.0-dev libudev-dev \
             libwayland-dev libpipewire-0.3-dev \
             vulkan-utils libvulkan-dev
   ```

---

## Windows Setup (Powershell)

1. **Download and Extract the Android NDK**:
   Download the Android NDK for Windows and extract it:

   ```powershell
   Invoke-WebRequest -Uri "https://dl.google.com/android/repository/android-ndk-r25b-windows-x86_64.zip" -OutFile "android-ndk.zip"
   Expand-Archive -Path android-ndk.zip -DestinationPath android-ndk
   $ndkPath = "LETTER:\path\to\android-ndk"
   $env:PATH += ";$ndkPath"
   ```

2. **Install Dependencies**:
   Use **Chocolatey** to install the necessary dependencies, including `CMake`, `Visual Studio Build Tools`, `Git`, Vulkan SDK, and DirectX SDK:

   ```powershell
   choco install cmake --install-arguments 'ADD_CMAKE_TO_PATH=Always'
   choco install visualstudio2019buildtools --package-parameters "--includeRecommended --includeOptional"
   choco install git
   choco install vulkan-sdk
   choco install directx-sdk
   ```

---

## macOS Setup (bash)

### 1. **Download and Extract the Android NDK**
Download and unzip the Android NDK for macOS:

   ```bash
   curl -O https://dl.google.com/android/repository/android-ndk-r25b-darwin.zip
   unzip android-ndk-r25b-darwin.zip
   ```

### 2. **Set the NDK Environment Variable**
Set the `ANDROID_NDK_HOME` environment variable to the extracted NDK directory:

   ```bash
   export ANDROID_NDK_HOME=$(pwd)/android-ndk-r25b
   ```

### 3. **Install Dependencies**
Use **Homebrew** to install the required tools and libraries:

   ```bash
   brew install cmake
   brew install git
   brew install vulkan-sdk
   brew install molten-vk
   brew install --cask xquartz
   ```

---

### 4. **Install Xcode and iOS Development Tools**
Make sure Xcode and iOS development tools are installed:

   ```bash
   xcode-select --install
   ```

If Xcode is not installed, download and install it from the Mac App Store.

### 5. **Install iOS-Specific Dependencies**
SDL3 for iOS requires some iOS-specific tools and libraries. Install them with Homebrew:

   ```bash
   brew install ios-deploy
   ```
---

### Additional Notes:

- **Vulkan SDK**: You will need the Vulkan SDK for your platform (installed through `vulkan-sdk` on all platforms) for Vulkan support in SDL3.
- **MoltenVK**: On macOS, **MoltenVK** is required to run Vulkan on macOS, as it acts as a translation layer for Vulkan to Metal.

Once the dependencies are installed, you can proceed with building SDL3 using CMake and the Android NDK.