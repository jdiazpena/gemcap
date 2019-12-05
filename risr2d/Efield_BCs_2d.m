function E = Efield_BCs_2d(dir_grid, dir_config)

narginchk(1, 2)
validateattributes(dir_grid, {'char'}, {'vector'})

cwd = fileparts(mfilename('fullpath'));
if nargin < 2, dir_config = cwd; end
validateattributes(dir_config, {'char'}, {'vector'})

dir_grid = absolute_path(dir_grid);
dir_out = [dir_grid, '/Efield_inputs'];

if ~isfolder(dir_out)
  mkdir(dir_out);
end


%% READ IN THE SIMULATION INFORMATION
[ymd0, UTsec0] = readconfig(dir_config);

xg = readgrid(dir_grid);
lx1 = xg.lx(1);
lx2 = xg.lx(2);
lx3 = xg.lx(3);


%CREATE A 'DATASET' OF ELECTRIC FIELD INFO
llon=100;
llat=100;
if xg.lx(2) == 1    %this is cartesian-specific code
  llon=1;
elseif xg.lx(3) == 1
  llat=1;
end
thetamin=min(xg.theta(:));
thetamax=max(xg.theta(:));
mlatmin=90-thetamax*180/pi;
mlatmax=90-thetamin*180/pi;
mlonmin=min(xg.phi(:))*180/pi;
mlonmax=max(xg.phi(:))*180/pi;
latbuf=1/100*(mlatmax-mlatmin);
lonbuf=1/100*(mlonmax-mlonmin);
E.mlat = linspace(mlatmin-latbuf,mlatmax+latbuf,llat);
E.mlon = linspace(mlonmin-lonbuf,mlonmax+lonbuf,llon);
[E.MLON, E.MLAT] = ndgrid(E.mlon, E.mlat);
mlonmean = mean(E.mlon);
% mlatmean=mean(E.mlat);

%% WIDTH OF THE DISTURBANCE
fracwidth = 1/7;
% mlatsig = fracwidth*(mlatmax-mlatmin);
mlonsig=fracwidth*(mlonmax-mlonmin);
sigx2=fracwidth*(max(xg.x2)-min(xg.x2));

%% TIME VARIABLE (SECONDS FROM SIMULATION BEGINNING)
tmin=0;
tmax=300;
dt = 1.;  % [seconds]  % FIXME: shouldn't this be from config.nml
time = tmin:dt:tmax;
lt = length(time);
%% SET UP TIME VARIABLES
ymd = ymd0;
UTsec = UTsec0+time;     %time given in file is the seconds from beginning of hour
UThrs = UTsec/3600;
E.expdate = cat(2, repmat(ymd(:)',[lt,1]), UThrs', zeros(lt,1), zeros(lt,1));
% t=datenum(E.expdate);

%% CREATE DATA FOR BACKGROUND ELECTRIC FIELDS
E.Exit=zeros(llon,llat,lt);
E.Eyit=zeros(llon,llat,lt);
for it=1:lt
  E.Exit(:,:,it)=zeros(llon,llat);   %V/m
  E.Eyit(:,:,it)=zeros(llon,llat);
end

%% CREATE DATA FOR BOUNDARY CONDITIONS FOR POTENTIAL SOLUTION
flagdirich=1;   %if 0 data is interpreted as FAC, else we interpret it as potential
E.Vminx1it=zeros(llon,llat,lt);
E.Vmaxx1it=zeros(llon,llat,lt);
E.Vminx2ist=zeros(llat,lt);
E.Vmaxx2ist=zeros(llat,lt);
E.Vminx3ist=zeros(llon,lt);
E.Vmaxx3ist=zeros(llon,lt);
Etarg=50e-3;            % target E value in V/m
if lx3 == 1
  pk = Etarg*sigx2 .* xg.h2(lx1, floor(lx2/2), 1).*sqrt(pi)./2;
elseif lx2 == 1
  pk = Etarg*sigx2 .* xg.h2(lx1, 1, floor(lx3/2)).*sqrt(pi)./2;
end
% x2ctr = 1/2*(xg.x2(lx2)+xg.x2(1));
for it=1:lt
    E.Vminx1it(:,:,it)=zeros(llon,llat);
    E.Vmaxx1it(:,:,it)=pk.*erf((E.MLON-mlonmean)/mlonsig);%.*erf((MLAT-mlatmean)/mlatsig);
     E.Vminx2ist(:,it)=zeros(llat,1);     %these are just slices
     E.Vmaxx2ist(:,it)=zeros(llat,1);
     E.Vminx3ist(:,it)=zeros(llon,1);
     E.Vmaxx3ist(:,it)=zeros(llon,1);
end

%% SAVE THESE DATA TO APPROPRIATE FILES
% LEAVE THE SPATIAL AND TEMPORAL INTERPOLATION TO THE
% FORTRAN CODE IN CASE DIFFERENT GRIDS NEED TO BE TRIED.
% THE EFIELD DATA DO NOT TYPICALLY NEED TO BE SMOOTHED.
filename = [dir_out,'/simsize.dat'];
fid=fopen(filename,'w');
fwrite(fid,llon,'integer*4');
fwrite(fid,llat,'integer*4');
fclose(fid);
filename=[dir_out, '/simgrid.dat'];
fid=fopen(filename,'w');
fwrite(fid, E.mlon, 'real*8');
fwrite(fid, E.mlat, 'real*8');
fclose(fid);

for it=1:lt
    UTsec = E.expdate(it,4)*3600 + E.expdate(it,5)*60 + E.expdate(it,6);
    ymd = E.expdate(it,1:3);
    filename = [dir_out, filesep, datelab(ymd,UTsec), '.dat'];
    disp(['write: ',filename])
    fid = fopen(filename, 'w');

    %FOR EACH FRAME WRITE A BC TYPE AND THEN OUTPUT BACKGROUND AND BCs
    fwrite(fid, flagdirich,'real*8');
    fwrite(fid, E.Exit(:,:,it),'real*8');
    fwrite(fid, E.Eyit(:,:,it),'real*8');
    fwrite(fid, E.Vminx1it(:,:,it),'real*8');
    fwrite(fid, E.Vmaxx1it(:,:,it),'real*8');
    fwrite(fid, E.Vminx2ist(:,it),'real*8');
    fwrite(fid, E.Vmaxx2ist(:,it),'real*8');
    fwrite(fid, E.Vminx3ist(:,it),'real*8');
    fwrite(fid, E.Vmaxx3ist(:,it),'real*8');

    fclose(fid);
end

if ~nargout, clear('E'), end
end % function