close all;
clear;
rat = 'A5L';
blockname ={...%'A5L-08-06-09-A','A5L-08-27-09-A','A5L-08-28-09-A','A5L-08-31-09-A','A5L-09-01-09-A','A5L-09-08-09-A','A5L-09-09-09-A','A5L-09-10-09-A',...
    'A5L-09-11-09-H','A5L-09-16-09-A','A5L-09-17-09-A','A5L-09-18-09-A','A5L-09-21-09-A','A5L-09-22-09-A','A5L-09-23-09-A','A5L-09-24-09-A','A5L-09-25-09-B',...
    'A5L-09-28-09-A','A5L-09-29-09-A','A5L-09-30-09-A','A5L-10-01-09-B','A5L-10-05-09-A','A5L-10-06-09-A','A5L-10-07-09-A','A5L-10-08-09-A',...
    'A5L-10-09-09-A','A5L-10-12-09-A','A5L-10-14-09-A','A5L-10-15-09-A','A5L-10-19-09-A','A5L-10-20-09-A','A5L-10-22-09-A','A5L-10-23-09-A','A5L-10-26-09-A',...
    'A5L-10-27-09-A','A5L-10-28-09-A','A5L-10-29-09-A','A5L-10-30-09-A','A5L-11-02-09-A','A5L-11-03-09-A','A5L-11-05-09-A'};
idir = 'H:\preparedDataLFP\A09\';
odir =  'H:\LFP5LOutput\A09\fft\';
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
        rTrialN = size(fftPhaseSum,3);
        wTrialN = size(fftPhaseSumW,3);
        if (rTrialN>2 && wTrialN>2)
            R1N = [1 : floor(rTrialN/2)];
            R2N = [floor(rTrialN/2)+1 : rTrialN];
            fftR1 = mean(fftPhaseSum(:,:,R1N),3);
            fftR2 = mean(fftPhaseSum(:,:,R2N),3);
            W1N = [1 : floor(wTrialN/2)];
            W2N = [floor(wTrialN/2)+1 : wTrialN];
            fftW1 = mean(fftPhaseSumW(:,:,W1N),3);
            fftW2 = mean(fftPhaseSumW(:,:,W2N),3);
            
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
        rTrialN = size(fftPhaseSum,3);
        wTrialN = size(fftPhaseSumW,3);
        if (rTrialN>2 && wTrialN>2)
            R1N = [1 : floor(rTrialN/2)];
            R2N = [floor(rTrialN/2)+1 : rTrialN];
            fftR1 = mean(fftPhaseSum(:,:,R1N),3);
            fftR2 = mean(fftPhaseSum(:,:,R2N),3);
            W1N = [1 : floor(wTrialN/2)];
            W2N = [floor(wTrialN/2)+1 : wTrialN];
            fftW1 = mean(fftPhaseSumW(:,:,W1N),3);
            fftW2 = mean(fftPhaseSumW(:,:,W2N),3);
            
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
    titleN = ['Theta Phase  ' rat date];
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
    titleN = ['Theta Phase  ' rat date];
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
    titleN = ['Theta Phase Date Avg ' rat];
    title(titleN);
    saveas(h,[odir titleN],'jpg');
    

  