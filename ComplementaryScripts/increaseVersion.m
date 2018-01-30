%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% increaseVersion(version)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function increaseVersion(version)

%Check if history has been updated:
fid = fopen('../history.md','r');
history = fscanf(fid,'%s');
fclose(fid);
if isempty(strfind(history,['yeast' version ':']))
    error('ERROR: update history.md first')
end

%Load model:
initCobraToolbox
model = readCbModel('../ModelFiles/xml/yeastGEM.xml');

%Include tag in model:
model.description = ['yeastGEM_v' version];
saveYeastModel(model)

%Store model as .mat (only for releases):
mkdir('../ModelFiles/mat');
save('../ModelFiles/mat/yeastGEM.mat','model');

%Update version file:
fid = fopen('../version.txt','wt');
fprintf(fid,version);
fclose(fid);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%