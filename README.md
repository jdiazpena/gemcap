# Gemini simulation configuration scripts

windows uses WSL (Windows Subsystem for Linux).
Mac and Linux users just work in your Terminal as usual.

## build Gemini

1. install python3 (e.g. via miniconda).  Python &ge; 3.6 is fine.
2. `git clone https://github.com/gemini3d/gemini`
3. `python gemini/install_prereqs.py`
4. `cd gemini`
5. `python setup.py develop --user`

The "build" specified below is the directory gemini/build/ on the computer.

1. `meson build`
2. `meson test -C build`

The "meson test" command compiles the programs and runs self-tests that will take
about 5-10 minutes on a laptop or about half and hour on a Raspberry Pi 4.

## create equilibrium simulation

It's necessary to have an equilibrium simulation to provide quiescent background conditions.

### setup grid

Setup the simulation grid by running the `model_setup_eq?d.m` script, which creates files under `inputs/`:

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
mpiexec -np 4 ../gemini/build/gemini_fang.bin risr2d_eq/config.nml ../gemini_sim/risr2d_eq
```

## create simulation

A simulation grid within the equilibrium simulation grid is necessary.
Typically, boundary condtions are also used.

Copy the config.nml used for the equilibrium simulation to the simulation directory,
and increase the resolution as desired in the model_setup_interp?d.m file vs. the
model_setup_eq?d.m file.

Run the model_setup_interp?d.m to create the new grid.

### setup boundary conditions

In a 2-D Gemini simulation, boundary conditions may optionally be specified for:

* electric potential: {top, bottom, side}
* precipitation

The boundary conditions are enabled in the simulation config.nml file.
For electric potential, in the config.nml, include:

```ini
flagE0file = 1

&efield
dtE0 = 1.0
E0_dir = '../my_sim_dir/inputs/Efield_inputs/'
/
```

### run simulation

The simulation is run with a command as follows.
The `-np 4` parameter corresponds to the number of *physical* cores in the computer.

```sh
mpiexec -np 4 ../gemini/build/gemini_fang.bin risr2d/config.nml ../gemini_sim/risr2d
```
