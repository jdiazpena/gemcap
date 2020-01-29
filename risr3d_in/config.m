% FIXME: for now, make a little smaller than equilibrium sim to avoid going
% outside its bounds with ghost cells
cwd = fileparts(mfilename('fullpath'));
simroot = [cwd,'/../../gemini_sim'];

p.format = 'raw';
p.simID = 'risr3d';
p.nml = [cwd,'/config.nml'];
p.xdist = 100e3;    %eastward distance
p.ydist = 600e3;    %northward distance
p.lxp = 10;
p.lyp = 100;
p.glat = 74.73;
p.glon = 265.095; % 94.905 W
p.I = 90;

p.fracwidth = 1/7;

[state,E] = model_setup(p, simroot);
