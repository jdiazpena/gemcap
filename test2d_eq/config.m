function config()
%% 2D east-west test equilibrium
% this is a special case where an altitude grid I don't know how to
% reproduce is reused.
%
cwd = fileparts(mfilename('fullpath'));

p.format = 'h5';
p.nml = [cwd,'/config.nml'];
p.simdir = [cwd, '/../../gemini_sim/test2d_eq'];
p.eqdir = [p.simdir,'/inputs'];  % to reuse Matt's grid from a long, long time ago
p.xdist = 1200e3;    %eastward distance
p.ydist = 600e3;    %northward distance
p.lxp = 15;
p.lyp = 1;
p.glat = 67.11;
p.glon = 212.95;
p.I = 90;
p.nmf = 5e11;
p.nme = 2e11;

p = merge_struct(p, read_config(p.nml));
% import geomagindices as gi
% gi.get_indices('2013-02-20T05', smoothdays=81)
p.activ = [108.9, 111.0, 5];

model_setup_equilibrium(p)
end % function
