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

i=0; 
    fftMatrixSumAC = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1);  
    fftMatrixSumBT = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1); 
    for dateI = 1:dateN
        i = i+1;
        date = block_date{dateI};
        titleACNa = ['fftMatrix' rat date]
        load(titleACNa); 
        fftMatrixSumAvg = sum(fftMatrixSum3,3);
        pAC0_10= mean(fftMatrixSumAvg(1:5,:)); 
        pAC20_40 = mean(fftMatrixSumAvg(10:20,:)); 

        fftMatrixSumAvgW = sum(fftMatrixSum3W,3);
        pAC0_10W= mean(fftMatrixSumAvgW(1:5,:)); 
        pAC20_40W = mean(fftMatrixSumAvgW(10:20,:)); 
        figure; hold on;
        plot(pAC0_10,'r');
        plot(pAC0_10W,'b');
        plot(pAC20_40,'g');
        plot(pAC20_40W,'m');
        legend('correct, 0-10','incorrect, 0-10','correct, 20-40','incorrect, 20-40');
        titleN = ['Power in band   ' rat date];
        title(titleN);
        

    end%date

  