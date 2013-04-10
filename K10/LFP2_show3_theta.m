close all;
clear;
rat = 'K5L';
blockname =  {'K5L-07-19-10-A','K5L-07-21-10-A','K5L-07-22-10-A','K5L-07-23-10-A','K5L-07-26-10-A','K5L-07-27-10-A','K5L-07-28-10-A'};
idir = 'H:\preparedDataLFP\K10\';
odir =  'H:\LFP5LOutput\K10\fft\';
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
    for chI = 1 : 16
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
            
            thetaR1 = mean(fftR1(2:4,:)); 
            thetaR1Ch = [thetaR1Ch; thetaR1];
            thetaR2 = mean(fftR2(1:5,:)); 
            thetaR2Ch = [thetaR2Ch; thetaR2];
            thetaW1 = mean(fftW1(1:5,:)); 
            thetaW1Ch = [thetaW1Ch; thetaW1];
            thetaW2 = mean(fftW2(1:5,:)); 
            thetaW2Ch = [thetaW2Ch; thetaW2];
        else
            rTrialN
            wTrialN
        end
    end%ch
    thetaR1ChAvg = mean(thetaR1Ch,1);
    thetaR2ChAvg = mean(thetaR2Ch,1);
    thetaW1ChAvg = mean(thetaW1Ch,1);
    thetaW2ChAvg = mean(thetaW2Ch,1);
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
load([rat 'tGroup4Date']);
dRW = gGroup4Date(1,:,:) - gGroup4Date(2,:,:);
d12 = gGroup4Date(:,2,:) - gGroup4Date(:,1,:);
dRWAvg = sum(dRW,2);
d12Avg = sum(d12,1);
dAvgRW = squeeze(dRWAvg);
dAvg12 = squeeze(d12Avg);
figure
hold on;
plot(dAvgRW,'r')
plot(dAvg12,'g');
legend('RW','21');
rmD1 = find(dAvgRW>0 & dAvg12>0)

    

  