% FIXME: for now, make a little smaller than equilibrium sim to avoid going
% outside its bounds with ghost cells
p.xdist = 1200e3;    %eastward distance
p.ydist = 600e3;    %northward distance
p.lxp = 1;
p.lyp = 150;
p.glat = 74.73;
p.glon = 265.095; % 94.905 W
p.I = 90;

p.fracwidth = 1/7;

cwd = fileparts(mfilename('fullpath'));

model_setup_interp('risr2d', [cwd,'../../gemini_sim'], p)