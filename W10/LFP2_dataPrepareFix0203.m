close all;
clear;




datatype = 'Wave';
rat = 'W5L';

odir =  'H:\preparedDataLFP\W10\';
    date= '02-03-11';
  for chI = 1:16  

titleNa = [odir 'fftMatrix' rat date '-ch' int2str(chI)]
load(titleNa);
dRWAvg = sum(fftMatrixSum,2);
dAvg = sum(dRWAvg,1);
dAvg1 = squeeze(dAvg)';
rL = [5:11];%find(dAvg1==0);
dRWAvg = sum(fftMatrixSumW,2);
dAvg = sum(dRWAvg,1);
dAvg2 = squeeze(dAvg)';
wL = [10:23];%find(dAvg2==0);
%fftMatrixSum(:,:,rL)=[];
fftMatrixSumW(:,:,wL)=[];
save(titleNa, 'fftMatrixSum', 'fftMatrixSumW'); 
end%ch

    