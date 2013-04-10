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
respondACrw = zeros(16,2000);
respondBTr = zeros(16,2000);
respondBTw = zeros(16,2000);
respondACr = zeros(16,2000);
respondACw = zeros(16,2000);
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
            if (((nTrialRC+nTrialRR)>minTrials)&&((nTrialWC+nTrialWR)>minTrials)&&(nTrialRC>0)&&(nTrialRR>0)&&(nTrialWC>0)&&(nTrialWR>0))
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
                    if (mean(tBTr)>mean(tBSr))
                    respondBTr(ch,nUnit) = 1;
                    else
                        respondBTr(ch,nUnit) = -1;
                    end
                else
                    respondBTr(ch,nUnit) = 0;
                end
                pw = anova1([tBSw',tBTw'],[],'off');
                if (pw<0.05)
                    if (mean(tBTw)>mean(tBSw))
                    respondBTw(ch,nUnit) = 1;
                    else
                        respondBTw(ch,nUnit) = -1;
                    end
                else
                    respondBTw(ch, nUnit) = 0;
                end
                ACRC = mean(thetaRC(wAC,:));
                ACRR = mean(thetaRR(wAC,:));
                ACWC = mean(thetaWC(wAC,:));
                ACWR = mean(thetaWR(wAC,:));
                tACr = [ACRC,ACRR];
                tACw = [ACWC,ACWR];
                pr = anova1([tBSr',tACr'],[],'off');
                if (pr<0.05)
                    if (mean(tACr)>mean(tBSr))
                    respondACr(ch,nUnit) = 1;
                    else
                        respondACr(ch,nUnit) = -1;
                    end
                else
                    respondACr(ch,nUnit) = 0;
                end
                pw = anova1([tBSw',tACw'],[],'off');
                if (pw<0.05)
                    if (mean(tACw)>mean(tBSw))
                    respondACw(ch,nUnit) = 1;
                    else
                        respondACw(ch,nUnit) = -1;
                    end
                else
                    respondACw(ch, nUnit) = 0;
                end
                % pr = anova1([tACr',tACw'],[],'off');
                 group = {[ones(1,nTrialRC+nTrialRR), 2*ones(1,(nTrialWC+nTrialWR))]};
                p2 = anovan([tACr,tACw],group,'display','off');
                if (p2<0.05)
                    if (mean(tACr)>mean(tACw))
                    respondACrw(ch,nUnit) = 1;
                    else
                        respondACrw(ch,nUnit) = -1;
                    end
                else
                    respondACrw(ch,nUnit) = 0;
                end
                
            else
                [date ch nTrialRC nTrialRR nTrialWC nTrialWR]
            end
            ch
        end%ch
    end%date
end%rat
save('G:\preparedDataLFP\allUniteAllRatsCh.mat', 'respondBTr','respondBTw','respondACr','respondACw','respondACrw');
respond = respondBTr;
respond(find(respond==-1))=0;
res3p = sum(respond,2);
respond = respondBTr;
respond(find(respond==1))=0;
res3n = sum(respond,2);
[res3p, res3n]-55

respond = respondBTw;
respond(find(respond==-1))=0;
res3p = sum(respond,2);
respond = respondBTw;
respond(find(respond==1))=0;
res3n = sum(respond,2);
[res3p, res3n]-55



respond = respondACr;
respond(find(respond==-1))=0;
res3p = sum(respond,2);
respond = respondACr;
respond(find(respond==1))=0;
res3n = sum(respond,2);
Y = [res3p, -res3n]
bar3(Y,'stack');
view(75,30);
resT = [res3p- res3n];
[resT(1:8) resT(9:16)]/2
resTa =(-res3n./resT)*360;
[resTa(1:8) resTa(9:16)]

respond = respondACw;
respond(find(respond==-1))=0;
res3p = sum(respond,2);
respond = respondACw;
respond(find(respond==1))=0;
res3n = sum(respond,2);
[res3p, res3n]




respond = respondACrw;
respond(find(respond==-1))=0;
res3p = sum(respond,2);
respond = respondACrw;
respond(find(respond==1))=0;
res3n = sum(respond,2);
[res3p, res3n]


  