function config()
%% 2D east-west test
cwd = fileparts(mfilename('fullpath'));
gemroot = [cwd, '/../../gemini'];
addpath([gemroot,'/script_utils'], [gemroot,'/setup'])

p.format = 'h5';
p.nml = [cwd,'/config.nml'];
p.eqdir = [cwd, '/../../gemini_sim/test2d_eq'];
p.eqnml = [p.eqdir, '/inputs/config.nml'];
p.simdir = [pwd, '/../../gemini_sim/test2d_fang'];
p.xdist = 200e3;    %eastward distance
p.ydist = 600e3;    %northward distance
p.lxp = 40;
p.lyp = 1;
p.glat = 67.11;
p.glon = 212.95;
p.I = 90;
p.Efield_fracwidth = 1/7;
p.Etarg = 50e-3;  % [V/m]
p.precip_latwidth = 1/4;
p.precip_lonwidth = 1/4;

p = merge_struct(p, read_config(p.nml));

model_setup_interp(p)
end % function
