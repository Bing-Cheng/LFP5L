close all;
clear;




datatype = 'Wave';
rat = 'G5L';

odir =  'H:\preparedDataLFP\G11\';
    date= '09-20-11';
  for chI = 1:16  

titleNa = [odir 'fftMatrix' rat date '-ch' int2str(chI)]
load(titleNa);
dRWAvg = sum(fftMatrixSum,2);
dAvg = sum(dRWAvg,1);
dAvg1 = squeeze(dAvg)';
rL = [13: 101];%find(dAvg1==0);
dRWAvg = sum(fftMatrixSumW,2);
dAvg = sum(dRWAvg,1);
dAvg2 = squeeze(dAvg)';
wL = [6:38];%find(dAvg2==0);
fftMatrixSum(:,:,rL)=[];
fftMatrixSumW(:,:,wL)=[];
save(titleNa, 'fftMatrixSum', 'fftMatrixSumW'); 
end%ch

    