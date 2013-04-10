close all;
clear;
oDir = 'D:\bcheng\work\paper\my\paper2_LFP\fig\';
A = [0.345, 0.992,0.976;0.012,0.785,0.949;0.345, 0.992-0.8,0.976;0.012,0.785-0.5,0.949];
B=hsv2rgb(A);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Pie ACr, ACw, ACrw
load('G:\preparedDataLFP\allUniteAllRatsCh.mat');%, 'respondBTr','respondBTw','respondACr','respondACw','respondACrw');
hPieColor = figure;
for i=1:4
    subplot(2,2,i);
    hPie = pie(1,{' '});
    set(hPie(1), 'FaceColor', B(i,:));
end
saveas(hPieColor, [oDir 'pieColor.png']);

respond = respondACr;
respond(find(respond==-1))=0;
res3p = sum(respond,2);
respond = respondACr;
respond(find(respond==1))=0;
res3n = sum(respond,2);
Y = [res3p, -res3n];
drawPies(Y,B,[oDir 'pieACr.png']);
resACr = Y;
respond = respondACw;
respond(find(respond==-1))=0;
res3p = sum(respond,2);
respond = respondACw;
respond(find(respond==1))=0;
res3n = sum(respond,2);
Y = [res3p, -res3n];
drawPies(Y,B,[oDir 'pieACw.png']);
resACw = Y;
resAC = [resACr, resACw];
resACM1 = resAC(2:8,:);
resACM2 = resAC([1 9:16],:);
sdM1 = std(resACM1,0,1);
sdM2 = std(resACM2,0,1);
meanM1 = mean(resACM1,1);
meanM2 = mean(resACM2,1);
XAC = [2 3 5 6 8 9 11 12];

hAC =figure;hold on;
hBar = bar(XAC,[meanM1 meanM2]);
C = B([1 3 1 3 2 4 2 4],:);
colormap(C);
ch = get(hBar,'children');
fvd = get(ch,'Faces'); %get faces data
fvcd = get(ch,'FaceVertexCData'); %get face vertex cdata
cd=repmat(1:8,5,1);
cd=[cd(:);nan];
set(ch,'facevertexcdata',cd);
errorbar(XAC,[meanM1 meanM2],[sdM1 sdM2],'*');
set(gca,'XTick',XAC)
set(gca,'XTickLabel',{'ID' 'DD'}); 
saveas(hAC, [oDir 'barAC.png']);
 
respond = respondACrw;
respond(find(respond==-1))=0;
res3p = sum(respond,2);
respond = respondACrw;
respond(find(respond==1))=0;
res3n = sum(respond,2);
Y = [res3p, -res3n];
drawPies(Y,B,[oDir 'pieACrw.png']);
resACrwM1 = Y(2:8,:);
resACrwM2 = Y([1 9:16],:);
sdM1 = std(resACrwM1,0,1);
sdM2 = std(resACrwM2,0,1);
meanM1 = mean(resACrwM1,1);
meanM2 = mean(resACrwM2,1);
X = [2 3 7 8 ];
hACrw =figure;hold on;
hBar = bar(X,[meanM1 meanM2]);
C = B([3 3 2 2],:);
colormap(C);
ch = get(hBar,'children');
fvd = get(ch,'Faces'); %get faces data
fvcd = get(ch,'FaceVertexCData'); %get face vertex cdata
cd=repmat(1:4,5,1);
cd=[cd(:);nan];
set(ch,'facevertexcdata',cd);
errorbar(X,[meanM1 meanM2],[sdM1 sdM2],'*');
set(gca,'XTick',X)
set(gca,'XTickLabel',{'ID' 'DD'}); 
saveas(hBar, [oDir 'barACrw.png']);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Bar BT
load('G:\preparedDataLFP\allUniteAllRatsCh.mat');%, 'respondBTr','respondBTw','respondACr','respondACw','respondACrw');

