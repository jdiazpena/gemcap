% FIXME: for now, make a little smaller than equilibrium sim to avoid going
% outside its bounds with ghost cells
cwd = fileparts(mfilename('fullpath'));
simroot = [cwd,'/../../gemini_sim'];

p.format = 'hdf5';
p.eqdir = [simroot, '/risr3d_eq'];
p.simdir = [simroot, '/risr3d_in'];
p.nml = [cwd, '/config_hdf5.nml'];
p.eqnml = [p.eqdir, '/inputs/config_hdf5.nml'];
p.xdist = 100e3;    %eastward distance
p.ydist = 600e3;    %northward distance
p.lxp = 10;
p.lyp = 120;
p.glat = 74.73;
p.glon = 265.095; % 94.905 W
p.I = 90;
p.Etarg = 25; % [mV / m]

p.fracwidth = 1/7;

model_setup(p)
