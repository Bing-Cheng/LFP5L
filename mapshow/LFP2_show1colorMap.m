close all;
clear;
disFreq = 50;

ratname = 'R12';
load(['G:\dataLFP\', ratname, '_wave\', ratname, '_blockname']);
blockname([5 16,20,46]) = [];
remD1 = [38,39,41];%remove date with trial number less than 2
blockname(remD1) = [];
kp = [1     2     3     6    10    20    21    32    34];
    remD = [1:length(blockname)];
    remD(kp) =[];
   blockname(remD) = [];
   save(['G:\preparedDataLFP\', ratname, '_blockname'],'blockname');
   colorMap500S4RW(ratname, blockname, disFreq);
   
ratname = 'O12';
load(['G:\dataLFP\', ratname, '_wave\', ratname, '_blockname']);%O12 06/18   23
blockname(23) = [];
remD1 = [21,25,27,28,29,31,32,33,34];%remove date with trial number less than 2
blockname(remD1) = [];

    remD = [1,2,3,6,7,8,13,14,15,17,19,22];

   blockname(remD) = [];
   colorMap500S4RW(ratname, blockname, disFreq);
   
ratname = 'J11';
blockname = {...%'J5L-01-04-12-A','J5L-01-05-12-A','J5L-01-09-12-A','J5L-01-11-12-A',    'J5L-01-12-12-A',
    'J5L-01-13-12-A',...
    'J5L-01-17-12-A','J5L-01-18-12-A','J5L-01-19-12-A','J5L-01-20-12-A','J5L-01-23-12-A',...
    'J5L-01-24-12-A','J5L-01-25-12-A','J5L-01-26-12-A','J5L-01-27-12-A','J5L-01-30-12-A',...
    'J5L-01-31-12-A','J5L-02-01-12-A','J5L-02-02-12-A','J5L-02-03-12-A','J5L-02-06-12-A',...
    'J5L-02-07-12-A','J5L-02-08-12-A','J5L-02-09-12-A','J5L-02-10-12-A','J5L-02-13-12-A',...
    'J5L-02-14-12-A','J5L-02-15-12-A','J5L-02-16-12-A','J5L-02-17-12-A','J5L-02-20-12-A',...
    'J5L-02-21-12-A','J5L-02-22-12-A','J5L-02-23-12-A','J5L-02-24-12-A','J5L-02-27-12-A',...
    'J5L-02-28-12-A','J5L-02-29-12-A','J5L-03-01-12-A','J5L-03-02-12-A',...
    'J5L-03-06-12-A','J5L-03-07-12-A','J5L-03-08-12-A','J5L-03-09-12-A','J5L-03-12-12-A',...
    'J5L-03-13-12-A','J5L-03-14-12-A','J5L-03-15-12-A','J5L-03-16-12-A','J5L-03-19-12-A',...
    'J5L-03-20-12-A','J5L-03-21-12-A'};
remD1 = [3 40 45 46];%remove date with trial number less than 2
blockname(remD1) = [];
kp=[1,5,13,15,19,22,24,27,40];
    remD = [1:length(blockname)];
    remD(kp) =[];
   blockname(remD) = [];
   colorMap500S4RW(ratname, blockname, disFreq);

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
   save(['G:\preparedDataLFP\', ratname, '_blockname'],'blockname');
   colorMap500S4RW(ratname, blockname, disFreq);

ratname = 'T10';
blockname ={'T5L-11-16-10-A','T5L-11-17-10-A','T5L-11-18-10-A','T5L-11-19-10-A','T5L-11-22-10-A','T5L-11-23-10-A','T5L-11-24-10-A',...
    'T5L-11-29-10-A','T5L-11-30-10-A','T5L-12-01-10-B','T5L-12-02-10-A','T5L-12-03-10-A','T5L-12-06-10-A','T5L-12-07-10-A',...
    'T5L-12-08-10-A','T5L-12-09-10-A','T5L-12-10-10-A','T5L-12-13-10-A','T5L-12-15-10-A'};
    remD = [4 6 7 9 10 12 14 15 17 18 19];
   blockname(remD) = [];
   save(['G:\preparedDataLFP\', ratname, '_blockname'],'blockname');
   colorMap500S4RW(ratname, blockname, disFreq);


ratname = 'G11';
blockname = {'G5L-09-13-11-A','G5L-09-16-11-A','G5L-09-19-11-A','G5L-09-20-11-A'};
save(['G:\preparedDataLFP\', ratname, '_blockname'],'blockname');
colorMap500S4RW(ratname, blockname, disFreq);

ratname = 'K10';
blockname = {'K5L-07-19-10-A','K5L-07-21-10-A','K5L-07-22-10-A','K5L-07-23-10-A','K5L-07-26-10-A','K5L-07-27-10-A','K5L-07-28-10-A'};

colorMap500S4RW(ratname, blockname, disFreq);

ratname = 'O10';
blockname = {'O5L-10-04-10-A','O5L-10-05-10-A','O5L-10-06-10-B','O5L-10-07-10-A','O5L-10-08-10-B','O5L-10-11-10-A'};
   selD = [1:length(blockname)];
    remD = [1];
   blockname(remD) = [];
   save(['G:\preparedDataLFP\', ratname, '_blockname'],'blockname');
colorMap500S4RW1(ratname, blockname, disFreq,'a1');


ratname = 'Q10';
blockname ={'Q5L-12-03-10-A','Q5L-12-07-10-A','Q5L-12-08-10-B','Q5L-12-09-10-A','Q5L-12-10-10-A','Q5L-01-06-11-A','Q5L-01-07-11-A',...
    'Q5L-01-10-11-B','Q5L-01-11-11-A','Q5L-01-12-11-A','Q5L-01-14-11-A','Q5L-01-18-11-A','Q5L-01-19-11-A','Q5L-01-20-11-A','Q5L-01-21-11-A','Q5L-01-24-11-A'};
   selD = [1:length(blockname)];
    remD = [1 2 4 6 7 9 12 13 15 16];
   blockname(remD) = [];
   save(['G:\preparedDataLFP\', ratname, '_blockname'],'blockname');
colorMap500S4RW(ratname, blockname, disFreq);


ratname = 'S10';
blockname = {'S5L-12-03-10-A','S5L-12-07-10-A','S5L-12-08-10-A','S5L-12-09-10-A','S5L-12-10-10-A'};
   selD = [1:length(blockname)];
    remD = [4];
   blockname(remD) = [];
colorMap500S4RW(ratname, blockname, disFreq);


ratname = 'A09';
blockname ={'A5L-08-06-09-A','A5L-08-27-09-A','A5L-08-28-09-A','A5L-08-31-09-A','A5L-09-01-09-A','A5L-09-08-09-A','A5L-09-09-09-A','A5L-09-10-09-A',...
    'A5L-09-11-09-H','A5L-09-16-09-A','A5L-09-17-09-A','A5L-09-18-09-A','A5L-09-21-09-A','A5L-09-22-09-A','A5L-09-23-09-A','A5L-09-24-09-A','A5L-09-25-09-B',...
    'A5L-09-28-09-A','A5L-09-29-09-A','A5L-09-30-09-A','A5L-09-01-09-A','A5L-10-01-09-B','A5L-10-05-09-A','A5L-10-06-09-A','A5L-10-07-09-A','A5L-10-08-09-A',...
    'A5L-10-09-09-A','A5L-10-12-09-A','A5L-10-14-09-A','A5L-10-15-09-A','A5L-10-19-09-A','A5L-10-20-09-A','A5L-10-22-09-A','A5L-10-23-09-A','A5L-10-26-09-A',...
    'A5L-10-27-09-A','A5L-10-28-09-A','A5L-10-29-09-A','A5L-10-30-09-A','A5L-11-02-09-A','A5L-11-03-09-A','A5L-11-05-09-A'};
   selD = [1:length(blockname)];
    remD = [17     6     2     7    38    23     9    22    36    14    29    16    40    39    24    37    13    18    10    35    32    21    34     4  20    31    41    15    26    27     8 ];
   selD(remD)=[];
   blockname(remD) = [];
   save(['G:\preparedDataLFP\', ratname, '_blockname'],'blockname');
colorMap500S4RW(ratname, blockname, disFreq);

ratname = 'B11';
blockname ={'B5L-04-29-11','B5L-05-05-11','B5L-05-10-11','B5L-05-16-11','B5L-05-20-11','B5L-05-26-11','B5L-05-31-11','B5L-06-01-11',...
    'B5L-06-02-11','B5L-06-03-11','B5L-06-06-11','B5L-06-07-11','B5L-06-10-11',};
colorMap500S4RW(ratname, blockname, disFreq);
