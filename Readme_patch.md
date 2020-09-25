# Patch simulation

The initial approach is a stationary patch with soft precipitation.
The first step of any Gemini simulation is to create an equilibrium simulation that runs for 24 hours simulated time.
The equilibrium simulation can have larger geographic extent and a much coarser grid than the simulations based on it.
This way, a single equilibrium simulation can be reused for many simulations.

Unless otherwise noted, these commands are all:

* issued from Matlab
* run from the "gemcap/" directory
* run after once running in Matlab `setup`

For convenience we'll put all simulation data under directory "~/sims/" but that's arbitrary.

## one-time Gemini build

If the commands below complain about Gemini.bin not being found, you may need to build Gemini3D executable from Terminal:

```sh
cd ..

git clone https://github.com/gemini3d/gemini3d.git

ctest -S gemini3d/setup.cmake -VV
```

Assuming you have a Fortran compiler, that usually "just works".
If you don't have a "ctest" command, you will need to
[install CMake](https://cmake.org/download/)
which can be done from Terminal like:

```sh
python -m pip install cmake
```

### Prerequisites

If you are missing something, here's a quick start (all these commands from Terminal):

* Linux / Windows Subsystem for Linux: `apt install gfortran libhdf5-dev liblapack-dev libopenmpi-dev
* MacOS Homebrew: `brew install cmake gcc hdf5 openmpi lapack scalapack`

Windows can use
[Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/install-win10)
or MSYS2.

#### Windows MSYS2

[MSYS2 is setup as here](https://www.scivision.dev/install-msys2-windows/)

```sh
pacman -S mingw-w64-x86_64-gcc-fortran
pacman -S mingw-w64-x86_64-hdf5
pacman -S mingw-w64-x86_64-lapack
pacman -S mingw-w64-x86_64-scalapack
```

Windows MS-MPI is [setup as here](https://www.scivision.dev/windows-mpi-msys2/).
MPI is not required by Gemini, but simulations will run slower without MPI since only one CPU core is used.

#### Intel oneAPI

Alternatively to the above,
[Intel oneAPI compiler](https://www.scivision.dev/intel-oneapi-fortran-install/)
can be used which has Lapack, MPI, Scalapack built in on Windows, Mac or Linux.

## equilibrium

This will take about 5-10 minutes on a typical quad-core laptop, and only has to be done once unless you:

* go outside the geographic area of the equilibrium simulation
* change the date
* significantly change the starting time (noon instead of dawn, etc.)

```matlab
gemini3d.gemini_run("risr2d_eq/", "~/sims/risr2d_eq")
```

Although several of the plots will be blank due to quasi static ionosphere, the data can be plotted by:

```matlab
gemini3d.gemini_plot("~/sims/risr2d_eq", "png")
```

that creates plots in the "~/sims/risr2d_eq/plots" directory.

## Fang 2008

For reference and because it's fast to run ~ 1 minute computer time, let's do Fang ionization.
This will help us see if anything is unexpected (non-physical) with our simulation setup.
The Gemini developers try to trap common mistakes, but we can't catch everything.

```matlab
gemini3d.gemini_run("risr2d_fang/", "~/sims/risr2d_eq")
```
