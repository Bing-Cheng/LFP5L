close all;
clear;
rat = 'I5L';
blockname = {'I5L-05-06-10-A','I5L-05-07-10-A','I5L-05-13-10-B','I5L-05-14-10-B','I5L-05-26-10-A',...
    'I5L-05-27-10-A','I5L-05-28-10-A','I5L-06-01-10-A','I5L-06-02-10-A','I5L-06-03-10-A','I5L-06-04-10-A','I5L-06-07-10-A',...
    'I5L-06-08-10-A','I5L-06-09-10-A','I5L-06-10-10-A','I5L-06-11-10-A','I5L-06-14-10-A','I5L-06-15-10-A','I5L-06-16-10-A',...
    'I5L-06-17-10-A','I5L-06-18-10-A','I5L-06-21-10-A','I5L-06-29-10-A','I5L-06-30-10-A','I5L-07-01-10-A',...
    'I5L-07-02-10-A','I5L-07-06-10-A','I5L-07-07-10-A','I5L-07-08-10-A','I5L-07-09-10-A'};
idir = 'H:\preparedDataLFP\I10\';
odir =  'H:\LFP5LOutput\I10\fft\';
windowLength = 6000;
fftLength = 500;
fs= 24414;
rfs = 1000;
slidingStep = 10;
dateN = length(blockname);
gGroup4Date = zeros(2,2,dateN);
dd=1;
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
    if (isempty(thetaR1Ch) |isempty(thetaR2Ch) |isempty(thetaW1Ch) |isempty(thetaW2Ch) )
        skipD = 1
    else
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

        gDateR1(dd) = gR1AC;
        gDateR2(dd) = gR2AC;
        gDateW1(dd) = gW1AC;
        gDateW2(dd) = gW2AC;
        dd= dd+1;
    end
 end%date
save([rat 'tDate'], 'gDateR1', 'gDateR2', 'gDateW1', 'gDateW2');

dRW = gDateR1 + gDateR2 - gDateW1 - gDateW2;
d12 = gDateR1 - gDateR2 + gDateW1 - gDateW2;

h = figure
hold on;
plot(dRW,'r');
plot(d12,'g');
legend('RW','12');
titleN = ['Theta Power 2' rat];
    title(titleN);
    saveas(h,[odir titleN],'jpg');


h = figure
hold on;
plot(gDateR1,'r');
plot(gDateR2,'g');
plot(gDateW1,'b')
plot(gDateW2,'m')
legend('R1','R2','W1','W2');
titleN = ['Theta Power 4' rat];
    title(titleN);
    saveas(h,[odir titleN],'jpg');

    

  