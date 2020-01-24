% FIXME: for now, make a little smaller than equilibrium sim to avoid going
% outside its bounds with ghost cells
cwd = fileparts(mfilename('fullpath'));

p.simID = 'risr3d';
p.nml = [cwd,'/config.nml'];
p.xdist = 1200e3;    %eastward distance
p.ydist = 600e3;    %northward distance
p.lxp = 2;
p.lyp = 150;
p.glat = 74.73;
p.glon = 265.095; % 94.905 W
p.I = 90;

p.fracwidth = 1/7;

model_setup_interp(p, [cwd,'/../../gemini_sim'])
