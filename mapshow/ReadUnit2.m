close all;
clear;
disFreq = 50;
disTime = 551;
disMatrix = zeros(disFreq,disTime);
ratNames = {'A09','O10','Q10','T10','G11', 'J11', 'K11', 'O12', 'R12', 'T12'};
ratNumber = length(ratNames);
BT = zeros(ratNumber,2);
BS = zeros(ratNumber,2);
dBT = zeros(ratNumber,2);
dBS = zeros(ratNumber,2);
AC = zeros(ratNumber,2);
thetaBand = [2:4];%4~8Hz
FqDis = [1:25];
FqBSRa = zeros(length(FqDis),1);
            FqBSWa = zeros(FqDis,1);
            FqBTRa = zeros(FqDis,1);
            FqBTWa = zeros(FqDis,1);
            FqACRa = zeros(FqDis,1);
            FqACWa = zeros(FqDis,1);
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
            
            thetaR1 = mean(fftR1Dm(thetaBand,:)); 
            thetaW1 = mean(fftW1Dm(thetaBand,:)); 
            FqBSR = mean(fftR1Dm(FqDis,1:100),2);
            FqBSW = mean(fftW1Dm(FqDis,1:100),2);
            FqBTR = mean(fftR1Dm(FqDis,150:200),2);
            FqBTW = mean(fftW1Dm(FqDis,150:200),2);
            FqACR = mean(fftR1Dm(FqDis,201:400),2);
            FqACW = mean(fftW1Dm(FqDis,201:400),2);
            
            FqBSRa = FqBSRa + FqBSR;
            FqBSWa = FqBSWa + FqBSW;
            FqBTRa = FqBTRa + FqBTR;
            FqBTWa = FqBTWa + FqBTW;
            FqACRa = FqACRa + FqACR;
            FqACWa = FqACWa + FqACW;
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
        dBT(i,1) = mean(diff(thetaR1(150:200)));
        dBT(i,2) = mean(diff(thetaW1(150:200)));
        dBS(i,1) = mean(diff(thetaR1));
        dBS(i,2) = mean(diff(thetaW1));
end

        h = figure; hold on;
        
   x2 = [ 8.5 8.5 3.5 3.5];
   cShade = [0.95 0.9 0.9]
   yy = [ 0 3.5e+006 3.5e+006 0];
   fill(x2,yy,cShade);
  % plot(x2(2),yy(2),x2(3),yy(3),x2(4),yy(4),x2(1),yy(1),'color',[0.9 0.8 0.8]);
      
       plot(x2,yy,'color',cShade);
        XX = [1 : length(FqDis)];%-200;
        xi = 1:0.25:25; 
        XX1 = [1 :0.5 :length(FqDis)*2-1];
       h1= plot(XX1, interp1(XX,FqBSRa,xi,'spline'),'r');
       h2 = plot(XX1, interp1(XX,FqBSWa,xi,'spline'),'--r');
       h3 = plot(XX1, interp1(XX,FqBTRa,xi,'spline'),'g');
       h4 =  plot(XX1, interp1(XX,FqBTWa,xi,'spline'),'--g');
       h5 =  plot(XX1, interp1(XX,FqACRa,xi,'spline'),'b');
       h6 =  plot(XX1, interp1(XX,FqACWa,xi,'spline'),'--b');

        legend([h1 h2 h3 h4 h5 h6],'BS-SL','BS-FD','BT-SL','BT-FD','AC-SL','AC-FD');
        xlabel('Frequency (Hz)');
        titleN = ['Frequency response  '];
        title(titleN);
        saveas(h,['G:\LFP5LOutput\' titleN],'jpg');
        
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
set(gca,'YTickLabel',{'BT '; 'BS'},'FontSize',5);  %# Modify the y axis tick labels 
set(gca,'XTickLabel',{'SL' 'FD'});  %# Modify the y axis tick labels x1:learned; x2:learning
set(gca,'ZTickLabel',{' '});
set(gcf, 'Renderer', 'ZBuffer')
%view(-50,30);               %# Change the camera view 
%colorbar;                   %# Add the color bar 
ax=gca;
pos=get(gca,'pos');
set(gca,'pos',[pos(1) pos(2) pos(3) pos(4)*0.95]);
pos=get(gca,'pos');
hc=colorbar('location','eastoutside','position',[pos(1)+pos(3)+0.03 pos(2) 0.03 pos(4)],'FontSize',5);

    titleName = ['Theta power before trial start'];
    title(titleName,'FontSize',16);
    saveas(h, ['G:\LFP5LOutput\' titleName],'jpg');
    aZ = [Z(:,1);Z(:,2)]';
    g0 = ['BT';'BS'];
    g1 = repmat(g0,20,1);
    g2 = [repmat('SL',20,1);repmat('FD',20,1)];
    group = {g1;g2};
    p2 = anovan(aZ,group);
    tmp =1;
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%AC
Z(1:2:ratNumber*2-1,:) = AC;
h = figure;
hBar = bar3(Y,Z);           %# Create the bar graph 
set(hBar,{'CData'},C);      %# Add the color data 
set(gca,'YTick',Y)
set(gca,'YTickLabel',{'AC '; 'BS'},'FontSize',5);  %# Modify the y axis tick labels 
set(gca,'XTickLabel',{'SL' 'FD'});  %# Modify the y axis tick labels x1:learned; x2:learning
set(gca,'ZTickLabel',{' '});
set(gcf, 'Renderer', 'ZBuffer')
%view(-50,30);               %# Change the camera view 
ax=gca;
pos=get(gca,'pos');
set(gca,'pos',[pos(1) pos(2) pos(3) pos(4)*0.95]);
pos=get(gca,'pos');
hc=colorbar('location','eastoutside','position',[pos(1)+pos(3)+0.03 pos(2) 0.03 pos(4)],'FontSize',5);

    titleName = ['Theta power after cue on'];
    title(titleName,'FontSize',16);
    saveas(h, ['G:\LFP5LOutput\' titleName],'jpg');
    aZ = [Z(:,1);Z(:,2)]';
    g0 = ['AC';'BS'];
    g1 = repmat(g0,20,1);
    g2 = [repmat('SL',20,1);repmat('FD',20,1)];
    group = {g1;g2};
    p2 = anovan(aZ,group);
    tmp =1;
    
    
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
%     [hac,pac,ci,stats] = ttest(AC(:,1),AC(:,2))
%         [hr,pr,ci,stats] = ttest(AC(:,1),BS(:,1))
%     [hw,pw,ci,stats] = ttest(AC(:,2),BS(:,2))
%   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%BS, BT and AC
Z4 = zeros(ratNumber*4,2);
Z4(1:4:ratNumber*4-3,:) = BS;
Z4(2:4:ratNumber*4-2,:) = BT;
Z4(3:4:ratNumber*4-1,:) = AC;
BE = zeros(ratNumber,2);
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