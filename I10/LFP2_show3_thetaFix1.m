close all;
clear;
rat = 'I5L';
blockname = {'I5L-05-06-10-A','I5L-05-07-10-A','I5L-05-13-10-B','I5L-05-14-10-B','I5L-05-26-10-A',...
    'I5L-05-27-10-A','I5L-05-28-10-A','I5L-06-01-10-A','I5L-06-02-10-A','I5L-06-03-10-A','I5L-06-04-10-A','I5L-06-07-10-A',...
    'I5L-06-08-10-A','I5L-06-09-10-A','I5L-06-10-10-A','I5L-06-11-10-A','I5L-06-14-10-A','I5L-06-15-10-A','I5L-06-16-10-A',...
    'I5L-06-17-10-A','I5L-06-18-10-A','I5L-06-21-10-A','I5L-06-29-10-A','I5L-06-30-10-A','I5L-07-01-10-A',...
    'I5L-07-02-10-A','I5L-07-06-10-A','I5L-07-07-10-A','I5L-07-08-10-A','I5L-07-09-10-A'};
idir = 'H:\preparedDataLFP\I10\';
odir =  'H:\LFP5LOutput\I10\fft\';
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

    

  