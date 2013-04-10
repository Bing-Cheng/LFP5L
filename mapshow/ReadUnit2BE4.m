close all;
clear;
disFreq = 50;
disTime = 551;
disMatrix = zeros(disFreq,disTime);
ratNames = {'A09','O10','Q10','T10','G11', 'S12', 'K11', 'O12', 'R12', 'T12'};
ratNumber = length(ratNames);
BE = zeros(ratNumber,2);
BT = zeros(ratNumber,2);
BS = zeros(ratNumber,2);
dBT = zeros(ratNumber,2);
dBS = zeros(ratNumber,2);
AC = zeros(ratNumber,2);
thetaBand = [2:4];%4~8Hz
FqDis = [1:25];
 wBE1 = [1:50];
  wBE2 = [51:100];
   wBE3 = [101:150];
FqBSRa = zeros(length(FqDis),1);
            FqBSWa = zeros(length(FqDis),1);
            FqBTRa = zeros(length(FqDis),1);
            FqBTWa = zeros(length(FqDis),1);
            FqACRa = zeros(length(FqDis),1);
            FqACWa = zeros(length(FqDis),1);
            FqBERa = zeros(length(FqDis),1);
            FqBEWa = zeros(length(FqDis),1);
            FqAERa = zeros(length(FqDis),1);
            FqAEWa = zeros(length(FqDis),1);
for i = 1 : ratNumber
    ratName = ratNames{i};
    rat = [ratName(1) '5L'];
    idir = ['G:\LFPelements\' ratName '\colorMap\'];
    odir = ['G:\LFP5LOutput\' ratName '\colorMap\'];
    if i<6
    load([idir rat 'fft']);%, 'fftR1Dm', 'fftW1Dm');
    
    else
    load([odir rat 'fft']);%, 'fftR1Dm', 'fftW1Dm');
       fftR1Dm = (fftR1Dmr+fftR1Dmc)/2; 
       fftW1Dm = (fftW1Dmr+fftW1Dmc)/2; 
       
    end
   
    load([odir rat 'fftBEcr']);%, 'fftR1DmcBE', 'fftW1DmcBE', 'fftR1DmrBE', 'fftW1DmrBE');
    FqBERr1 = mean(fftR1DmrBE(FqDis,wBE1),2);
    FqBEWr1 = mean(fftW1DmrBE(FqDis,wBE1),2);  
    FqBERc1 = mean(fftR1DmcBE(FqDis,wBE1),2);
    FqBEWc1 = mean(fftW1DmcBE(FqDis,wBE1),2);  
    
        FqBERr2 = mean(fftR1DmrBE(FqDis,wBE2),2);
    FqBEWr2 = mean(fftW1DmrBE(FqDis,wBE2),2);  
    FqBERc2 = mean(fftR1DmcBE(FqDis,wBE2),2);
    FqBEWc2 = mean(fftW1DmcBE(FqDis,wBE2),2); 
    
        FqBERr3 = mean(fftR1DmrBE(FqDis,wBE3),2);
    FqBEWr3 = mean(fftW1DmrBE(FqDis,wBE3),2);  
    FqBERc3 = mean(fftR1DmcBE(FqDis,wBE3),2);
    FqBEWc3 = mean(fftW1DmcBE(FqDis,wBE3),2); 

            thetaR1 = mean(fftR1Dm(thetaBand,:)); 
            thetaW1 = mean(fftW1Dm(thetaBand,:)); 
            FqBSR = mean(fftR1Dm(FqDis,1:100),2);
            FqBSW = mean(fftW1Dm(FqDis,1:100),2);
            FqBTR = mean(fftR1Dm(FqDis,150:200),2);
            FqBTW = mean(fftW1Dm(FqDis,150:200),2);
            FqACR = mean(fftR1Dm(FqDis,201:400),2);
            FqACW = mean(fftW1Dm(FqDis,201:400),2);
            if(isnan(FqBSR))
                tmp=1;
            end
            
            FqBSRa = FqBSRa + FqBSR;
            FqBSWa = FqBSWa + FqBSW;
            FqBTRa = FqBTRa + FqBTR;
            FqBTWa = FqBTWa + FqBTW;
            FqACRa = FqACRa + FqACR;
            FqACWa = FqACWa + FqACW;
            
            FqBERa = FqBERa + (FqBERc1+FqBERr1)/2;
            FqBEWa = FqBEWa + (FqBEWc1+FqBEWr1)/2;
            FqAERa = FqAERa + (FqBERc2+FqBERr2)/2;
            FqAEWa = FqAEWa + (FqBEWc2+FqBEWr2)/2;

