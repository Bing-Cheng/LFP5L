clear; 
close all; 
clc;

rat = 'O12';

eDir = ['E:\' rat '\' rat '_5L\'];
eList = dir(eDir);
eLoc = 14;
blockName = {};
for i = 3 : length(eList)
eName = eList(i).name;
ePostFix = eName(eLoc);
if ePostFix == 'A'
    blockName = [blockName, eName];
  
end
end
blockName

