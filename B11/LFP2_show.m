close all;

block_date = {'04-29-11','05-05-11','05-10-11','05-16-11','05-20-11','05-26-11','05-31-11','06-01-11',...
    '06-02-11','06-03-11','06-06-11','06-07-11','06-10-11',};
block_ch = {'5','7','11','16'};

chN = length(block_ch);
dateN = length(block_date);
for chI = 1:chN
    fftMatrixSumAC = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1);  
    fftMatrixSumBT = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1); 
    for dateI = 1:dateN
        ch = block_ch{chI};
        date = block_date{dateI};
        titleACNa = ['AC' date  '---'  ch]
        load(titleACNa); 
        fftMatrixSumAC = fftMatrixSum + fftMatrixSumAC; 
        titleBTNa = ['BT' date  '---'  ch]
        load(titleBTNa); 
        fftMatrixSumBT = fftMatrixSum + fftMatrixSumBT; 
    end%date
    figure
    imagesc(fftMatrixSumAC(1:50,:));
    colorbar;
    titleAvgACNa = ['AC---'  ch]
    title(titleAvgACNa); 
    figure
    imagesc(fftMatrixSumBT(1:50,:));
    colorbar;
    titleAvgBTNa = ['BT---'  ch]
    title(titleAvgBTNa); 
end%ch
    