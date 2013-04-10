close all;
clear;
rat = 'T5L';
ratname = 'T12';
load(['G:\dataLFP\', ratname, '_wave\', ratname, '_blockname']);
idir = ['G:\preparedDataLFP\', ratname, '\'];
odir =  ['G:\LFP5LOutput\', ratname, '\fft\'];
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
        rTrialNc = size(fftMatrixSumRCorrection,3);
        wTrialNc = size(fftMatrixSumWCorrection,3);
        rTrialNr = size(fftMatrixSumRReinforcement,3);
        wTrialNr = size(fftMatrixSumWReinforcement,3);
        if (rTrialNc>2 && wTrialNc>2 && rTrialNr>2 && wTrialNr>2)%remove bad channels            

            fftRc = mean(fftMatrixSumRCorrection,3);
            fftRr = mean(fftMatrixSumRReinforcement,3);
            
            fftWc = mean(fftMatrixSumWCorrection,3);
            fftWr = mean(fftMatrixSumWReinforcement,3);
            
            thetaRc = mean(fftRc(thetaBand,:)); 
            thetaR1Ch = [thetaR1Ch; thetaRc];
            thetaRr = mean(fftRr(thetaBand,:)); 
            thetaR2Ch = [thetaR2Ch; thetaRr];
            thetaWc = mean(fftWc(thetaBand,:)); 
            thetaW1Ch = [thetaW1Ch; thetaWc];
            thetaWr = mean(fftWr(thetaBand,:)); 
            thetaW2Ch = [thetaW2Ch; thetaWr];
        else
            
            [chI rTrialNc  wTrialNc rTrialNr  wTrialNr]%J5L-01-18-12-A
        end
    end%ch
    if (isempty(thetaR1Ch) |isempty(thetaR2Ch) |isempty(thetaW1Ch) |isempty(thetaW2Ch) )
        skipD = 1
        date
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
        legend('Rc','Rr','Wc','Wr');
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

    

  