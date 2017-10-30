%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% saveYeastModel(model)
% Saves model as an .sbml and .txt file.
%
% Benjam�n J. S�nchez. Last edited: 2017-10-29
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function saveYeastModel(model)

model.id='ymn';

%Remove any space in rxnECNumbers:
model.rxnECNumbers = strrep(model.rxnECNumbers,' ','');

%Save changes to current model:
cd ../ModelFiles/mat
save('yeast_7.6_cobra.mat','model');
cd ../xml
writeCbModel(model,'sbml','yeast_7.6_cobra.xml');
cd ../txt
writeCbModel(model,'text','yeast_7.6_cobra.txt');

%Detect boundary metabolites and save them in a .txt file:
cd ../../ComplementaryScripts
fid = fopen('boundaryMets.txt','wt');
for i = 1:length(model.rxns)
    pos = find(model.S(:,i) ~= 0);
    if length(pos) == 1 %Exchange rxn
        fprintf(fid,[model.mets{pos} '\t' model.metNames{pos} '\n']);
    end
end
fclose(fid);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%