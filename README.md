# Guix Installer

This repository is meant to be used to create an installer image based on the **full Linux kernel**
from the [Nonguix channel](https://gitlab.com/nonguix/nonguix).  This allows for the use of non-libre
drivers to support available hardware that uses inexpensive, proprietary components with non-open-source
drivers.

Please check out the [image configuration files](./guix-config/) and the [ISO creation script](./build-iso.sh)
to understand what is included and how the image is build.

Although I'm starting from scratch, I followed the trail blazed in the [SystemsCrafters/guix-installer](https://github.com/SystemCrafters/guix-installer) repo.  Much appreciation to [David Wilson](https://github.com/daviwil) and the rest of the [System Crafters team](https://github.com/SystemCrafters).

## Table of Contents
- [Guix Installer](#guix-installer)
  - [Build Instructions](#build-instructions)
  - [Attributions](#attributions)
  - [License](#license)

## Build Instructions

1. Start with a Linux system that already has [Gnu Guix](https://guix.gnu.org) installed.
2. Clone [this repo](https://github.com/jonBoone/guix-installer) from GitHub.
3. Change your working directory to the target directory from step 2 above.
4. Kick off the build process: `sh build-iso.sh`
5. Once the ISO is successfully built, you will need to flash it to a USB drive.

### Flashing the ISO

As stated in _step #5_ of [Build Instructions](#build-instructions), you will need to flash
the `.iso` file into a USB stick.

**[*]nix**:

You should only need the `dd` utility (_coreutils_):

- `dd status=progress if=guix-installerYYYYMMDDHHMM.iso of=/dev/foo`
  - where `guix-installerYYYYMMDDHHMM.iso` is the name of the downloaded `.iso`
    image and `foo` the name of the targeted device to flash the image.

For the sake of providing an example, here's the full command:

```sh
dd status=progress if=guix-installer-202106150234.iso of=/dev/sdb
```

> NOTE #1: You can list your devices with `lsblk`.

> NOTE #2: If `dd` won't work, refer to the **Windows** section.

**Windows**:

- [balenaEtcher](https://www.balena.io/etcher) is a great **cross-platform**
  _FOSS_ utility for flashing _GNU/Linux_ images.
- If the above doesn't work, you might give [Rufus](https://rufus.ie/en_US/) a
  look.

## Attributions

- The [System Crafters](https://systemcrafters.cc)' community for providing [the starting point](https://github.com/SystemCrafters/guix-installer) for this effort.

## License

The code in this repository is licensed under the
[GNU General Public License v3](./LICENSE.txt).