%         h = figure; hold on;
%         XX = [1 :2: length(FqBSR)*2];%-200;
%         plot(XX, FqBSR,'r');
%         plot(XX, FqBSW,'--r');
%         plot(XX, FqBTR,'g');
%         plot(XX, FqBTW,'--g');
%         plot(XX, FqACR,'b');
%         plot(XX, FqACW,'--b');
%         legend('BS-CR','BS-FL','BT-CR','BT-FL','AC-CR','AC-FL');
%         titleN = ['Frequency response  ' ratName];
%         title(titleN);
%         saveas(h,[odir titleN],'jpg');
        
%         h = figure; hold on;
%         XX = [1 : length(thetaR1)];%-200;
%         plot(XX, thetaR1,'r','LineWidth',2);
%         plot(XX, thetaW1,'g','LineWidth',2);
%         legend('CR','FL');
%         titleN = ['Theta Power  ' ratName];
%         title(titleN);
%         saveas(h,[odir titleN],'jpg');
        
        BT(i,1) = mean(thetaR1(150:200));
        BT(i,2) = mean(thetaW1(150:200));
        BS(i,1) = mean(thetaR1(1:100));
        BS(i,2) = mean(thetaW1(1:100));
        AC(i,1) = mean(thetaR1(200:400));
        AC(i,2) = mean(thetaW1(200:400));

        BERc1(i) = mean(FqBERc1(thetaBand));
        BERr1(i) = mean(FqBERr1(thetaBand));
        BEWc1(i) = mean(FqBEWc1(thetaBand));
        BEWr1(i) = mean(FqBEWr1(thetaBand));
        
                BERc2(i) = mean(FqBERc2(thetaBand));
        BERr2(i) = mean(FqBERr2(thetaBand));
        BEWc2(i) = mean(FqBEWc2(thetaBand));
        BEWr2(i) = mean(FqBEWr2(thetaBand));
        
                BERc3(i) = mean(FqBERc3(thetaBand));
        BERr3(i) = mean(FqBERr3(thetaBand));
        BEWc3(i) = mean(FqBEWc3(thetaBand));
        BEWr3(i) = mean(FqBEWr3(thetaBand));
        
        dBT(i,1) = mean(diff(thetaR1(150:200)));
        dBT(i,2) = mean(diff(thetaW1(150:200)));
        dBS(i,1) = mean(diff(thetaR1));
        dBS(i,2) = mean(diff(thetaW1));
end
BSR = BS(:,1);
BSW = BS(:,2);
save('G:\LFP5LOutput\BE3.mat','BERc1','BERr1','BEWc1','BEWr1','BERc2','BERr2','BEWc2','BEWr2','BERc3','BERr3','BEWc3','BEWr3','BSR','BSW');
BSBE123 = zeros(2,7);
BSBE123(1,1) = mean(BSR);
BSBE123(2,1) = mean(BSW);
BSBE123(1,2) = mean([BERc1]);
BSBE123(2,2) = mean([BEWc1 ]);
BSBE123(1,3) = mean([BERc2 ]);
BSBE123(2,3) = mean([BEWc2 ]);
BSBE123(1,4) = mean([BERc3 ]);
BSBE123(2,4) = mean([BEWc3 ]);
BSBE123(1,5) = mean([ BERr1]);
BSBE123(2,5) = mean([ BEWr1]);
BSBE123(1,6) = mean([ BERr2]);
BSBE123(2,6) = mean([ BEWr2]);
BSBE123(1,7) = mean([ BERr3]);
BSBE123(2,7) = mean([ BEWr3]);
 [hr,pr,ci,stats] = ttest(BERc2+BERr2,BERc1+BERr1)
         h = figure; hold on;
        bar(BSBE123);
        
                h = figure; hold on;
        
