close all;
clear;




datatype = 'Wave';
rat = 'B5L';
block_date = {'04-29-11','05-05-11','05-10-11','05-16-11','05-20-11','05-26-11','05-31-11','06-01-11',...
    '06-02-11','06-03-11','06-06-11','06-07-11','06-10-11',};
block_ch = [1:16];

modeFlag = 1;%0:resting; 1:cue on; 2:interval;

dir = ['E:\lfpsectioned1\'];

windowLength = 6000;
fftLength = 500;
fs= 24414;
rfs = 1000;
slidingStep = 10;
b1 = fir1(30,1000/24414);
chN = length(block_ch);
dateN = length(block_date);

for dateI = 1:dateN
fftMatrixSum3 = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1,chN);    
  for chI = 1:chN  
        ch = block_ch(chI);
    date = block_date{dateI};

    fin = ['_' rat '-' date '-A_channel'];
    ext = '_sec.mat';

cb_fNameEsig = [dir datatype fin int2str(ch) ext];
load(cb_fNameEsig);

sampleNumber = windowLength * fs /1000;
fNumber = [0 : 2*fs/fftLength : fs];

fftMatrix = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1);
fftMatrixSum = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1);
trialNumberCorrect = length(TrialStartCorrect);
singleTrialAC = zeros(sampleNumber,trialNumberCorrect);
for i = 1:length(TrialStartCorrect)
    oneTrial = waveCorrect(TrialStartCorrect(i) : TrialStartCorrect(i)+sampleNumber-1);
    X = double(oneTrial);
    y = filter(b1,1,X);
    y1 = resample(y,rfs,fs);
    for j = 0  : (windowLength - fftLength)/slidingStep
        signal = y1(j*10+1:j*10+fftLength);
        FsingleTrialAC = fft(signal);
        tmp= abs(FsingleTrialAC(1:fftLength/2));
         fftMatrix(:,j+1)= tmp';
    end
fftMatrixSum = fftMatrixSum + fftMatrix;
end%trial

fftMatrixW = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1);
fftMatrixSumW = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1);
trialNumberIncorrect = length(TrialStartIncorrect);
singleTrialAC = zeros(sampleNumber,trialNumberIncorrect);
for i = 1:length(TrialStartIncorrect)
    oneTrialW = waveIncorrect(TrialStartIncorrect(i) : TrialStartIncorrect(i)+sampleNumber-1);
    XW = double(oneTrialW);
    yW = filter(b1,1,XW);
    y1W = resample(yW,rfs,fs);
    for j = 0  : (windowLength - fftLength)/slidingStep
        signal = y1W(j*10+1:j*10+fftLength);
        FsingleTrialAC = fft(signal);
        tmp= abs(FsingleTrialAC(1:fftLength/2));
        fftMatrixW(:,j+1)= tmp';
    end
fftMatrixSumW = fftMatrixSumW + fftMatrixW;
end%trial

fftMatrixSum3(:,:,chI) = fftMatrixSum;
fftMatrixSum3W(:,:,chI) = fftMatrixSumW;
end%ch
titleNa = ['correct' rat date]
%title(titleNa); 
save(titleNa, 'fftMatrixSum', 'fftMatrixSumW'); 
end%date
    