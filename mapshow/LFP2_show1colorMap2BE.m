close all;
clear;
disFreq = 50;
fileName = '_blockname';
fileNameBE = '_blocknameBE';
 sessionN = 0;
ratname = 'S12';
load(['G:\dataLFP\', ratname, '_wave\', ratname, fileName]);
blockname([27]) = [];%S12: 09/11 (17) has not enough trials;
remD = [1:10 15 23 25:27 31:33];
blockname(remD) = [];
blockname(12) = [];%09/05
save(['G:\preparedDataLFP\', ratname, fileNameBE],'blockname');
 sessionN = sessionN + length(blockname)
colorMap500S4RWBE(ratname, blockname, disFreq);
   
ratname = 'T12';
load(['G:\dataLFP\', ratname, '_wave\', ratname, fileName]);
remD = [10:15];
blockname(remD) = [];
blockname([15,20,22]) = [];%08/06, 08/14, 08/16 one of RC,RR,WC or WR has only one trial
blockname([2 3]) = [];%T12 on 07-10-12, 07-11-12
save(['G:\preparedDataLFP\', ratname, fileNameBE],'blockname');
 sessionN = sessionN + length(blockname)
colorMap500S4RWBE(ratname, blockname, disFreq);
   
ratname = 'O12';
load(['G:\dataLFP\', ratname, '_wave\', ratname, fileName]);%O12 06/18   23
blockname(23) = [];
remD1 = [21,25,27,28,29,31,32,33,34];%remove date with trial number less than 2
blockname(remD1) = [];
remD = [1,2,3,6,7,8,13];
blockname(remD) = [];
save(['G:\preparedDataLFP\', ratname, fileNameBE],'blockname');
sessionN = sessionN + length(blockname)
colorMap500S4RWBE(ratname, blockname, disFreq);
   

ratname = 'R12';
load(['G:\dataLFP\', ratname, '_wave\', ratname, fileName]);
blockname([5 16,20,46]) = [];
remD1 = [38,39,41];%remove date with trial number less than 2
blockname(remD1) = [];
kp = [1     2     3     6    10    20    21    32    34];
remD = [1:length(blockname)];
remD(kp) =[];
blockname(remD) = [];
save(['G:\preparedDataLFP\', ratname, fileNameBE],'blockname');
sessionN = sessionN + length(blockname)
colorMap500S4RWBE(ratname, blockname, disFreq);
   

ratname = 'K11';
blockname = {'K5L-01-18-12-A','K5L-01-19-12-A','K5L-01-20-12-A','K5L-01-23-12-A',...
    'K5L-01-24-12-A','K5L-01-26-12-A','K5L-01-27-12-A','K5L-01-30-12-A',...
    'K5L-01-31-12-A','K5L-02-01-12-A','K5L-02-02-12-A','K5L-02-03-12-A','K5L-02-06-12-A',...
    'K5L-02-07-12-A','K5L-02-08-12-A','K5L-02-09-12-A','K5L-02-10-12-A','K5L-02-13-12-A',...
    'K5L-02-14-12-A','K5L-02-15-12-A','K5L-02-16-12-A','K5L-02-17-12-A','K5L-02-20-12-A',...
    'K5L-02-21-12-A','K5L-02-24-12-A','K5L-02-27-12-A',...
    'K5L-02-28-12-A','K5L-02-29-12-A','K5L-03-02-12-A',...
    'K5L-03-05-12-A','K5L-03-07-12-A','K5L-03-09-12-A','K5L-03-12-12-A',...
    'K5L-03-14-12-A','K5L-03-16-12-A'};
    remD = [1 2 3 4 7 8 18 26 35];
   blockname(remD) = [];
   blockname(16) = [];%K11 on 02-20-12
   save(['G:\preparedDataLFP\', ratname, fileNameBE],'blockname');
    sessionN = sessionN + length(blockname)
   colorMap500S4RWBE(ratname, blockname, disFreq);

ratname = 'T10';
blockname ={'T5L-11-16-10-A','T5L-11-17-10-A','T5L-11-18-10-A','T5L-11-19-10-A','T5L-11-22-10-A','T5L-11-23-10-A','T5L-11-24-10-A',...
    'T5L-11-29-10-A','T5L-11-30-10-A','T5L-12-01-10-B','T5L-12-02-10-A','T5L-12-03-10-A','T5L-12-06-10-A','T5L-12-07-10-A',...
    'T5L-12-08-10-A','T5L-12-09-10-A','T5L-12-10-10-A','T5L-12-13-10-A','T5L-12-15-10-A'};
    remD = [4 6 7 9 10 12 14 15 17 18 19];
   blockname(remD) = [];
   save(['G:\preparedDataLFP\', ratname, fileNameBE],'blockname');
    sessionN = sessionN + length(blockname)
   colorMap500S4RWBE(ratname, blockname, disFreq);


ratname = 'G11';
blockname = {'G5L-09-13-11-A','G5L-09-16-11-A','G5L-09-19-11-A','G5L-09-20-11-A'};
 sessionN = sessionN + length(blockname)
save(['G:\preparedDataLFP\', ratname, fileNameBE],'blockname');
colorMap500S4RWBE(ratname, blockname, disFreq);


ratname = 'O10';
blockname = {'O5L-10-04-10-A','O5L-10-05-10-A','O5L-10-06-10-B','O5L-10-07-10-A','O5L-10-08-10-B','O5L-10-11-10-A'};
   selD = [1:length(blockname)];
    remD = [1 6];
   blockname(remD) = [];
   blockname(2) = [];%   O10 on 10-05-10, 10-06-10
   sessionN = sessionN + length(blockname)
   save(['G:\preparedDataLFP\', ratname, fileNameBE],'blockname');
colorMap500S4RWBE(ratname, blockname, disFreq);

ratname = 'Q10';
blockname ={'Q5L-12-03-10-A','Q5L-12-07-10-A','Q5L-12-08-10-B','Q5L-12-09-10-A','Q5L-12-10-10-A','Q5L-01-06-11-A','Q5L-01-07-11-A',...
    'Q5L-01-10-11-B','Q5L-01-11-11-A','Q5L-01-12-11-A','Q5L-01-14-11-A','Q5L-01-18-11-A','Q5L-01-19-11-A','Q5L-01-20-11-A','Q5L-01-21-11-A','Q5L-01-24-11-A'};
   selD = [1:length(blockname)];
    remD = [1 2 4 6 7 9 12 13 15 16];
   blockname(remD) = [];
    sessionN = sessionN + length(blockname)
   save(['G:\preparedDataLFP\', ratname, fileNameBE],'blockname');
colorMap500S4RWBE(ratname, blockname, disFreq);

ratname = 'A09';
blockname ={'A5L-08-06-09-A','A5L-08-27-09-A','A5L-08-28-09-A','A5L-08-31-09-A','A5L-09-01-09-A','A5L-09-08-09-A','A5L-09-09-09-A','A5L-09-10-09-A',...
    'A5L-09-11-09-H','A5L-09-16-09-A','A5L-09-17-09-A','A5L-09-18-09-A','A5L-09-21-09-A','A5L-09-22-09-A','A5L-09-23-09-A','A5L-09-24-09-A','A5L-09-25-09-B',...
    'A5L-09-28-09-A','A5L-09-29-09-A','A5L-09-30-09-A','A5L-09-01-09-A','A5L-10-01-09-B','A5L-10-05-09-A','A5L-10-06-09-A','A5L-10-07-09-A','A5L-10-08-09-A',...
    'A5L-10-09-09-A','A5L-10-12-09-A','A5L-10-14-09-A','A5L-10-15-09-A','A5L-10-19-09-A','A5L-10-20-09-A','A5L-10-22-09-A','A5L-10-23-09-A','A5L-10-26-09-A',...
    'A5L-10-27-09-A','A5L-10-28-09-A','A5L-10-29-09-A','A5L-10-30-09-A','A5L-11-02-09-A','A5L-11-03-09-A','A5L-11-05-09-A'};
   selD = [1:length(blockname)];
    remD = [17     6     2     7    38    23     9    22    36    14    29    16    40    39    24    ...
        37    13    18    10    35    32    21    34     1  20    31    41    15    26    27     8 ];
   %changed 4 to 1, because Tre doesn't have data 'A5L-08-06-09-A'
    selD(remD)=[];
   blockname(remD) = [];
    sessionN = sessionN + length(blockname)
   save(['G:\preparedDataLFP\', ratname, fileNameBE],'blockname');
colorMap500S4RWBE(ratname, blockname, disFreq);




