function colorMap500S4(ratName, blockname, disFreq)
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


for dateI = 1:dateN
    date1 = blockname{dateI}
    date= date1(5:12);
   disR1 = zeros(disFreq,disTime);
disR2 = zeros(disFreq,disTime);
disW1 = zeros(disFreq,disTime);
disW2 = zeros(disFreq,disTime);
for chI = 1 : 16
        titleACNa = [idir 'fftMatrix' rat date '-ch' int2str(chI)];
        load(titleACNa); 
        rTrialN = size(fftMatrixSum,3);
        wTrialN = size(fftMatrixSumW,3);
        if (rTrialN>2 && wTrialN>2)
            R1N = [1 : floor(rTrialN/2)];
            R2N = [floor(rTrialN/2)+1 : rTrialN];
            W1N = [1 : floor(wTrialN/2)];
            W2N = [floor(wTrialN/2)+1 : wTrialN];
            fftMatrixSumAvg = mean(fftMatrixSum(:,:,R1N),3);
             
            disMatrix([1:2:disFreq],:) = fftMatrixSumAvg(1:disFreq/2,:);
            disMatrix([2:2:disFreq],:) = fftMatrixSumAvg(1:disFreq/2,:);
            disR1 = disR1 + disMatrix;
%             h = figure('position', [0   0   560   420])
%             imagesc(disMatrix);
%             colorbar;
%             titleName = [rat '-' date '-ch' int2str(chI) '-R1-' int2str(length(R1N)) '-' int2str(disFreq)];
%             title(titleName);
%             saveas(h,titleName,'jpg');

            fftMatrixSumAvgW = mean(fftMatrixSumW(:,:,W1N),3);
             
            disMatrix([1:2:disFreq],:) = fftMatrixSumAvgW(1:disFreq/2,:);
            disMatrix([2:2:disFreq],:) = fftMatrixSumAvgW(1:disFreq/2,:);
            disW1 = disW1 + disMatrix;
%             h = figure('position', [700   0   560   420])
%             imagesc(disMatrix);
%             colorbar;
%             wTrialN = size(fftMatrixSumW,3);
%             titleName = [rat '-' date '-ch' int2str(chI) '-W1-' int2str(length(W1N))  '-' int2str(disFreq)];
%             title(titleName);
%             saveas(h,[odir titleName],'jpg');
            
            fftMatrixSumAvg = mean(fftMatrixSum(:,:,R2N),3);
             
            disMatrix([1:2:disFreq],:) = fftMatrixSumAvg(1:disFreq/2,:);
            disMatrix([2:2:disFreq],:) = fftMatrixSumAvg(1:disFreq/2,:);
            disR2 = disR2 + disMatrix;
%             h = figure('position', [0   600   560   420])
%             imagesc(disMatrix);
%             colorbar;
%             titleName = [rat '-' date '-ch' int2str(chI) '-R2-' int2str(length(R2N)) '-' int2str(disFreq)];
%             title(titleName);
%             saveas(h,titleName,'jpg');

            fftMatrixSumAvgW = mean(fftMatrixSumW(:,:,W2N),3);
            
            disMatrix([1:2:disFreq],:) = fftMatrixSumAvgW(1:disFreq/2,:);
            disMatrix([2:2:disFreq],:) = fftMatrixSumAvgW(1:disFreq/2,:);
            disW2 = disW2 + disMatrix;
%             h = figure('position', [700   600   560   420]) 
%             imagesc(disMatrix);
%             colorbar;
%             wTrialN = size(fftMatrixSumW,3);
%             titleName = [rat '-' date '-ch' int2str(chI) '-W2-' int2str(length(W2N)) '-' int2str(disFreq)];
%             title(titleName);
%             saveas(h,[odir titleName],'jpg');
%             close all;
        else
            rTrialN
            wTrialN
        end%if
    end%ch
                h = figure('position', [700   600   560   420]) 
            imagesc(disR1);
            colorbar;
            titleName = [rat '-' date '-R1-' int2str(length(W2N)) '-' int2str(disFreq)];
            title(titleName);
            saveas(h,[odir titleName],'jpg');                
            h = figure('position', [700   600   560   420]) 
            imagesc(disR2);
            colorbar;
            titleName = [rat '-' date '-R2-' int2str(length(W2N)) '-' int2str(disFreq)];
            title(titleName);
            saveas(h,[odir titleName],'jpg');
                            h = figure('position', [700   600   560   420]) 
            imagesc(disW1);
            colorbar;
            titleName = [rat '-' date '-W1-' int2str(length(W2N)) '-' int2str(disFreq)];
            title(titleName);
            saveas(h,[odir titleName],'jpg');
                            h = figure('position', [700   600   560   420]) 
            imagesc(disW2);
            colorbar;
            titleName = [rat '-' date '-W2-' int2str(length(W2N)) '-' int2str(disFreq)];
            title(titleName);
            saveas(h,[odir titleName],'jpg');
            close all;
end%date

  