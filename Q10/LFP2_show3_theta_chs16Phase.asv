close all;
clear;
rat = 'Q5L';
blockname = {'Q5L-12-07-10-A','Q5L-12-08-10-B','Q5L-12-09-10-A','Q5L-12-10-10-A','Q5L-01-06-11-A','Q5L-01-07-11-A',...
    'Q5L-01-10-11-B','Q5L-01-11-11-A','Q5L-01-12-11-A','Q5L-01-14-11-A','Q5L-01-18-11-A','Q5L-01-19-11-A','Q5L-01-20-11-A','Q5L-01-21-11-A','Q5L-01-24-11-A'};
idir = 'H:\preparedDataLFP\Q10\';
odir =  'H:\LFP5LOutput\Q10\fft1\';
windowLength = 6000;
fftLength = 500;
fs= 24414;
rfs = 1000;
slidingStep = 10;
dateN = length(blockname);
gGroup4Date = zeros(2,2,dateN);
thetaBand = [2:4]; %4~8Hz
cc = colormap;
for dateI = 1:dateN
    date1 = blockname{dateI}
    date= date1(5:12);
    thetaR1Ch = [];
    thetaR2Ch = [];
    thetaW1Ch = [];
    thetaW2Ch = [];
    for chI = [1 : 16]
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
    
    thetaPhaseD=(thetaR1Ch+thetaR2Ch+thetaW1Ch+thetaW2Ch)/4;
    for j = 1:4
    h = figure; hold on;
    axis([0 600 -1.5 1.5]);
    for i = 1:4
        ii=i+(j-1)*4;
        plot(thetaPhaseD(ii,:),'color',cc(i*16-1,:));
        
    end
    legend(int2str((j-1)*4+1),int2str((j-1)*4+2),int2str((j-1)*4+3),int2str((j-1)*4+4));
    titleN = ['Theta Phase ' int2str(j) '  -  ' rat date];
    title(titleN);
    saveas(h,[odir titleN],'jpg');
    end%j
    
    save([odir 'ThetaPhase-' rat date], 'thetaR1Ch', 'thetaR2Ch', 'thetaW1Ch', 'thetaW2Ch');
 end%date
 
thetaR1M1Avg = zeros(16,551);
thetaR2M1Avg = zeros(16,551);
thetaW1M1Avg = zeros(16,551);
thetaW2M1Avg = zeros(16,551);

 for dateI = 1:dateN
    date1 = blockname{dateI}
     date= date1(5:12);
    load([odir 'ThetaPhase-' rat date]);
    thetaR1M1Avg = [thetaR1M1Avg + thetaR1Ch];
    thetaR2M1Avg = [thetaR2M1Avg + thetaR2Ch];
    thetaW1M1Avg = [thetaW1M1Avg + thetaW1Ch];
    thetaW2M1Avg = [thetaW2M1Avg + thetaW2Ch];
    
 end%date
     thetaR1M1Avg = [thetaR1M1Avg/dateN];
    thetaR2M1Avg = [thetaR2M1Avg/dateN];
    thetaW1M1Avg = [thetaW1M1Avg/dateN];
    thetaW2M1Avg = [thetaW2M1Avg/dateN];
    thetaPhase = (thetaR1M1Avg+thetaR2M1Avg+thetaW1M1Avg+thetaW2M1Avg)/4;
%     for j = 1:4
%     h = figure; hold on;
%     axis([0 600 -1.5 1.5]);
%     for i = 1:4
%         ii=i+(j-1)*4;
%         plot(thetaPhase(ii,:), 'color',cc(i*16-1,:));
%         
%     end
%         legend(int2str((j-1)*4+1),int2str((j-1)*4+2),int2str((j-1)*4+3),int2str((j-1)*4+4));
%     titleN = ['Theta Phase ' int2str(j) '  -  ' rat];
%     title(titleN);
%     saveas(h,[odir titleN],'jpg');
%     end%j
    
    
    h = figure; hold on;

        plot(var(thetaPhase)./mean(thetaPhase));
        

    titleN = ['Theta Phase Variance - nom - ' rat];
    title(titleN);
    saveas(h,[odir titleN],'jpg');
    

  