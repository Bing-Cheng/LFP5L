close all;
clear;
rat = 'T5L';
blockname = {'T5L-11-16-10-A','T5L-11-17-10-A','T5L-11-18-10-A','T5L-11-19-10-A','T5L-11-22-10-A','T5L-11-23-10-A','T5L-11-24-10-A',...
    'T5L-11-29-10-A','T5L-11-30-10-A','T5L-12-01-10-B','T5L-12-02-10-A','T5L-12-03-10-A','T5L-12-06-10-A','T5L-12-07-10-A',...
    'T5L-12-08-10-A','T5L-12-09-10-A','T5L-12-10-10-A','T5L-12-13-10-A','T5L-12-15-10-A'};
idir = 'H:\preparedDataLFP\T10\';
odir =  'H:\LFP5LOutput\T10\fft1\';
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
    
    for j = 1:4
    h = figure; hold on;
    axis([0 600 0 3]);
    for i = 1:4
        ii=i+(j-1)*4;
        plot((thetaR1Ch(ii,:)+thetaR2Ch(ii,:)+thetaW1Ch(ii,:)+thetaW2Ch(ii,:))/1000000,'color',cc(i*16-1,:));
        
    end
    legend(int2str((j-1)*4+1),int2str((j-1)*4+2),int2str((j-1)*4+3),int2str((j-1)*4+4));
    titleN = ['Theta Power ' int2str(j) '  -  ' rat date];
    title(titleN);
    saveas(h,[odir titleN],'jpg');
    end%j
    
    save([odir 'ThetaPower-' rat date], 'thetaR1Ch', 'thetaR2Ch', 'thetaW1Ch', 'thetaW2Ch');
 end%date
 
thetaR1M1Avg = zeros(16,551);
thetaR2M1Avg = zeros(16,551);
thetaW1M1Avg = zeros(16,551);
thetaW2M1Avg = zeros(16,551);

 for dateI = 1:dateN
    date1 = blockname{dateI}
     date= date1(5:12);
    load([odir 'ThetaPower-' rat date]);
    thetaR1M1Avg = [thetaR1M1Avg + thetaR1Ch];
    thetaR2M1Avg = [thetaR2M1Avg + thetaR2Ch];
    thetaW1M1Avg = [thetaW1M1Avg + thetaW1Ch];
    thetaW2M1Avg = [thetaW2M1Avg + thetaW2Ch];
    
 end%date
     thetaR1M1Avg = [thetaR1M1Avg/dateN];
    thetaR2M1Avg = [thetaR2M1Avg/dateN];
    thetaW1M1Avg = [thetaW1M1Avg/dateN];
    thetaW2M1Avg = [thetaW2M1Avg/dateN];
    for j = 1:4
    h = figure; hold on;
    axis([0 600 0 3]);
    for i = 1:4
        ii=i+(j-1)*4;
        plot((thetaR1M1Avg(ii,:)+thetaR2M1Avg(ii,:)+thetaW1M1Avg(ii,:)+thetaW2M1Avg(ii,:))/1000000,'color',cc(i*16-1,:));
        legend(int2str(ii));
    end
    titleN = ['Theta Power ' int2str(j) '  -  ' rat];
    title(titleN);
    saveas(h,[odir titleN],'jpg');
    end%j
    

  