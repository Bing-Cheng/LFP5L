close all;
clear;
rat = 'O5L';
blockname =  {'O5L-10-04-10-A','O5L-10-05-10-A','O5L-10-06-10-B','O5L-10-07-10-A','O5L-10-08-10-B','O5L-10-11-10-A'};
idir = 'H:\preparedDataLFP\O10\';
odir =  'H:\LFP5LOutput\O10\fft\';
windowLength = 6000;
fftLength = 500;
fs= 24414;
rfs = 1000;
slidingStep = 10;
dateN = length(blockname);
gGroup4Date = zeros(2,2,dateN);
thetaBand = [2:4]; %4~8Hz
for dateI = 1:dateN
    date1 = blockname{dateI}
    date= date1(5:12);
    thetaR1Ch = [];
    thetaR2Ch = [];
    thetaW1Ch = [];
    thetaW2Ch = [];
    for chI = [2 : 8]
        titleNa = [idir 'fftMatrix' rat date '-ch' int2str(chI)];
        load(titleNa); 
        rTrialN = size(fftMatrixSum,3);
        wTrialN = size(fftMatrixSumW,3);
        if (rTrialN>2 && wTrialN>2)
            R1N = [1 : floor(rTrialN/2)];
            R2N = [floor(rTrialN/2)+1 : rTrialN];
            fftR1 = mean(fftMatrixSum(:,:,R1N),3);
            fftR2 = mean(fftMatrixSum(:,:,R2N),3);
            W1N = [1 : floor(wTrialN/2)];
            W2N = [floor(wTrialN/2)+1 : wTrialN];
            fftW1 = mean(fftMatrixSumW(:,:,W1N),3);
            fftW2 = mean(fftMatrixSumW(:,:,W2N),3);
            
            thetaR1 = mean(fftR1(thetaBand,:)); 
            thetaR1Ch = [thetaR1Ch; thetaR1];
            thetaR2 = mean(fftR2(thetaBand,:)); 
            thetaR2Ch = [thetaR2Ch; thetaR2];
            thetaW1 = mean(fftW1(thetaBand,:)); 
            thetaW1Ch = [thetaW1Ch; thetaW1];
            thetaW2 = mean(fftW2(thetaBand,:)); 
            thetaW2Ch = [thetaW2Ch; thetaW2];
        else
            rTrialN
            wTrialN
        end
    end%ch
    
    thetaR1ChM2 = [];
    thetaR2ChM2 = [];
    thetaW1ChM2 = [];
    thetaW2ChM2 = [];
    for chI = [1 9 : 16]
        titleNa = [idir 'fftMatrix' rat date '-ch' int2str(chI)];
        load(titleNa); 
        rTrialN = size(fftMatrixSum,3);
        wTrialN = size(fftMatrixSumW,3);
        if (rTrialN>2 && wTrialN>2)
            R1N = [1 : floor(rTrialN/2)];
            R2N = [floor(rTrialN/2)+1 : rTrialN];
            fftR1 = mean(fftMatrixSum(:,:,R1N),3);
            fftR2 = mean(fftMatrixSum(:,:,R2N),3);
            W1N = [1 : floor(wTrialN/2)];
            W2N = [floor(wTrialN/2)+1 : wTrialN];
            fftW1 = mean(fftMatrixSumW(:,:,W1N),3);
            fftW2 = mean(fftMatrixSumW(:,:,W2N),3);
            
            thetaR1 = mean(fftR1(thetaBand,:)); 
            thetaR1ChM2 = [thetaR1ChM2; thetaR1];
            thetaR2 = mean(fftR2(thetaBand,:)); 
            thetaR2ChM2 = [thetaR2ChM2; thetaR2];
            thetaW1 = mean(fftW1(thetaBand,:)); 
            thetaW1ChM2 = [thetaW1ChM2; thetaW1];
            thetaW2 = mean(fftW2(thetaBand,:)); 
            thetaW2ChM2 = [thetaW2ChM2; thetaW2];
        else
            rTrialN
            wTrialN
        end
    end%ch
    
    
    thetaR1M1 = mean(thetaR1Ch,1);
    thetaR2M1 = mean(thetaR2Ch,1);
    thetaW1M1 = mean(thetaW1Ch,1);
    thetaW2M1 = mean(thetaW2Ch,1);
    thetaR1M2 = mean(thetaR1ChM2,1);
    thetaR2M2 = mean(thetaR2ChM2,1);
    thetaW1M2 = mean(thetaW1ChM2,1);
    thetaW2M2 = mean(thetaW2ChM2,1);
    
    h = figure; hold on;
    XX = [1 : length(thetaR1M1)];
    plot(XX, thetaR1M1+thetaR2M1,'r');
    plot(XX, thetaR1M2+thetaR2M2,'g');
    plot(XX, thetaW1M1+thetaW2M1,'b');
    plot(XX, thetaW1M2+thetaW2M2,'m');

    legend('Ri-M1','Ri-M2','Wr-M1','Wr-M2');
    titleN = ['Theta Power  ' rat date];
    title(titleN);
    saveas(h,[odir titleN],'jpg');
    save([odir titleN], 'thetaR1M1', 'thetaR2M1', 'thetaW1M1', 'thetaW2M1', 'thetaR1M2', 'thetaR2M2', 'thetaW1M2', 'thetaW2M2');
 end%date
 
