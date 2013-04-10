clear; 
close all; 
clc;

rat = 'O10';

rdir = ['E:\dataLFP\' rat '_wave\channel_data\'];
eDir = [rdir rat '_022312\'];
eLoc = 19;
cd(eDir);
eList = dir(eDir);
for i = 3 : length(eList)
eName = eList(i).name;
ePostFix = eName(eLoc);
if ePostFix ~= 'A'
    newName = [eName(1:eLoc-1) 'A' eName(eLoc+1:end)]
    movefile(eName, newName);
end
end

eDir = [rdir 'event\'];
eLoc = 14;
cd(eDir);
eList = dir(eDir);
for i = 3 : length(eList)
eName = eList(i).name;
ePostFix = eName(eLoc);
if ePostFix ~= 'A'
    newName = [eName(1:eLoc-1) 'A' eName(eLoc+1:end)]
    movefile(eName, newName);
end
end

cd 'D:\bcheng\work\code\LFP5L\tools';