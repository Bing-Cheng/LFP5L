function colorMap500S4RW(ratName, blockname, disFreq)
rat = [ratName(1) '5L'];
idir = ['G:\preparedDataLFP\' ratName '\'];
odir = ['G:\LFP5LOutput\' ratName '\colorMap\'];
block_ch = [1:16];
windowLength = 6000;
fftLength = 500;
fs= 24414;
rfs = 1000;
slidingStep = 10;
b1 = fir1(30,1000/24414);
chN = length(block_ch);
dateN = length(blockname);
dateNN = dateN;
%disFreq = 500;
disTime = 551;
disMatrix = zeros(disFreq,disTime);
    fftR1Dc = zeros(fftLength/2,disTime);
    fftW1Dc = zeros(fftLength/2,disTime);
    fftR1Dr = zeros(fftLength/2,disTime);
    fftW1Dr = zeros(fftLength/2,disTime);
    sessionRemove = 0;
    ACRc1 = [];
    ACWc1 = [];
    ACRr1 = [];
    ACWr1 = [];
for dateI = 1:dateN
    date1 = blockname{dateI}
    date= date1(5:12);
    fftR1c = zeros(fftLength/2,disTime);
    fftW1c = zeros(fftLength/2,disTime);
    fftR1r = zeros(fftLength/2,disTime);
    fftW1r = zeros(fftLength/2,disTime);

    k = 0;
    for chI = 1 : 16
        titleACNa = [idir 'fftMatrix' rat date '-ch' int2str(chI)];
        load(titleACNa); 
        rTrialNc = size(fftMatrixSumRCorrection,3);
        wTrialNc = size(fftMatrixSumWCorrection,3);
        rTrialNr = size(fftMatrixSumRReinforcement,3);
        wTrialNr = size(fftMatrixSumWReinforcement,3);
        if (rTrialNc>2 && wTrialNc>2 && rTrialNr>2 && wTrialNr>2)%remove bad channels   
            k = k + 1;

            fftMatrixSumAvgRc = mean(fftMatrixSumRCorrection,3);
            fftMatrixSumAvgWc = mean(fftMatrixSumWCorrection,3);
            fftMatrixSumAvgRr = mean(fftMatrixSumRReinforcement,3);
            fftMatrixSumAvgWr = mean(fftMatrixSumWReinforcement,3);
            
           
            fftR1c = fftR1c+fftMatrixSumAvgRc;
            fftW1c = fftW1c+fftMatrixSumAvgWc;
            fftR1r = fftR1r+fftMatrixSumAvgRr;
            fftW1r = fftW1r+fftMatrixSumAvgWr;

        else
            [chI rTrialNc wTrialNc rTrialNr wTrialNr]
            sessionRemove = 1;
        end%if
        
    end%ch
    if (sessionRemove==0)
    fftR1mc = fftR1c/k;
    fftW1mc = fftW1c/k;
    fftR1Dc = fftR1Dc + fftR1mc;
    fftW1Dc = fftW1Dc + fftW1mc;
    fftR1mr = fftR1r/k;
    fftW1mr = fftW1r/k;
    fftR1Dr = fftR1Dr + fftR1mr;
    fftW1Dr = fftW1Dr + fftW1mr;
    ACRc = mean(mean(fftR1mc([2:4],[201:400])));
    ACWc = mean(mean(fftW1mc([2:4],[201:400])));
    ACRr = mean(mean(fftR1mr([2:4],[201:400])));
    ACWr = mean(mean(fftW1mr([2:4],[201:400])));
    ACRc1 = [ACRc1 ACRc];
    ACWc1 = [ACWc1 ACWc];
    ACRr1 = [ACRr1 ACRr];
    ACWr1 = [ACWr1 ACWr];
    else
        sessionRemove =0;
        dateNN = dateNN -1;
    end
end%date
fftR1Dmc = fftR1Dc/dateNN;
fftW1Dmc = fftW1Dc/dateNN;
fftR1Dmr = fftR1Dr/dateNN;
fftW1Dmr = fftW1Dr/dateNN;
if(isnan(fftR1Dmc))
    tmp=1;
end

save([odir rat 'fft'], 'fftR1Dmc', 'fftW1Dmc', 'fftR1Dmr', 'fftW1Dmr');
            h = figure('position', [0   100   560   420]); 
            disMatrix([1:2:disFreq],:) = fftR1Dmc(1:disFreq/2,:);
            disMatrix([2:2:disFreq],:) = fftR1Dmc(1:disFreq/2,:);
            imagesc(disMatrix);
            colorbar;
            titleName = [rat '-R-c-' int2str(disFreq)];
            title(titleName);
            saveas(h,[odir titleName],'jpg');
            
            h = figure('position', [700   100   560   420]); 
            disMatrix([1:2:disFreq],:) = fftW1Dmc(1:disFreq/2,:);
            disMatrix([2:2:disFreq],:) = fftW1Dmc(1:disFreq/2,:);
            imagesc(disMatrix);
            colorbar;
            titleName = [rat  '-W-c-' int2str(disFreq)];
            title(titleName);
            saveas(h,[odir titleName],'jpg');
            
            h = figure('position', [0   100   560   420]); 
            disMatrix([1:2:disFreq],:) = fftR1Dmr(1:disFreq/2,:);
            disMatrix([2:2:disFreq],:) = fftR1Dmr(1:disFreq/2,:);
            imagesc(disMatrix);
            colorbar;
            titleName = [rat '-R-r-' int2str(disFreq)];
            title(titleName);
            saveas(h,[odir titleName],'jpg');
            
            h = figure('position', [700   100   560   420]); 
            disMatrix([1:2:disFreq],:) = fftW1Dmr(1:disFreq/2,:);
            disMatrix([2:2:disFreq],:) = fftW1Dmr(1:disFreq/2,:);
            imagesc(disMatrix);
            colorbar;
            titleName = [rat  '-W-r-' int2str(disFreq)];
            title(titleName);
            saveas(h,[odir titleName],'jpg');
            
            thetaBand = [2:4];%4~8Hz
            thetaR1c = mean(fftR1Dmc(thetaBand,:)); 
            thetaW1c = mean(fftW1Dmc(thetaBand,:)); 
            thetaR1r = mean(fftR1Dmr(thetaBand,:)); 
            thetaW1r = mean(fftW1Dmr(thetaBand,:)); 
 h = figure; hold on;
        XX = [1 : length(thetaR1c)];%-200;
        plot(XX, thetaR1c,'r');
        plot(XX, thetaW1c,'g');
        plot(XX, thetaR1r,'b');
        plot(XX, thetaW1r,'y');

        legend('Right correction','Wrong correction','Right reinforcement','Wrong reinforcement');
        titleN = ['Theta Power  ' rat];
        title(titleN);
        saveas(h,[odir titleN],'jpg');
  