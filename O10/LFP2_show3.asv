close all;
clear;
rat = 'O5L';
blockname = {'O5L-10-04-10-A','O5L-10-05-10-A','O5L-10-06-10-B','O5L-10-07-10-A','O5L-10-08-10-B','O5L-10-11-10-A'};
idir = 'H:\preparedDataLFP\O10\';
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
    gammaR1Ch = [];
    gammaR2Ch = [];
    gammaW1Ch = [];
    gammaW2Ch = [];
    for chI = 1 : 16
        titleNa = [idir 'fftMatrix' rat date '-ch' int2str(chI)]
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
            
            p00_10R1 = mean(fftR1(1:5,:)); 
            p20_40R1 = mean(fftR1(10:20,:)); 
            gammaR1 = p20_40R1./p00_10R1;
            gammaR1Ch = [gammaR1Ch; gammaR1];
            p00_10R2 = mean(fftR2(1:5,:)); 
            p20_40R2 = mean(fftR2(10:20,:)); 
            gammaR2 = p20_40R2./p00_10R2;
            gammaR2Ch = [gammaR2Ch; gammaR2];
            p00_10W1 = mean(fftW1(1:5,:)); 
            p20_40W1 = mean(fftW1(10:20,:)); 
            gammaW1 = p20_40W1./p00_10W1;
            gammaW1Ch = [gammaW1Ch; gammaW1];
            p00_10W2 = mean(fftW2(1:5,:)); 
            p20_40W2 = mean(fftW2(10:20,:)); 
            gammaW2 = p20_40W2./p00_10W2;
            gammaW2Ch = [gammaW2Ch; gammaW2];
        else
            rTrialN
            wTrialN
        end
    end%ch
    gammaR1ChAvg = mean(gammaR1Ch,1);
    gammaR2ChAvg = mean(gammaR2Ch,1);
    gammaW1ChAvg = mean(gammaW1Ch,1);
    gammaW2ChAvg = mean(gammaW2Ch,1);
    figure; hold on;
    XX = [1 : length(gammaR1ChAvg)]-200;
    plot(XX, gammaR1ChAvg,'r');
    plot(XX, gammaR2ChAvg,'g');
    plot(XX, gammaW1ChAvg,'b');
    plot(XX, gammaW2ChAvg,'m');
    legend('R1','R2','W1','W2');
    titleN = ['Relative Gamma Power  ' rat date];
    title(titleN);
    gR1AC = mean(gammaR1ChAvg(201:400));
    gR2AC = mean(gammaR2ChAvg(201:400));
    gW1AC = mean(gammaW1ChAvg(201:400));
    gW2AC = mean(gammaW2ChAvg(201:400));
    gGroup4 = [gR1AC gR2AC; gW1AC gW2AC];
    gGroup4Date(:,:,dateI) = gGroup4;
 end%date
save([rat 'gGroup4Date'], 'gGroup4Date');
load([rat 'gGroup4Date']);
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
rmD = [1 3];
gGroup4Date(:,:,rmD) = []
gDateAvg = mean(gGroup4Date,3)
    

  