close all;
clear;
disFreq = 50;
disTime = 551;
disMatrix = zeros(disFreq,disTime);
ratNames = {'A09','O10','Q10','T10','G11', 'K11', 'O12', 'R12','S12', 'T12'};
%ratNames = {'T12'};
ratNumber = length(ratNames);
minTrials = 6;
wBS = [1:100];
wBT = [150:200];
wAC = [201:400];
thetaBand = [2:4];%4~8Hz
respondAC = zeros(2,2096);
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
                BSRC = mean(thetaRC(wBS,:));
                BSRR = mean(thetaRR(wBS,:));
                BSWC = mean(thetaWC(wBS,:));
                BSWR = mean(thetaWR(wBS,:));
                tBSr = [BSRC,BSRR];
                tBSw = [BSWC,BSWR];
                cBSr{nUnit} = tBSr;
                cBSw{nUnit} = tBSw;
                BTRC = mean(thetaRC(wBT,:));
                BTRR = mean(thetaRR(wBT,:));
                BTWC = mean(thetaWC(wBT,:));
                BTWR = mean(thetaWR(wBT,:));
                tBTr = [BTRC,BTRR];
                cBTr{nUnit} = tBTr;
                tBTw = [BTWC,BTWR];
                cBTw{nUnit} = tBTw;
                pr = anova1([tBSr',tBTr'],[],'off');
                if (pr<0.05)
                    respondBTr(nUnit) = 1;
                else
                    respondBTr(nUnit) = 0;
                end
                pw = anova1([tBSw',tBTw'],[],'off');
                if (pw<0.05)
                    respondBTw(nUnit) = 1;
                else
                    respondBTw(nUnit) = 0;
                end
                ACRC = mean(thetaRC(wAC,:));
                ACRR = mean(thetaRR(wAC,:));
                ACWC = mean(thetaWC(wAC,:));
                ACWR = mean(thetaWR(wAC,:));
               % tACr = [ACRC,ACRR];
                tACw = [ACWC,ACWR];
                cACrCor{nUnit} = ACRC;
                cACrRei{nUnit} = ACRR;
                cACw{nUnit} = tACw;
                group = {[ones(1,nTrialRC), 2*ones(1,(nTrialWC+nTrialWR))]};
                p2 = anovan([ACRC,tACw],group,'display','off');
                respondACCor(nUnit) = p2;
                group = {[ones(1,nTrialRR), 2*ones(1,(nTrialWC+nTrialWR))]};
                p2 = anovan([ACRR,tACw],group,'display','off');
                respondACRei(nUnit) = p2;
            else
                [date ch nTrialRC nTrialRR nTrialWC nTrialWR]
            end
            close all;
        end%ch
    end%date
end%rat
save('G:\preparedDataLFP\allUniteAllRats.mat', 'cBSr','cBSw','cBTr','cBTw','respondBTr','respondBTw','cACrCor','cACrRei','cACw','respondACCor','respondACRei');

sum(respondBTr)
sum(respondBTw)
respondACCor(find(isnan(respondACCor)))=[]           
respondACRei(find(isnan(respondACRei)))=[]
respondACCor1 = zeros(1,length(respondACCor));
respondACCor1(find(respondACCor<0.05))=1;
sum(respondACCor1)
respondACRei1 = zeros(1,length(respondACRei));
respondACRei1(find(respondACRei<0.05))=1;
sum(respondACRei1)

  