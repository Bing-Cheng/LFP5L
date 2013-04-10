function colorMap500S4(ratName, blockname, disFreq)
rat = [ratName(1) '5L'];
idir = ['G:\preparedDataLFP\' ratName '\'];
odir = ['G:\LFP5LOutput\' ratName '\colorMap\'];
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

for dateI = 1:dateN
    date1 = blockname{dateI}
    date= date1(5:12);
    fftR1 = zeros(fftLength/2,disTime);
    fftW1 = zeros(fftLength/2,disTime);
    fftR2 = zeros(fftLength/2,disTime);
    fftW2 = zeros(fftLength/2,disTime);
    k = 0;
    for chI = 1 : 16
        titleACNa = [idir 'fftMatrix' rat date '-ch' int2str(chI)];
        load(titleACNa); 
        rTrialN = size(fftMatrixSum,3);
        wTrialN = size(fftMatrixSumW,3);
        if (rTrialN>2 && wTrialN>2)
            k = k + 1;
            R1N = [1 : floor(rTrialN/2)];
            R2N = [floor(rTrialN/2)+1 : rTrialN];
            W1N = [1 : floor(wTrialN/2)];
            W2N = [floor(wTrialN/2)+1 : wTrialN];
            fftMatrixSumAvg = mean(fftMatrixSum(:,:,R1N),3);
            h = figure('position', [0   0   560   420]); 
            disMatrix([1:2:disFreq],:) = fftMatrixSumAvg(1:disFreq/2,:);
            disMatrix([2:2:disFreq],:) = fftMatrixSumAvg(1:disFreq/2,:);
            imagesc(disMatrix);
            colorbar;
            titleName = [rat '-' date '-ch' int2str(chI) '-R1-' int2str(length(R1N)) '-' int2str(disFreq)];
            title(titleName);
            saveas(h,[odir titleName],'jpg');

            fftMatrixSumAvgW = mean(fftMatrixSumW(:,:,W1N),3);
            h = figure('position', [700   0   560   420]); 
            disMatrix([1:2:disFreq],:) = fftMatrixSumAvgW(1:disFreq/2,:);
            disMatrix([2:2:disFreq],:) = fftMatrixSumAvgW(1:disFreq/2,:);
            imagesc(disMatrix);
            colorbar;
            wTrialN = size(fftMatrixSumW,3);
            titleName = [rat '-' date '-ch' int2str(chI) '-W1-' int2str(length(W1N))  '-' int2str(disFreq)];
            title(titleName);
            saveas(h,[odir titleName],'jpg');
            
            fftMatrixSumAvg2 = mean(fftMatrixSum(:,:,R2N),3);
            h = figure('position', [0   600   560   420]); 
            disMatrix([1:2:disFreq],:) = fftMatrixSumAvg2(1:disFreq/2,:);
            disMatrix([2:2:disFreq],:) = fftMatrixSumAvg2(1:disFreq/2,:);
            imagesc(disMatrix);
            colorbar;
            titleName = [rat '-' date '-ch' int2str(chI) '-R2-' int2str(length(R2N)) '-' int2str(disFreq)];
            title(titleName);
            saveas(h,[odir titleName],'jpg');

            fftMatrixSumAvgW2 = mean(fftMatrixSumW(:,:,W2N),3);
            h = figure('position', [700   600   560   420]); 
            disMatrix([1:2:disFreq],:) = fftMatrixSumAvgW2(1:disFreq/2,:);
            disMatrix([2:2:disFreq],:) = fftMatrixSumAvgW2(1:disFreq/2,:);
            imagesc(disMatrix);
            colorbar;
            wTrialN = size(fftMatrixSumW,3);
            titleName = [rat '-' date '-ch' int2str(chI) '-W2-' int2str(length(W2N)) '-' int2str(disFreq)];
            title(titleName);
            saveas(h,[odir titleName],'jpg');
            close all;
            fftR1 = fftR1+fftMatrixSumAvg;
            fftW1 = fftW1+fftMatrixSumAvgW;
            fftR2 = fftR2+fftMatrixSumAvg2;
            fftW2 = fftW2+fftMatrixSumAvgW2;
        else
            [chI rTrialN wTrialN]
        end%if
        
    end%ch
    fftR1m = fftR1/k;
    fftW1m = fftW1/k;
    fftR2m = fftR2/k;
    fftW2m = fftW2/k;
    save([odir rat date 'fft'], 'fftR1m', 'fftW1m', 'fftR2m', 'fftW2m');
end%date

  