close all;
clear;
rat = 'Q5L';
blockname = {'Q5L-12-03-10-A','Q5L-12-07-10-A','Q5L-12-08-10-B','Q5L-12-09-10-A','Q5L-12-10-10-A','Q5L-01-06-11-A','Q5L-01-07-11-A',...
    'Q5L-01-10-11-B','Q5L-01-11-11-A','Q5L-01-12-11-A','Q5L-01-14-11-A','Q5L-01-18-11-A','Q5L-01-19-11-A','Q5L-01-20-11-A','Q5L-01-21-11-A','Q5L-01-24-11-A'};

idir = 'H:\preparedDataLFP\Q10\';
odir =  'H:\LFP5LOutput\Q10\fft\';
windowLength = 6000;
fftLength = 500;
fs= 24414;
rfs = 1000;
slidingStep = 10;
dateN = length(blockname);
gGroup4Date = zeros(2,2,dateN);
for dateI = 1:dateN
    date1 = blockname{dateI}
    date= date1(5:12);
    thetaR1Ch = [];
    thetaR2Ch = [];
    thetaW1Ch = [];
    thetaW2Ch = [];
    thetaBand = [2:4];%4~8Hz
    for chI = 1 : 16
        titleNa = [idir 'fftMatrix' rat date '-ch' int2str(chI)];
        load(titleNa); 
        rTrialN = size(fftMatrixSum,3);
        wTrialN = size(fftMatrixSumW,3);
        if (rTrialN>2 && wTrialN>2)%remove bad channels            
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
            
            [chI rTrialN  wTrialN]
        end
    end%ch
    thetaR1ChAvg = mean(thetaR1Ch,1);
    thetaR2ChAvg = mean(thetaR2Ch,1);
    thetaW1ChAvg = mean(thetaW1Ch,1);
    thetaW2ChAvg = mean(thetaW2Ch,1);
    save([rat date 'thetaChAvg'], 'thetaR1ChAvg','thetaR2ChAvg','thetaW1ChAvg','thetaW2ChAvg');
    h = figure; hold on;
    XX = [1 : length(thetaR1ChAvg)]-200;
    plot(XX, thetaR1ChAvg,'r');
    plot(XX, thetaR2ChAvg,'g');
    plot(XX, thetaW1ChAvg,'b');
    plot(XX, thetaW2ChAvg,'m');
    legend('R1','R2','W1','W2');
    titleN = ['Theta Power  ' rat date];
    title(titleN);
    saveas(h,[odir titleN],'jpg');
    gR1AC = mean(thetaR1ChAvg(201:400));
    gR2AC = mean(thetaR2ChAvg(201:400));
    gW1AC = mean(thetaW1ChAvg(201:400));
    gW2AC = mean(thetaW2ChAvg(201:400));
    gGroup4 = [gR1AC gR2AC; gW1AC gW2AC];
    gGroup4Date(:,:,dateI) = gGroup4;
 end%date
save([rat 'tGroup4Date'], 'gGroup4Date');
rat = 'Q5L';
load([rat 'tGroup4Date']);
dRW = gGroup4Date(1,:,:) - gGroup4Date(2,:,:);
d12 = gGroup4Date(:,2,:) - gGroup4Date(:,1,:);
dRWAvg = sum(dRW,2);
d12Avg = sum(d12,1);
dAvgRW = squeeze(dRWAvg);
dAvg12 = squeeze(d12Avg);
h = figure
hold on;
plot(dAvgRW,'r')
plot(dAvg12,'g');
legend('RW','21');
titleN = ['Theta Power Summary' rat];
    title(titleN);
    saveas(h,[odir titleN],'jpg');
rmD1 = find(dAvgRW>0 & dAvg12>0)

    

  