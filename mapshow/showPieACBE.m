close all;
clear;
oDir = 'D:\bcheng\work\paper\my\paper2_LFP\fig\';
A = [0.345, 0.992,0.976;0.012,0.785,0.949;0.345, 0.992-0.8,0.976;0.012,0.785-0.5,0.949];
B=hsv2rgb(A);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Pie ACr, ACw, ACrw
load('G:\preparedDataLFP\allUniteAllRatsChCorReiBE3.mat');%, 'respondBTr','respondBTw','respondACr','respondACw','respondACrw');
hPieColor = figure;
for i=1:4
    subplot(2,2,i);
    hPie = pie(10,{' '});
    set(hPie(1), 'FaceColor', B(i,:));
end
saveas(hPieColor, [oDir 'pieColor.png']);

respond = respondBE1rCor;
respond(find(respond==-1))=0;
res3p = sum(respond,2);
respond = respondBE1rCor;
respond(find(respond==1))=0;
res3n = sum(respond,2);
Y = [res3p, -res3n];
%drawPies(Y,B,[oDir 'pieBE1rCor.png']);
resBE1rCor = Y;

respond = respondBE1rRei;
respond(find(respond==-1))=0;
res3p = sum(respond,2);
respond = respondBE1rRei;
respond(find(respond==1))=0;
res3n = sum(respond,2);
Y = [res3p, -res3n];
%drawPies(Y,B,[oDir 'pieBE1rRei.png']);
resBE1rRei = Y;

resBE1r = [resBE1rCor(:,1), resBE1rRei(:,1),resBE1rCor(:,2), resBE1rRei(:,2)];
resBE1rM1 = resBE1r(2:8,:);
resBE1rM2 = resBE1r([1 9:16],:);
sdM1 = std(resBE1rM1,0,1);
sdM2 = std(resBE1rM2,0,1);
meanM1 = mean(resBE1rM1,1);
meanM2 = mean(resBE1rM2,1);
XAC = [2 3 5 6 8 9 11 12];
BEAFi= meanM1(1) + meanM2(1);
BEASi= meanM1(2) + meanM2(2);
BEAFd= meanM1(3) + meanM2(3);
BEASd= meanM1(4) + meanM2(4);
BEM1= meanM1(1)+meanM1(2) -meanM1(3)-meanM1(4);
BEM2= meanM2(1)+meanM2(2) -meanM2(3)-meanM2(4);
hAC =figure;hold on;
hBar = bar(XAC,[meanM1 meanM2]);
C = B([1 1 3 3 2 2 4 4],:);
colormap(C);
ch = get(hBar,'children');
fvd = get(ch,'Faces'); %get faces data
fvcd = get(ch,'FaceVertexCData'); %get face vertex cdata
cd=repmat(1:8,5,1);
cd=[cd(:);nan];
set(ch,'facevertexcdata',cd);
errorbar(XAC,[meanM1 meanM2],[sdM1 sdM2],'*');
set(gca,'XTick',XAC)
set(gca,'XTickLabel',{'AF' 'AS'}); 
ylim([0 12]);
saveas(hAC, [oDir 'barBE1r.png']);
 

   respond = respondBE3rCor;
respond(find(respond==-1))=0;
res3p = sum(respond,2);
respond = respondBE3rCor;
respond(find(respond==1))=0;
res3n = sum(respond,2);
Y = [res3p, -res3n];
%drawPies(Y,B,[oDir 'pieBE2rCor.png']);
resBE2rCor = Y;

respond = respondBE3rRei;
respond(find(respond==-1))=0;
res3p = sum(respond,2);
respond = respondBE3rRei;
respond(find(respond==1))=0;
res3n = sum(respond,2);
Y = [res3p, -res3n];
%drawPies(Y,B,[oDir 'pieBE2rRei.png']);
resBE2rRei = Y;

resBE2r = [resBE2rCor(:,1), resBE2rRei(:,1),resBE2rCor(:,2), resBE2rRei(:,2)];
resBE2rM1 = resBE2r(2:8,:);
resBE2rM2 = resBE2r([1 9:16],:);
sdM1 = std(resBE2rM1,0,1);
sdM2 = std(resBE2rM2,0,1);
meanM1 = mean(resBE2rM1,1);
meanM2 = mean(resBE2rM2,1);
XAC = [2 3 5 6 8 9 11 12];

hAC =figure;hold on;
hBar = bar(XAC,[meanM1 meanM2]);
C = B([1 1 3 3 2 2 4 4],:);
colormap(C);
ch = get(hBar,'children');
fvd = get(ch,'Faces'); %get faces data
fvcd = get(ch,'FaceVertexCData'); %get face vertex cdata
cd=repmat(1:8,5,1);
cd=[cd(:);nan];
set(ch,'facevertexcdata',cd);
errorbar(XAC,[meanM1 meanM2],[sdM1 sdM2],'*');
set(gca,'XTick',XAC)
set(gca,'XTickLabel',{'AF' 'AS'}); 
ylim([0 13]);
saveas(hAC, [oDir 'barBE2r.png']);

AEAFi= meanM1(1) + meanM2(1);
AEASi= meanM1(2) + meanM2(2);
AEAFd= meanM1(3) + meanM2(3);
AEASd= meanM1(4) + meanM2(4);

h= figure;
pie3([BEAFi+AEAFi BEAFd + AEAFd ],[0 1 ],{'increased','decreased'});
saveas(h, [oDir 'pieAF.png']);
h= figure;
pie3([BEASi+AEASi BEASd + AEASd ],[0 1 ],{'increased','decreased'});
saveas(h, [oDir 'pieAS.png']);

AEM1= meanM1(1)+meanM1(2) -meanM1(3)-meanM1(4);
AEM2= meanM2(1)+meanM2(2) -meanM2(3)-meanM2(4);

h= figure;
y=[BEM1 AEM1;BEM2 AEM2]+5;
bar3(y,'stacked');
saveas(h, [oDir 'plotM12.png']);