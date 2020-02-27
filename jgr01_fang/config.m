function config()
%% 2D east-west EISCAT Svalbard
%

%% boilerplate for each config.m file
cwd = fileparts(mfilename('fullpath'));
gemroot = getenv('GEMINI_ROOT');
addpath([gemroot, '/script_utils'], [gemroot,'/setup'])

p = read_nml(cwd);
p.simdir = absolute_path(['../', fileparts(p.indat_size)]);

p.format = 'h5';
p.realbits = 64;

%% setup simulation
model_setup_interp(p)

end % function
