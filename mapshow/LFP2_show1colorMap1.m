close all;
clear;
disFreq = 50;

ratname = 'S12';
load(['G:\dataLFP\', ratname, '_wave\', ratname, '_blockname']);
blockname([27]) = [];%S12: 09/11 (17) has not enough trials;
remD = [1:10 15 23 25:27 31:33];
blockname(remD) = [];
blockname([12:17]) = [];%09/05
save(['G:\preparedDataLFP\', ratname, '_blockname'],'blockname');
colorMap500S4RW(ratname, blockname, disFreq);
   
ratname = 'T12';
load(['G:\dataLFP\', ratname, '_wave\', ratname, '_blockname']);
remD = [10:15];
blockname(remD) = [];
blockname([15,20,22]) = [];%08/06, 08/14, 08/16 one of RC,RR,WC or WR has only one trial
save(['G:\preparedDataLFP\', ratname, '_blockname'],'blockname');
colorMap500S4RW1(ratname, blockname, disFreq);
   
ratname = 'O12';
load(['G:\dataLFP\', ratname, '_wave\', ratname, '_blockname']);%O12 06/18   23
blockname(23) = [];
remD = [1:8];
blockname(remD) = [];
blockname([19,23]) = [];%06/25, 06/29
save(['G:\preparedDataLFP\', ratname, '_blockname'],'blockname');
colorMap500S4RW1(ratname, blockname, disFreq);
   
ratName = 'K11';
blockname = {'K5L-01-18-12-A','K5L-01-19-12-A','K5L-01-20-12-A','K5L-01-23-12-A',...
    'K5L-01-24-12-A','K5L-01-26-12-A','K5L-01-27-12-A','K5L-01-30-12-A',...
    'K5L-01-31-12-A','K5L-02-01-12-A','K5L-02-02-12-A','K5L-02-03-12-A','K5L-02-06-12-A',...
    'K5L-02-07-12-A','K5L-02-08-12-A','K5L-02-09-12-A','K5L-02-10-12-A','K5L-02-13-12-A',...
    'K5L-02-14-12-A','K5L-02-15-12-A','K5L-02-16-12-A','K5L-02-17-12-A','K5L-02-20-12-A',...
    'K5L-02-21-12-A','K5L-02-24-12-A','K5L-02-27-12-A',...
    'K5L-02-28-12-A','K5L-02-29-12-A','K5L-03-02-12-A',...
    'K5L-03-05-12-A','K5L-03-07-12-A','K5L-03-09-12-A','K5L-03-12-12-A',...
    'K5L-03-14-12-A','K5L-03-16-12-A'};
    remD = [1:4 7 8 15:19 26 34 35];
   blockname(remD) = [];
   colorMap500S4RW1(ratName, blockname, disFreq);

