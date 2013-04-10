close all;
clear;
rat = 'A5L';
blockname ={'A5L-08-06-09-A','A5L-08-28-09-A','A5L-08-31-09-A','A5L-09-01-09-A','A5L-09-08-09-A','A5L-09-09-09-A','A5L-09-10-09-A',...
    'A5L-09-11-09-H','A5L-09-16-09-A','A5L-09-17-09-A','A5L-09-18-09-A','A5L-09-21-09-A','A5L-09-22-09-A','A5L-09-23-09-A','A5L-09-24-09-A','A5L-09-25-09-B',...
    'A5L-09-28-09-A','A5L-09-29-09-A','A5L-09-30-09-A','A5L-10-01-09-B','A5L-10-05-09-A','A5L-10-06-09-A','A5L-10-07-09-A','A5L-10-08-09-A',...
    'A5L-10-09-09-A','A5L-10-12-09-A','A5L-10-14-09-A','A5L-10-15-09-A','A5L-10-19-09-A','A5L-10-20-09-A','A5L-10-22-09-A','A5L-10-23-09-A','A5L-10-26-09-A',...
    'A5L-10-27-09-A','A5L-10-28-09-A','A5L-10-29-09-A','A5L-10-30-09-A','A5L-11-02-09-A','A5L-11-03-09-A','A5L-11-05-09-A'};
idir = 'G:\LFPelements\A09\preparedDataLFP\';
odir =  'G:\LFP5LOutput\A09\fft\';
windowLength = 6000;
fftLength = 500;
fs= 24414;
rfs = 1000;
slidingStep = 10;
dateN = length(blockname);
gGroup4Date = zeros(2,2,dateN);
dd=1;
for dateI = 38:dateN
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

    

  