thetaR1M1Avg = [];
thetaR2M1Avg = [];
thetaW1M1Avg = [];
thetaW2M1Avg = [];
thetaR1M2Avg = [];
thetaR2M2Avg = [];
thetaW1M2Avg = [];
thetaW2M2Avg = [];
 for dateI = 1:dateN
    date1 = blockname{dateI}
     date= date1(5:12);
    titleN = ['Theta Power  ' rat date];
    load([odir titleN]);%, 'thetaR1M1', 'thetaR2M1', 'thetaW1M1', 'thetaW2M1', 'thetaR1M2', 'thetaR2M2', 'thetaW1M2', 'thetaW2M2');
    thetaR1M1Avg = [thetaR1M1Avg; thetaR1M1];
    thetaR2M1Avg = [thetaR2M1Avg; thetaR2M1];
    thetaW1M1Avg = [thetaW1M1Avg; thetaW1M1];
    thetaW2M1Avg = [thetaW2M1Avg; thetaW2M1];
    thetaR1M2Avg = [thetaR1M2Avg; thetaR1M2];
    thetaR2M2Avg = [thetaR2M2Avg; thetaR2M2];
    thetaW1M2Avg = [thetaW1M2Avg; thetaW1M2];
    thetaW2M2Avg = [thetaW2M2Avg; thetaW2M2];
    
 end%date
 thetaR1M1A = mean(thetaR1M1Avg,1);
 thetaR2M1A = mean(thetaR2M1Avg,1);
 thetaW1M1A = mean(thetaW1M1Avg,1);
 thetaW2M1A = mean(thetaW2M1Avg,1);
 thetaR1M2A = mean(thetaR1M2Avg,1);
 thetaR2M2A = mean(thetaR2M2Avg,1);
 thetaW1M2A = mean(thetaW1M2Avg,1);
 thetaW2M2A = mean(thetaW2M2Avg,1);
 
    h = figure; hold on;
    XX = [1 : length(thetaR1M1)];
    plot(XX, thetaR1M1A+thetaR2M1A,'r');
    plot(XX, thetaR1M2A+thetaR2M2A,'g');
    plot(XX, thetaW1M1A+thetaW2M1A,'b');
    plot(XX, thetaW1M2A+thetaW2M2A,'m');

    legend('Ri-M1','Ri-M2','Wr-M1','Wr-M2');
    titleN = ['Theta Power Date Avg ' rat];
    title(titleN);
    saveas(h,[odir titleN],'jpg');
    

  