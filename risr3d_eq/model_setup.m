function model_setup(p, simroot)
narginchk(2,2)
validateattributes(p, {'struct'}, {'scalar'}, mfilename, 'parameters', 1)
validateattributes(simroot, {'char'}, {'vector'}, mfilename, 'output directory top',2)
eqID = [p.simID, '_eq'];

%% check directories
eq_dir = [simroot, filesep, eqID];
eqin_dir = [eq_dir,'/inputs'];
outdir = eq_dir;

%ADD PATHS FOR FUNCTIONS
cwd = fileparts(mfilename('fullpath'));
gemdir = [cwd, '/../../gemini'];
assert(isfolder(gemdir), [gemdir, ' not found'])
for d = {'script_utils', 'setup', 'setup/gridgen', 'vis'}
  addpath([gemdir, filesep, d{:}])
end

%% GRID GENERATION
xg = makegrid_cart_3D(p.xdist, p.lxp, p.ydist, p.lyp, p.I, p.glat, p.glon);
writegrid(xg, outdir, p.format);

%% Equilibrium input generation
varnames = fieldnames(p);
if any(strcmp('activ', varnames))
  cfg = read_config(p.nml);
  UThour = cfg.UTsec0 / 3600;
  dmy = flip(cfg.ymd(:).');
  [ns,Ts,vsx1] = eqICs3D(xg, UThour, dmy, p.activ, p.nmf, p.nme);
  % Note: should be rewritten to include the neutral module form the fortran code
  writedata(dmy, cfg.UTsec0,ns,vsx1,Ts,outdir,simlabel,format);
end

end % function
