close all;
clear;
% load carsmall
% [p,t,st] = anova1(MPG,Origin,'off');
% [c,m,h,nms] = multcompare(st,'display','off');
% [nms num2cell(m)]
% ans = 
%   'USA'     [21.1328]  [0.8814]
%   'Japan'   [31.8000]  [1.8206]
%   'Germany' [28.4444]  [2.3504]
%   'France'  [23.6667]  [4.0711]
%   'Sweden'  [22.5000]  [4.9860]
%   'Italy'   [28.0000]  [7.0513]


strength = [82 86 79 83 84 85 86 87 74 82 ...
            78 75 76 77 79 79 77 78 82 79];
alloy = {'st','st','st','st','st','st','st','st',...
         'al1','al1','al1','al1','al1','al1',...
         'al2','al2','al2','al2','al2','al2'};
[p,a,s] = anova1(strength,alloy);
[c,m,h,nms] = multcompare(s);
[nms num2cell(c)]
tmp =1;