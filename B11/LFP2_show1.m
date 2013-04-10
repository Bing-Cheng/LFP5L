close all;
clear;
rat = 'B5L';
block_date = {'04-29-11','05-05-11','05-10-11','05-16-11','05-20-11','05-26-11','05-31-11','06-01-11',...
    '06-02-11','06-03-11','06-06-11','06-07-11','06-10-11',};
block_ch = [1:16];
windowLength = 6000;
fftLength = 500;
fs= 24414;
rfs = 1000;
slidingStep = 10;
b1 = fir1(30,1000/24414);
chN = length(block_ch);
dateN = length(block_date);
disFreq = 50;
disTime = 551;
disMatrix = zeros(disFreq,disTime);
i=0;
    fftMatrixSumAC = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1);  
    fftMatrixSumBT = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1); 
    for dateI = 1:dateN
        i = i+1;
        date = block_date{dateI};
        titleACNa = ['fftMatrix' rat date]
        load(titleACNa); 
        fftMatrixSumAvg = mean(fftMatrixSum3,3);
        h = figure
        disMatrix([1:2:disFreq],:) = fftMatrixSumAvg(1:25,:);
        disMatrix([2:2:disFreq],:) = fftMatrixSumAvg(1:25,:);
        imagesc(disMatrix);
        colorbar;
        titleName = ['Correct trials-' rat '-' date];
        title(titleName);
         saveas(h,titleName,'jpg');
        fftMatrixSumAvgW = mean(fftMatrixSum3W,3);
        h = figure
        disMatrix([1:2:disFreq],:) = fftMatrixSumAvgW(1:25,:);
        disMatrix([2:2:disFreq],:) = fftMatrixSumAvgW(1:25,:);
        imagesc(disMatrix);
        colorbar;
        titleName = ['Incorrect trials-' rat '-' date];
        title(titleName);
         saveas(h,titleName,'jpg');
    end%date

  