%    x2 = [ 8.5 8.5 3.5 3.5];
%    cShade = [0.95 0.9 0.9]
%    yy = [ 0 3.5e+005 3.5e+005 0];
%    fill(x2,yy,cShade);
  % plot(x2(2),yy(2),x2(3),yy(3),x2(4),yy(4),x2(1),yy(1),'color',[0.9 0.8 0.8]);
      
%       plot(x2,yy,'color',cShade);
        XX = [1 : length(FqDis)];%-200;
        xi = 1:0.25:25; 
        XX1 = [1 :0.5 :length(FqDis)*2-1];
       h1= plot(XX1, interp1(XX,(FqBSRa+FqBSWa)/20,xi,'spline'),'k');
       h2= plot(XX1, interp1(XX,(FqBTRa+FqBTWa)/20,xi,'spline'),'r');
       h3= plot(XX1, interp1(XX,(FqACRa+FqACWa)/20,xi,'spline'),'g');
       h4= plot(XX1, interp1(XX,(FqBERa+FqBEWa)/20,xi,'spline'),'c');
       h5= plot(XX1, interp1(XX,(FqAERa+FqAEWa)/20,xi,'spline'),'b');


        legend([h1 h2 h3 h4 h5],'BS','BC','AC','BE','AE');
        xlabel('Frequency (Hz)');
        titleN = ['Frequency response  '];
        title(titleN);
        saveas(h,['D:\bcheng\work\paper\my\paper2_LFP\fig\' titleN],'jpg');
        
Z = zeros(ratNumber*2,2);
Z(2:2:ratNumber*2,:) = BS;
Z(1:2:ratNumber*2-1,:) = BT;
%Z= Z2';
%ZW=Z;
  h = figure;

[r,c] = size(Z);            %# Size of Z 
Y = [1 2 5 6 9 10 13 14 17 18 21 22 25 26 29 30 33 34 37 38];  %# The positions of bars along the y axis 
C = mat2cell(kron(Z,ones(6,4)),6*r,4.*ones(1,c)).';  %'# Color data for Z 
 
hBar = bar3(Y,Z);           %# Create the bar graph 
set(hBar,{'CData'},C);      %# Add the color data 
tickInc = zeros(1,20);
%tickInc(2:2:20)=0.5;
yTick = Y+tickInc;
set(gca,'YTick',yTick)
%yLabelPosition = get(gca,'YTickLabel','Position');
set(gca,'YTickLabel',{'BC '; '   BS'},'FontSize',5);  %# Modify the y axis tick labels 
set(gca,'XTickLabel',{'SL' 'FD'});  %# Modify the y axis tick labels x1:learned; x2:learning
set(gca,'ZTickLabel',{' '});
set(gcf, 'Renderer', 'ZBuffer')
view(-70,30);               %# Change the camera view 
%colorbar;                   %# Add the color bar 
ax=gca;
pos=get(gca,'pos');
set(gca,'pos',[pos(1) pos(2) pos(3) pos(4)*0.95]);
pos=get(gca,'pos');
hc=colorbar('location','eastoutside','position',[pos(1)+pos(3)+0.03 pos(2) 0.03 pos(4)],'FontSize',5);

    titleName = ['Theta power before cue on'];
    title(titleName,'FontSize',16);
    saveas(h, ['D:\bcheng\work\paper\my\paper2_LFP\fig\' titleName],'jpg');
    aZ = [Z(:,1);Z(:,2)]';
    g0 = ['BC';'BS'];
    g1 = repmat(g0,20,1);
    g2 = [repmat('SL',20,1);repmat('FD',20,1)];
    group = {g1;g2};
    p2 = anovan(aZ,group);
    tmp =1;
    
    
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%AC
% Z(1:2:ratNumber*2-1,:) = AC;
% h = figure;
% hBar = bar3(Y,Z);           %# Create the bar graph 
% set(hBar,{'CData'},C);      %# Add the color data 
% set(gca,'YTick',Y)
% set(gca,'YTickLabel',{'AC '; 'BS'},'FontSize',5);  %# Modify the y axis tick labels 
% set(gca,'XTickLabel',{'SL' 'FD'});  %# Modify the y axis tick labels x1:learned; x2:learning
% set(gca,'ZTickLabel',{' '});
% set(gcf, 'Renderer', 'ZBuffer')
% %view(-50,30);               %# Change the camera view 
% ax=gca;
% pos=get(gca,'pos');
% set(gca,'pos',[pos(1) pos(2) pos(3) pos(4)*0.95]);
% pos=get(gca,'pos');
% hc=colorbar('location','eastoutside','position',[pos(1)+pos(3)+0.03 pos(2) 0.03 pos(4)],'FontSize',5);
% 
%     titleName = ['Theta power after cue on'];
%     title(titleName,'FontSize',16);
%     saveas(h, ['G:\LFP5LOutput\' titleName],'jpg');
%     aZ = [Z(:,1);Z(:,2)]';
%     g0 = ['AC';'BS'];
%     g1 = repmat(g0,20,1);
%     g2 = [repmat('SL',20,1);repmat('FD',20,1)];
%     group = {g1;g2};
%     p2 = anovan(aZ,group);
%     tmp =1;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%AC

h = figure;
bar(AC);           %# Create the bar graph 
legend('SL','FD');

    titleName = ['Theta power after cue on'];
    title(titleName,'FontSize',16);
    saveas(h, ['D:\bcheng\work\paper\my\paper2_LFP\fig\' titleName],'jpg');

    
%     
% Z(2:2:ratNumber*2,:) = dBS;
% Z(1:2:ratNumber*2-1,:) = dBT;
% h = figure;
% [r,c] = size(Z);            %# Size of Z 
% Y = [1 2 5 6 9 10 13 14 17 18];  %# The positions of bars along the y axis 
% C = mat2cell(kron(Z,ones(6,4)),6*r,4.*ones(1,c)).';  %'# Color data for Z 
% hBar = bar3(Y,Z);           %# Create the bar graph 
% set(hBar,{'CData'},C);      %# Add the color data 
% set(gca,'YTickLabel',{'BT' 'BS'},'FontSize',8);  %# Modify the y axis tick labels 
% set(gca,'XTickLabel',{'CR' 'FL'});  %# Modify the y axis tick labels x1:learned; x2:learning
% set(gcf, 'Renderer', 'ZBuffer')
% view(-70,30);               %# Change the camera view 
% %colorbar;                   %# Add the color bar 
% ax=gca;
% pos=get(gca,'pos');
% set(gca,'pos',[pos(1) pos(2) pos(3) pos(4)*0.95]);
% pos=get(gca,'pos');
% hc=colorbar('location','eastoutside','position',[pos(1)+pos(3)+0.03 pos(2) 0.03 pos(4)]);
%     titleName = ['The first derivative of the theta power'];
%  %   title(titleName,'FontSize',16);
%    saveas(h, ['G:\LFP5LOutput\' titleName],'jpg');
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Bar    
% h = figure;
% hBar = bar(AC);           %# Create the bar graph 
% legend('CR','FL');
%     titleName = ['Theta power after trial start'];
%  %   title(titleName,'FontSize',16);
%     saveas(h, ['G:\LFP5LOutput\' titleName],'jpg');
%     
%     h = figure;
% hBar = bar([mean(BT,2),mean(BS,2)]);           %# Create the bar graph 
% legend('BT','BS');
%     titleName = ['BT to BS'];
%  %   title(titleName,'FontSize',16);
%     saveas(h, ['G:\LFP5LOutput\' titleName],'jpg');
%     
%     
%     [hr,pBT,ci,stats] = ttest(mean(BT,2),mean(BS,2))
%     [hr,pr,ci,stats] = ttest(BT(:,1),BS(:,1))
%     [hw,pw,ci,stats] = ttest(BT(:,2),BS(:,2))
%     [hw,prw,ci,stats] = ttest(BT(:,1),BT(:,2))
%     [hrd,prd,ci,stats] = ttest(dBT(:,1),dBS(:,1))
%     [hwd,pwd,ci,stats] = ttest(dBT(:,2),dBS(:,2))
     [hac,pac,ci,stats] = ttest(AC(:,1),AC(:,2))
%         [hr,pr,ci,stats] = ttest(AC(:,1),BS(:,1))
%     [hw,pw,ci,stats] = ttest(AC(:,2),BS(:,2))
%   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%BS, BT and AC
Z4 = zeros(ratNumber*4,2);
Z4(1:4:ratNumber*4-3,:) = BS;
Z4(2:4:ratNumber*4-2,:) = BT;
Z4(3:4:ratNumber*4-1,:) = AC;
%BE = zeros(ratNumber,2);
Z4(4:4:ratNumber*4-0,:) = BE;
h = figure;
[r,c] = size(Z4);            %# Size of Z 
Y4 = [1: ratNumber*6];  %# The positions of bars along the y axis 
rm1 = [5:6:ratNumber*6-1];
rm2 = [6:6:ratNumber*6-0];
rm3 = [rm1 rm2];
Y4(rm3)=[];
C = mat2cell(kron(Z4,ones(6,4)),6*r,4.*ones(1,c)).'; 
hBar = bar3(Y4,Z4);           %# Create the bar graph 
set(hBar,{'CData'},C);      %# Add the color data 
set(gca,'YTick',Y4)
set(gca,'YTickLabel',{'BS'; 'BT';'AC'; 'BE'},'FontSize',5);  %# Modify the y axis tick labels 
set(gca,'XTickLabel',{'SL' 'FD'});  %# Modify the y axis tick labels x1:learned; x2:learning
set(gca,'ZTickLabel',{' '});
set(gcf, 'Renderer', 'ZBuffer')
view(-50,30);               %# Change the camera view 
ax=gca;
pos=get(gca,'pos');
set(gca,'pos',[pos(1) pos(2) pos(3) pos(4)*0.95]);
pos=get(gca,'pos');
hc=colorbar('location','eastoutside','position',[pos(1)+pos(3)+0.03 pos(2) 0.03 pos(4)],'FontSize',5);

    titleName = ['Theta power in four windows'];
    title(titleName,'FontSize',16);
    saveas(h, ['G:\LFP5LOutput\' titleName],'jpg');
%     aZ = [Z(:,1);Z(:,2)]';
%     g0 = ['AC';'BS'];
%     g1 = repmat(g0,20,1);
%     g2 = [repmat('SL',20,1);repmat('FD',20,1)];
%     group = {g1;g2};
%     p2 = anovan(aZ,group);
%     tmp =1;

% [hbe,pbe,ci,stats] = ttest(BE(:,1),BE(:,2))
% [hber,pber,ci,stats] = ttest(BERc,BERr)
%     aZ = [BERc,BERr,BEWc,BEWr]';
%     g1 = [repmat('CN',10,1);repmat('RT',10,1);repmat('CN',10,1);repmat('RT',10,1)];
%     g2 = [repmat('SL',20,1);repmat('FD',20,1)];
%     group = {g1;g2};
%     p2 = anovan(aZ,group);