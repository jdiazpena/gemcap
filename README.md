# Gemini simulation configuration scripts

Gemini (and PyGemini and MatGemini) run on Windows, MacOS or Linux.
Mac and Linux users just work in your Terminal as usual.
Windows users can use MSYS2, WSL or Cygwin.

## 0. build Gemini and prereqs

1. install Python e.g. via [Miniconda](https://docs.conda.io/en/latest/miniconda.html) and close / reopen Terminal
2. `git clone https://github.com/gemini3d/gemini`
3. `ctest -S gemini/setup.cmake -VV`

Gemini simulation can be run from Python (PyGemini) or Matlab (MatGemini).
The command syntax is very similar.
PyGemini has more features, but MatGemini is also a well-tested package.
HDF5 files are recommended in general, and NetCDF4 is also available.

### Python

From Terminal, assuming PyGemini was previously installed:

```sh
gemini_run path/to/config.nml output_dir
```

### Matlab

From Matlab prompt, assuming setup.m was run since Matlab was started

```sh
gemini_run('path/to/config.nml', 'output_dir')
```

## 1. equilibrium simulation

It's necessary to have an equilibrium simulation to provide quiescent background conditions.
It runs for the 24 hour simulated time period just before the desired full simulation time start.
The equilibrium simulation can be run at a far lower resolution to make it run faster, perhaps 8 or 16 cells per axis is enough unless the simulation has geographically large extants &Gt; 1000 km.

### run equilibrium simulation

Create a config.nml for the equilibrium simulation.
It should start 24 hours before the actual desired simulation start time.
See a config.nml in this repo for an example.

The equilibrium simulation is run with a command as follows.

```sh
gemini_run risr3d_eq/ ~/simulations/risr3d_eq
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
&efield
dtE0 = 1.0
E0_dir = 'inputs/Efield/'
/
```

### run simulation

The simulation is run like:

```sh
gemini_run risr3d_fang/ ~/simulations/risr3d_fang
```
