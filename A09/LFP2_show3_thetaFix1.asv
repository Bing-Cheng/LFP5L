close all;
clear;
rat = 'A5L';
blockname ={'A5L-08-06-09-A','A5L-08-28-09-A','A5L-08-31-09-A','A5L-09-01-09-A','A5L-09-08-09-A','A5L-09-09-09-A','A5L-09-10-09-A',...
    'A5L-09-11-09-H','A5L-09-16-09-A','A5L-09-17-09-A','A5L-09-18-09-A','A5L-09-21-09-A','A5L-09-22-09-A','A5L-09-23-09-A','A5L-09-24-09-A','A5L-09-25-09-B',...
    'A5L-09-28-09-A','A5L-09-29-09-A','A5L-09-30-09-A','A5L-09-01-09-A','A5L-10-01-09-B','A5L-10-05-09-A','A5L-10-06-09-A','A5L-10-07-09-A','A5L-10-08-09-A',...
    'A5L-10-09-09-A','A5L-10-12-09-A','A5L-10-14-09-A','A5L-10-15-09-A','A5L-10-19-09-A','A5L-10-20-09-A','A5L-10-22-09-A','A5L-10-23-09-A','A5L-10-26-09-A',...
    'A5L-10-27-09-A','A5L-10-28-09-A','A5L-10-29-09-A','A5L-10-30-09-A','A5L-11-02-09-A','A5L-11-03-09-A','A5L-11-05-09-A'};
idir = 'H:\preparedDataLFP\A09\';
odir =  'H:\LFP5LOutput\A09\fft\';
windowLength = 6000;
fftLength = 500;
fs= 24414;
rfs = 1000;
slidingStep = 10;
dateN = length(blockname);
gGroup4Date = zeros(2,2,dateN);
dd=1;
for dateI = 1:dateN
    date1 = blockname{dateI}
    date= date1(5:12);

        load([rat date 'thetaChAvg']);
        h = figure; hold on;
        XX = [1 : length(thetaR1ChAvg)]-200;
        plot(XX, thetaR1ChAvg,'r');
        plot(XX, thetaR2ChAvg,'g');
        plot(XX, thetaW1ChAvg,'b');
        plot(XX, thetaW2ChAvg,'m');
        legend('R1','R2','W1','W2');
        titleN = ['Theta Power  ' rat date];
        title(titleN);
        saveas(h,[odir titleN],'jpg');
        gR1AC = mean(thetaR1ChAvg(201:400));
        gR2AC = mean(thetaR2ChAvg(201:400));
        gW1AC = mean(thetaW1ChAvg(201:400));
        gW2AC = mean(thetaW2ChAvg(201:400));

        gDateR1(dd) = gR1AC;
        gDateR2(dd) = gR2AC;
        gDateW1(dd) = gW1AC;
        gDateW2(dd) = gW2AC;
        dd= dd+1;
   
 end%date
save([rat 'tDate'], 'gDateR1', 'gDateR2', 'gDateW1', 'gDateW2');

dRW = gDateR1 + gDateR2 - gDateW1 - gDateW2;
d12 = gDateR1 - gDateR2 + gDateW1 - gDateW2;

h = figure
hold on;
plot(dRW,'r');
plot(d12,'g');
legend('RW','12');
titleN = ['Theta Power 2' rat];
    title(titleN);
    saveas(h,[odir titleN],'jpg');


h = figure
hold on;
plot(gDateR1,'r');
plot(gDateR2,'g');
plot(gDateW1,'b')
plot(gDateW2,'m')
legend('R1','R2','W1','W2');
titleN = ['Theta Power 4' rat];
    title(titleN);
    saveas(h,[odir titleN],'jpg');
    
  %  selD = [17     6     2     7    38    23     9    22    36    14    29    16];
   % remD = [1:dateN];
    remD = [17     6     2     7    38    23     9    22    36    14    29    16    40    39    24    37    13    18    10    35    32    21    34     4];
    
dRW(remD)=[];    
    h = figure
hold on;
plot(dRW,'r');

titleN = ['Theta Power 2' rat];
    title(titleN);

    

  