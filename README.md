# Gemini simulation configuration scripts

Gemini (and PyGemini and MatGemini) run on Windows, MacOS or Linux.
Mac and Linux users just work in your Terminal as usual.
Windows users can use MSYS2, WSL or Cygwin.

## 0. build Gemini and prereqs

Install Gemini3D:

```sh
git clone https://github.com/gemini3d/gemini3d

ctest -S gemini3d/setup.cmake -VV
```

Gemini simulation can be run from Python (PyGemini) or Matlab (MatGemini).
Depending on the author, some features are developed first in MatGemini or PyGemini.
HDF5 is the default data file type.

### Python

From Terminal, assuming PyGemini was previously installed:

```sh
python -m gemini3d.gemini_run path/to/config.nml output_dir
```

### Matlab

From Matlab prompt:

```matlab
gemini3d.gemini_run('path/to/config.nml', 'output_dir')
```

If the function isn't found, in Matlab:

```matlab
run("gemini3d/setup.m")
```

## 1. equilibrium simulation

It's necessary to have an equilibrium simulation to provide quiescent background conditions.
It runs for the 24 hour simulated time period just before the desired full simulation time start.
The equilibrium simulation can be run at a far lower resolution to make it run faster, perhaps 4 or 8 cells per axis is enough unless the simulation has geographically large extants &Gt; 1000 km.

### run equilibrium simulation

Create a config.nml for the equilibrium simulation.
It should start 24 hours before the actual desired simulation start time.
See a config.nml in this repo for an example.

The equilibrium simulation is run with a command as follows.

```sh
python -m gemini3d.gemini_run risr3d_eq/ ~/sims/risr3d_eq
```

or

```matlab
gemini3d.gemini_run("risr3d_eq/", "~/sims/risr3d_eq")
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
python -m gemini3d.gemini_run risr3d_fang/ ~/sims/risr3d_fang
```

or

```matlab
gemini3d.gemini_run("risr3d_fang/", "~/sims/risr3d_eq")
```
