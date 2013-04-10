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
        if (rTrialNc+rTrialNr>2 && wTrialNc+wTrialNr>2)%remove bad channels            

            fftRc = mean(fftMatrixSumRCorrection,3);
            fftRr = mean(fftMatrixSumRReinforcement,3);
            if(rTrialNc==0)
                fftR =  fftRr;
            elseif(rTrialNr==0)
                fftR = fftRc ;
            else
                fftR = (fftRc*rTrialNc+ fftRr*rTrialNr)/(rTrialNc+rTrialNr);
            end
            fftWc = mean(fftMatrixSumWCorrection,3);
            fftWr = mean(fftMatrixSumWReinforcement,3);
            if(wTrialNc==0)
                fftW =  fftWr;
            elseif(wTrialNr==0)
                fftW = fftRc ;
            else
                fftW = (fftWc*wTrialNc+ fftWr*wTrialNr)/(wTrialNc+wTrialNr);
            end
            thetaRc = mean(fftR(thetaBand,:)); 
            thetaR1Ch = [thetaR1Ch; thetaRc];
            
            thetaWc = mean(fftW(thetaBand,:)); 
            thetaW1Ch = [thetaW1Ch; thetaWc];
            
        else
            
            [chI rTrialNc  wTrialNc rTrialNr  wTrialNr]%J5L-01-18-12-A
        end
    end%ch
    if (isempty(thetaR1Ch)  |isempty(thetaW1Ch)  )
        skipD = 1
        date
    else
        thetaR1ChAvg = mean(thetaR1Ch,1);
       
        thetaW1ChAvg = mean(thetaW1Ch,1);
        
        save([rat date 'thetaChAvg'], 'thetaR1ChAvg','thetaW1ChAvg');
        h = figure; hold on;
        XX = [1 : length(thetaR1ChAvg)]-200;
        plot(XX, thetaR1ChAvg,'r');
        
        plot(XX, thetaW1ChAvg,'b');
        
        legend('Rc','Wc');
        titleN = ['Theta Power  ' rat date];
        title(titleN);
        saveas(h,[odir titleN],'jpg');
        gR1AC = mean(thetaR1ChAvg(201:400));
        
        gW1AC = mean(thetaW1ChAvg(201:400));
        

        gDateR1(dd) = gR1AC;
        
        gDateW1(dd) = gW1AC;
        
        dd= dd+1;
    end
 end%date
save([rat 'tDate'], 'gDateR1', 'gDateW1');

dRW = gDateR1  - gDateW1 ;


h = figure
hold on;
plot(dRW,'r');

titleN = ['Theta Power 2' rat];
    title(titleN);
    saveas(h,[odir titleN],'jpg');




    

  