respond = respondBTr;
respond(find(respond==-1))=0;
res3p = sum(respond,2);
respond = respondBTr;
respond(find(respond==1))=0;
res3n = sum(respond,2);
resBTr = [res3p+ res3n];

respond = respondBTw;
respond(find(respond==-1))=0;
res3p = sum(respond,2);
respond = respondBTw;
respond(find(respond==1))=0;
res3n = sum(respond,2);
resBTw = [res3p+ res3n];
resBT = [resBTr, resBTw];
resBTM1 = resBT(2:8,:);
resBTM2 = resBT([1 9:16],:);
sdM1 = std(resBTM1,0,1);
sdM2 = std(resBTM2,0,1);
meanM1 = mean(resBTM1,1);
meanM2 = mean(resBTM2,1);
X = [2 3 7 8 ];

hBT =figure;hold on;
hBar = bar(X,[meanM1 meanM2]);
C = B([3 3 2 2],:);
colormap(C);
ch = get(hBar,'children');
fvd = get(ch,'Faces'); %get faces data
fvcd = get(ch,'FaceVertexCData'); %get face vertex cdata
cd=repmat(1:4,5,1);
cd=[cd(:);nan];
set(ch,'facevertexcdata',cd);
errorbar(X,[meanM1 meanM2],[sdM1 sdM2],'*');
set(gca,'XTick',X)
set(gca,'XTickLabel',{'SL' 'FD'}); 
saveas(hBar, [oDir 'barBT.png']);
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Pie Bar Cor Rei 
load('G:\preparedDataLFP\allUniteAllRatsChCorRei.mat');%, 'respondACrCor','respondACrRei');
respond = respondACrCor;
respond(find(respond==-1))=0;
res3p = sum(respond,2);
respond = respondACrCor;
respond(find(respond==1))=0;
res3n = sum(respond,2);
[res3p, res3n];
Y = [res3p, -res3n];
drawPies(Y,B,[oDir 'pieACrCor.png']);
Y1 = [res3p+res3n];
[mX,mY] = meshgrid([0:.125:9],[0:.125:3]);
mZ = zeros(size(mX))*mean(Y1);
for j= 1:8
    mZ(8,j*8) = Y1(j);
end
for j= 1:8
    mZ(16,j*8) = Y1(17-j);
end
kSize = 5;
kernel  = ones(kSize)/(kSize*kSize);
mZ1= conv2(mZ,kernel,'same');
mZ2= conv2(mZ1,kernel,'same');
mZ3= conv2(mZ2,kernel,'same');
mZ4= conv2(mZ3,kernel,'same');
mZ5= conv2(mZ4,kernel,'same');
hMesh = figure;
mesh(mX,mY,mZ5*5);
axis equal;
axis off;
saveas(hMesh,[oDir 'meshCor.png']);

respond = respondACrRei;
respond(find(respond==-1))=0;
res3p = sum(respond,2);
respond = respondACrRei;
respond(find(respond==1))=0;
res3n = sum(respond,2);
[res3p, res3n];
[res3p, res3n];
Y = [res3p, -res3n];
drawPies(Y,B,[oDir 'pieACrRei.png']);

Y1 = [res3p+res3n];
[mX,mY] = meshgrid([0:.125:9],[0:.125:3]);
mZ = zeros(size(mX))*mean(Y1);
for j= 1:8
    mZ(8,j*8) = Y1(j);
end
for j= 1:8
    mZ(16,j*8) = Y1(17-j);
end
kSize = 5;
kernel  = ones(kSize)/(kSize*kSize);
mZ1= conv2(mZ,kernel,'same');
mZ2= conv2(mZ1,kernel,'same');
mZ3= conv2(mZ2,kernel,'same');
mZ4= conv2(mZ3,kernel,'same');
mZ5= conv2(mZ4,kernel,'same');
hMesh = figure;
mesh(mX,mY,mZ5*5);
axis equal;
axis off;
saveas(hMesh,[oDir 'meshRei.png']);
    


