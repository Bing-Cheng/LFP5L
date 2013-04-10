function colorMap500S4RW1BE(ratName, blockname, disFreq)
rat = [ratName(1) '5L'];
idir = ['G:\preparedDataLFP\' ratName '\'];
odir = ['G:\LFP5LOutput\' ratName '\colorMap\'];

fftLength = 500;
dateN = length(blockname);
disTime = 151;
disMatrix = zeros(disFreq,disTime);
    fftR1Dc = zeros(fftLength/2,disTime);
    fftW1Dc = zeros(fftLength/2,disTime);
    fftR1Dr = zeros(fftLength/2,disTime);
    fftW1Dr = zeros(fftLength/2,disTime);
for dateI = 1:dateN
    date1 = blockname{dateI}
    date= date1(5:12);
    fftR1c = zeros(fftLength/2,disTime);
    fftW1c = zeros(fftLength/2,disTime);
    fftR1r = zeros(fftLength/2,disTime);
    fftW1r = zeros(fftLength/2,disTime);

    k = 0;
    for chI = 1 : 16
        titleACNa = [idir 'BEfftMatrix' rat date '-ch' int2str(chI)];
        load(titleACNa); 
        rTrialNc = size(fftMatrixSumRCorrection,3);
        wTrialNc = size(fftMatrixSumWCorrection,3);
        rTrialNr = size(fftMatrixSumRReinforcement,3);
        wTrialNr = size(fftMatrixSumWReinforcement,3);
        if (rTrialNc+rTrialNr>2 && wTrialNc+wTrialNr>2 )%remove bad channels   
            k = k + 1;
            fftRc = mean(fftMatrixSumRCorrection,3);
            fftWc = mean(fftMatrixSumWCorrection,3);
            fftRr = mean(fftMatrixSumRReinforcement,3);
            fftWr = mean(fftMatrixSumWReinforcement,3);
            if(rTrialNc==0)
                fftR =  fftRr;
            elseif(rTrialNr==0)
                fftR = fftRc ;
            else
                fftR = (fftRc*rTrialNc+ fftRr*rTrialNr)/(rTrialNc+rTrialNr);
            end
            if(wTrialNc==0)
                fftW =  fftWr;
            elseif(wTrialNr==0)
                fftW = fftRc ;
            else
                fftW = (fftWc*wTrialNc+ fftWr*wTrialNr)/(wTrialNc+wTrialNr);
            end
            fftR1c = fftR1c+fftR;
            fftW1c = fftW1c+fftW;
        else
            [chI rTrialNc wTrialNc rTrialNr wTrialNr]
        end%if
        
    end%ch
    fftR1mc = fftR1c/16;
    fftW1mc = fftW1c/16;
    fftR1Dc = fftR1Dc + fftR1mc;
    fftW1Dc = fftW1Dc + fftW1mc;

end%date
fftR1Dmc = fftR1Dc/dateN;
fftW1Dmc = fftW1Dc/dateN;

save([odir rat 'fftBE'], 'fftR1Dmc', 'fftW1Dmc');
            h = figure('position', [0   100   560   420]); 
            disMatrix([1:2:disFreq],:) = fftR1Dmc(1:disFreq/2,:);
            disMatrix([2:2:disFreq],:) = fftR1Dmc(1:disFreq/2,:);
            imagesc(disMatrix);
            colorbar;
            titleName = [rat 'BE-R-' int2str(disFreq)];
            title(titleName);
            saveas(h,[odir titleName],'jpg');
            
            h = figure('position', [700   100   560   420]); 
            disMatrix([1:2:disFreq],:) = fftW1Dmc(1:disFreq/2,:);
            disMatrix([2:2:disFreq],:) = fftW1Dmc(1:disFreq/2,:);
            imagesc(disMatrix);
            colorbar;
            titleName = [rat  'BE-W-' int2str(disFreq)];
            title(titleName);
            saveas(h,[odir titleName],'jpg');
            thetaBand = [2:4];%4~8Hz
            thetaR1c = mean(fftR1Dmc(thetaBand,:)); 
            thetaW1c = mean(fftW1Dmc(thetaBand,:)); 

 h = figure; hold on;
        XX = [1 : length(thetaR1c)];%-200;
        plot(XX, thetaR1c,'r');
        plot(XX, thetaW1c,'g');
        legend('Right ','Wrong ');
        titleN = ['BE Theta Power  ' rat];
        title(titleN);
        saveas(h,[odir titleN],'jpg');

  