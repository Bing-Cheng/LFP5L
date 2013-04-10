clear; 
close all; 
clc;

mode = 'cueAlign';
rat = 'Q5L';
eventDir = 'E:\bcheng\work\data1\T10_5L\EventData\'; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dateW = {'12-01-10','12-02-10','12-03-10','12-06-10','12-07-10','12-08-10','12-09-10','12-10-10',...
    '12-13-10','12-16-10','12-17-10'};
dateN= length(dateW);
for i = 1 : dateN
date = dateW{i}
date1 = [date(1:2),date(4:5),date(7:8)]

fileNameLoad = [rat '-' date1 '-5Light.mat'];
fileNameSave = [rat '-' date '-5Light.mat'];
load(fileNameLoad);
save(fileNameSave,'ExpData');
end