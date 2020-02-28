# Gemini simulation configuration scripts

Windows uses WSL (Windows Subsystem for Linux).
Mac and Linux users just work in your Terminal as usual.

## 0. build Gemini and prereqs

1. install python3 (e.g. via miniconda).
2. `git clone https://github.com/gemini3d/gemini`
3. `python gemini/script_utils/install_prereqs.py`
4. `cd gemini`
5. `python3 setup.py develop --user`

The "build" specified below is the directory gemini/build/ on the computer.
If any user-compiled libraries are used, as will be particularly likely on HPC, before this step set environment variables
pointing to the location of each library like:

```sh
export LAPACK_ROOT=$HOME/projs/lib_budge/lapack
export SCALAPACK_ROOT=$HOME/projs/lib_budge/scalapack
export MUMPS_ROOT=$HOME/projs/lib_budge/mumps
```

1. `cmake -B build`
2. `cmake --build build -j`

The "meson test" command compiles the programs and runs self-tests that will take about 10 minutes on a laptop.

## 1. equilibrium simulation

It's necessary to have an equilibrium simulation to provide quiescent background conditions.
It runs for the 24 hour simulated time period just before the desired full simulation time start.

### run equilibrium simulation

Create a config.nml for the equilibrium simulation.
It should start 24 hours before the actual desired simulation start time.
See a config.nml in this repo for an example.

The equilibrium simulation is run with a command as follows.
The `-np 4` parameter corresponds to the number of *physical* cores in the computer.

```sh
python3 ../gemini/job.py risr3d_eq/config.nml ../gemini_sim/risr3d_eq
```

## 2. full simulation

A full simulation grid within the equilibrium simulation grid is necessary.
Typically, boundary condtions are also used.

Copy the config.nml used for the equilibrium simulation to the simulation directory,
and increase the resolution as desired in config.nml to create the new grid.

### setup boundary conditions

Gemini boundary conditions may optionally be specified for:

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
python3 ../gemini/job.py risr3d_in/config.nml ../gemini_sim/risr3d_out
```
