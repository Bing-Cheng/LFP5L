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
%wBE = [25:125];
wBE1 = [1:50];
wBE2 = [51:100];
wBE3 = [101:150];
thetaBand = [2:4];%4~8Hz
respondBE2rCor = zeros(16,2000);
respondBE2rRei = zeros(16,2000);
respondBE3rCor = zeros(16,2000);
respondBE3rRei = zeros(16,2000);
nUnit = 0;
for i = 1 : ratNumber
    ratname = ratNames{i};
    rat = [ratname(1) '5L'];
    load(['G:\preparedDataLFP\', ratname, '_blocknameBE']);
    nDate = length(blockname);
    for d = 1 : nDate
        date = blockname{d};
        date([4, 13, 14]) = []
        for ch = 1 : 16
            load(['G:\preparedDataLFP\', ratname, '\BEfftMatrix', date, '-ch',int2str(ch)]);
            nTrialRC = size(fftMatrixSumRCorrection,3);
            nTrialRR = size(fftMatrixSumRReinforcement,3);
            nTrialWC = size(fftMatrixSumWCorrection,3);
            nTrialWR = size(fftMatrixSumWReinforcement,3);
            if (((nTrialRC+nTrialRR)>minTrials)&&((nTrialWC+nTrialWR)>minTrials)&&(nTrialRC>1)&&(nTrialRR>1)&&(nTrialWC>1)&&(nTrialWR>1))
                nUnit = nUnit +1;
                thetaRC = squeeze(mean(fftMatrixSumRCorrection(thetaBand,:,:)));
                thetaRR = squeeze(mean(fftMatrixSumRReinforcement(thetaBand,:,:)));
                thetaWC = squeeze(mean(fftMatrixSumWCorrection(thetaBand,:,:)));
                thetaWR = squeeze(mean(fftMatrixSumWReinforcement(thetaBand,:,:)));
 
                BE1RC = mean(thetaRC(wBE1,:));
                BE1RR = mean(thetaRR(wBE1,:));
                BE1WC = mean(thetaWC(wBE1,:));
                BE1WR = mean(thetaWR(wBE1,:));
                
                BE2RC = mean(thetaRC(wBE2,:));
                BE2RR = mean(thetaRR(wBE2,:));
                BE2WC = mean(thetaWC(wBE2,:));
                BE2WR = mean(thetaWR(wBE2,:));
                
                BE3RC = mean(thetaRC(wBE3,:));
                BE3RR = mean(thetaRR(wBE3,:));
                BE3WC = mean(thetaWC(wBE3,:));
                BE3WR = mean(thetaWR(wBE3,:));
                
          %      tACr = [ACRC,ACRR]3;
                tBE1w = [BE1WC,BE1WR];
                group1 = {[ones(1,nTrialRC), 2*ones(1,(nTrialWC+nTrialWR))]};
                p2 = anovan([BE1RC,tBE1w],group1,'display','off');
                if (p2<0.05)
                    if (mean(BE1RC)>mean(tBE1w))
                    respondBE1rCor(ch,nUnit) = 1;
                    else
                        respondBE1rCor(ch,nUnit) = -1;
                    end
                else
                    respondBE1rCor(ch,nUnit) = 0;
                end
                 group2 = {[ones(1,nTrialRR), 2*ones(1,(nTrialWC+nTrialWR))]};
                p2 = anovan([BE1RR,tBE1w],group2,'display','off');
                if (p2<0.05)
                    if (mean(BE1RR)>mean(tBE1w))
                    respondBE1rRei(ch,nUnit) = 1;
                    else
                        respondBE1rRei(ch,nUnit) = -1;
                    end
                else
                    respondBE1rRei(ch,nUnit) = 0;
                end
                
                tBE2w = [BE2WC,BE2WR];
               % group1 = {[ones(1,nTrialRC), 2*ones(1,(nTrialWC+nTrialWR))]};
                p2 = anovan([BE2RC,tBE2w],group1,'display','off');
                if (p2<0.05)
                    if (mean(BE2RC)>mean(tBE2w))
                    respondBE2rCor(ch,nUnit) = 1;
                    else
                        respondBE2rCor(ch,nUnit) = -1;
                    end
                else
                    respondBE2rCor(ch,nUnit) = 0;
                end
               %  group2 = {[ones(1,nTrialRR), 2*ones(1,(nTrialWC+nTrialWR))]};
                p2 = anovan([BE2RR,tBE2w],group2,'display','off');
                if (p2<0.05)
                    if (mean(BE2RR)>mean(tBE2w))
                    respondBE2rRei(ch,nUnit) = 1;
                    else
                        respondBE2rRei(ch,nUnit) = -1;
                    end
                else
                    respondBE2rRei(ch,nUnit) = 0;
                end
                
                tBE3w = [BE3WC,BE3WR];
                 p2 = anovan([BE3RC,tBE3w],group1,'display','off');
                if (p2<0.05)
                    if (mean(BE3RC)>mean(tBE3w))
                    respondBE3rCor(ch,nUnit) = 1;
                    else
                        respondBE3rCor(ch,nUnit) = -1;
                    end
                else
                    respondBE3rCor(ch,nUnit) = 0;
                end
                p2 = anovan([BE3RR,tBE3w],group2,'display','off');
                if (p2<0.05)
                    if (mean(BE3RR)>mean(tBE3w))
                    respondBE3rRei(ch,nUnit) = 1;
                    else
                        respondBE3rRei(ch,nUnit) = -1;
                    end
                else
                    respondBE3rRei(ch,nUnit) = 0;
                end
            else
                [ch nTrialRC nTrialRR nTrialWC nTrialWR]
            end
            
        end%ch
    end%date
end%rat
% respondBErCor = respondACrCor;
% respondBErRei = respondACrRei;
 save('G:\preparedDataLFP\allUniteAllRatsChCorReiBE3.mat', 'respondBE1rCor','respondBE1rRei','respondBE2rCor','respondBE2rRei', 'respondBE3rCor','respondBE3rRei');
respond = respondBE1rCor;
respond(find(respond==-1))=0;
res3p = sum(respond,2);
respond = respondBE1rCor;
respond(find(respond==1))=0;
res3n = sum(respond,2);
[res3p, res3n]

respond = respondBE1rRei;
respond(find(respond==-1))=0;
res3p = sum(respond,2);
respond = respondBE1rRei;
respond(find(respond==1))=0;
res3n = sum(respond,2);
[res3p, res3n]


