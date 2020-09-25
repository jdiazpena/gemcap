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
