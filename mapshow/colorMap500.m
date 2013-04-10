function colorMap500(ratName, blockname, disFreq)
rat = [ratName(1) '5L'];
idir = ['H:\preparedDataLFP\' ratName '\'];
odir = ['H:\LFP5LOutput\' ratName '\'];
block_ch = [1:16];
windowLength = 6000;
fftLength = 500;
fs= 24414;
rfs = 1000;
slidingStep = 10;
b1 = fir1(30,1000/24414);
chN = length(block_ch);
dateN = length(blockname);
%disFreq = 500;
disTime = 551;
disMatrix = zeros(disFreq,disTime);

    fftMatrixSumAC = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1);  
    fftMatrixSumBT = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1); 
    for dateI = 1:dateN
    date1 = blockname{dateI}
    date= date1(5:12);
        for chI = 1 : 16
        titleACNa = [idir 'fftMatrix' rat date '-ch' int2str(chI)]
        load(titleACNa); 
        fftMatrixSumAvg = mean(fftMatrixSum,3);
        h = figure('position', [0   246   560   420]) 
        disMatrix([1:2:disFreq],:) = fftMatrixSumAvg(1:disFreq/2,:);
        disMatrix([2:2:disFreq],:) = fftMatrixSumAvg(1:disFreq/2,:);
        imagesc(disMatrix);
        colorbar;
        rTrialN = size(fftMatrixSum,3);
        titleName = ['Correct trials-' int2str(rTrialN) rat '-' date '-ch' int2str(chI)];
        title(titleName);
         saveas(h,titleName,'jpg');
        fftMatrixSumAvgW = mean(fftMatrixSumW,3);
        h = figure('position', [700   246   560   420]) 
        disMatrix([1:2:disFreq],:) = fftMatrixSumAvgW(1:disFreq/2,:);
        disMatrix([2:2:disFreq],:) = fftMatrixSumAvgW(1:disFreq/2,:);
        imagesc(disMatrix);
        colorbar;
        wTrialN = size(fftMatrixSumW,3);
        titleName = ['Incorrect trials-' int2str(wTrialN) rat '-' date '-ch' int2str(chI)];
        title(titleName);
         saveas(h,[odir titleName],'jpg');
        end%ch
        close all;
    end%date

  