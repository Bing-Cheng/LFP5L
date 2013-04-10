close all;
clear;
disFreq = 50;
disTime = 551;
disMatrix = zeros(disFreq,disTime);
ratNames = {'A09','O10','Q10','T10','G11', 'K11', 'O12', 'R12','S12', 'T12'};
%ratNames = {'Q10','T10','G11', 'K11', 'O12', 'R12','S12', 'T12'};
%ratNames = {'T12'};
ratNumber = length(ratNames);
minTrials = 6;
wBS = [1:100];
wBT = [150:200];
wAC = [201:400];
thetaBand = [2:4];%4~8Hz
respondAC = zeros(2,2096);
thetaRC1=[];
thetaRR1=[];
thetaWC1=[];
thetaWR1=[];

thetaRC2=zeros(551,1);
thetaRR2=zeros(551,1);
thetaWC2=zeros(551,1);
thetaWR2=zeros(551,1);
nUnit = 0;
for i = 1 : ratNumber
    ratname = ratNames{i};
    rat = [ratname(1) '5L'];
    load(['G:\preparedDataLFP\', ratname, '_blockname']);
    nDate = length(blockname);
    for d = 1 : nDate
        date = blockname{d};
        date([4, 13, 14]) = []
        for ch = 1 : 16
            load(['G:\preparedDataLFP\', ratname, '\fftMatrix', date, '-ch',int2str(ch)]);
            nTrialRC = size(fftMatrixSumRCorrection,3);
            nTrialRR = size(fftMatrixSumRReinforcement,3);
            nTrialWC = size(fftMatrixSumWCorrection,3);
            nTrialWR = size(fftMatrixSumWReinforcement,3);
            if (((nTrialRC+nTrialRR)>minTrials)&&((nTrialWC+nTrialWR)>minTrials))
                nUnit = nUnit +1;
                thetaRC = squeeze(mean(fftMatrixSumRCorrection(thetaBand,:,:)));
                thetaRR = squeeze(mean(fftMatrixSumRReinforcement(thetaBand,:,:)));
                thetaWC = squeeze(mean(fftMatrixSumWCorrection(thetaBand,:,:)));
                thetaWR = squeeze(mean(fftMatrixSumWReinforcement(thetaBand,:,:)));
                if(sum(isempty(thetaWR))~=0 )
                    tmp=0
                    ch
                else
                   thetaWR1 = [thetaWR1 thetaWR]; 
                    thetaWR2 = thetaWR2 + mean(thetaWR,2);
                end
                thetaRC1 = [thetaRC1 thetaRC];
                thetaRR1 = [thetaRR1 thetaRR];
                thetaWC1 = [thetaWC1 thetaWC];
                
                thetaRC2 = thetaRC2 + mean(thetaRC,2);
                thetaRR2 = thetaRR2 + mean(thetaRR,2);
                thetaWC2 = thetaWC2 + mean(thetaWC,2);
                
                if(sum(isnan(thetaWR1))~=0 )
                    tmp=1
                end
                if(sum(isnan(thetaWR2))~=0 )
                    tmp=2
                end
                
            else
                [date ch nTrialRC nTrialRR nTrialWC nTrialWR]
            end
            
        end%ch
    end%date
end%rat
save('G:\preparedDataLFP\allUniteTheta4.mat', 'thetaRC1','thetaRR1','thetaWC1','thetaWR1',...
    'thetaRC2','thetaRR2','thetaWC2','thetaWR2');
        h = figure; hold on;
        XX = [-200 : 350];%-200;
        plot(XX, mean(thetaRC1,2),'r','LineWidth',2);
        plot(XX, mean(thetaRR1,2),'g','LineWidth',2);
        plot(XX, mean(thetaWC1,2),'b','LineWidth',2);
        plot(XX, mean(thetaWR1,2),'m','LineWidth',2);
        legend('RC','RR','WC','WR');
        titleN = ['Theta Power 1'];
        title(titleN);
        saveas(h,['G:\preparedDataLFP\' titleN],'jpg');
        
        h = figure; hold on;
      
        plot(XX, thetaRC2,'r','LineWidth',2);
        plot(XX, thetaRR2,'g','LineWidth',2);
        plot(XX, thetaWC2,'b','LineWidth',2);
        plot(XX, thetaWR2,'m','LineWidth',2);
        legend('RC','RR','WC','WR');
        titleN = ['Theta Power 2'];
        title(titleN);
        saveas(h,['G:\preparedDataLFP\' titleN],'jpg');
        
                h = figure; hold on;
        XX = [-200 : 350];%-200;
        thetaR = [thetaRC1 thetaRR1];
        thetaW = [thetaWC1 thetaWR1];
        plot(XX, mean(thetaR,2),'r','LineWidth',2);
        %plot(XX, mean(thetaRR1,2),'g','LineWidth',2);
        plot(XX, mean(thetaW,2),'b','LineWidth',2);
        %plot(XX, mean(thetaWR1,2),'m','LineWidth',2);
        legend('R','W');
        titleN = ['Theta Power 3'];
        title(titleN);
        saveas(h,['G:\preparedDataLFP\' titleN],'jpg');
        
                        h = figure; hold on;
        XX = [-200 : 200];%-200;
        thetaR = [thetaRC2+ thetaRR2];
        thetaW = [thetaWC2+ thetaWR2];
        plot(XX,thetaR(1:401),'r','LineWidth',2);
        %plot(XX, mean(thetaRR1,2),'g','LineWidth',2);
        plot(XX, thetaW(1:401),'b','LineWidth',2);
        %plot(XX, mean(thetaWR1,2),'m','LineWidth',2);
        legend('R','W');
        titleN = ['Theta Power 5'];
        title(titleN);
        saveas(h,['G:\preparedDataLFP\' titleN],'jpg');



  