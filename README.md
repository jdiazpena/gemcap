# Gemini simulation configuration scripts


## Quick start (from scratch)

windows users: it is assumed you're using WSL (Windows Subsystem for Linux) throughout.
Mac and Linux users just work in your Terminal as usual.

### build Gemini


1. install python3 (e.g. via miniconda)
2. `git clone https://github.com/gemini3d/gemini`
3. `python gemini/install_prereqs.py`
5. `cd gemini`
6. `python setup.py develop`

The "build" specified below is the directory gemini/build/ on the computer.

1. `meson setup build`
2. `meson test -C build`

The "meson test" command compiles the programs and runs self-tests that will take
about 5-10 minutes on a laptop or about half and hour on a Raspberry Pi 4.

### setup grid

Setup the simulation grid by running the `model_setup_*.m` script (from WSL if using Windows)
This creates files under inputs/:

* ?D_eq_ICs.dat
* simgrid.dat
* simsize.dat

### run equilibrium simulation

Create/copy/edit a config.nml for the equilibrium simulation.
It should start 24 hours before the actual desired simulation start time.
See a config.nml in this repo for an example.

The equilibrium simulation is run with a command as follows.
The `-np 4` parameter corresponds to the number of *physical* cores in the computer.

```sh
mpiexec -np 2 ../gemini/build/gemini_fang.bin risr2d/config.nml ../gemini_sim/2deq
```

