function config()
%% 2D east-west EISCAT Svalbard
%

%% boilerplate for each config.m file
cwd = fileparts(mfilename('fullpath'));
gemroot = getenv('GEMINI_ROOT');
addpath([gemroot,'/setup'])

p = read_nml(cwd);
p.simdir = fileparts(p.indat_size);

%% setup simulation
model_setup_interp(p)

end % function
