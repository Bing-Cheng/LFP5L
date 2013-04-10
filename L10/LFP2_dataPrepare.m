close all;
clear;




datatype = 'Wave';
rat = 'L5L';
blockname = {'L5L-06-23-10-B','L5L-06-24-10-A','L5L-06-25-10-A','L5L-06-28-10-B','L5L-06-29-10-A','L5L-06-30-10-A',...
    'L5L-07-01-10-A','L5L-07-02-10-A','L5L-07-06-10-A','L5L-07-07-10-A','L5L-07-08-10-A','L5L-07-09-10-A','L5L-07-12-10-A',...
    'L5L-07-13-10-A','L5L-07-14-10-A','L5L-07-15-10-B','L5L-07-16-10-A','L5L-07-19-10-A','L5L-07-20-10-B','L5L-07-21-10-A',...
    'L5L-07-22-10-B','L5L-07-23-10-A','L5L-07-26-10-A','L5L-07-27-10-A','L5L-07-28-10-A','L5L-07-29-10-A','L5L-07-30-10-B',...
    'L5L-08-02-10-A','L5L-08-03-10-A'};

block_ch = [1:16];

modeFlag = 1;%0:resting; 1:cue on; 2:interval;

dir = ['H:\sectionedDataLFP\L10\sectioned\'];
odir =  'H:\preparedDataLFP\L10\';
windowLength = 6000;
fftLength = 500;
fs= 24414;
rfs = 1000;
slidingStep = 10;
sampleNumber = windowLength * fs /1000;
fNumber = [0 : 2*fs/fftLength : fs];

b1 = fir1(30,1000/24414);% The cut-off frequency Wn must be between 0 < Wn < 1.0, with 1.0 
                           %corresponding to half the sample rate.
                           % cut-off at 500Hz
chN = length(block_ch);
dateN = length(blockname);
trialNum = zeros(dateN,chN);
trialNumW = zeros(dateN,chN);
for dateI = 1:dateN
fftMatrixSum3 = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1,chN); 
fftMatrixSum3W = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1,chN);
    date1 = blockname{dateI}
    date= date1(5:12);
    fin = ['_' rat '-' date '-A_channel'];
    ext = '_sec.mat';
  for chI = 1:chN  
        ch = block_ch(chI);


cb_fNameWave = [dir datatype fin int2str(ch) ext];
load(cb_fNameWave);
% figure
% plot(waveCorrect);
% figure
% plot(waveIncorrect);

trialNumberCorrect = length(TrialStartCorrect);
fftMatrix = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1);
fftMatrixSum =zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1,trialNumberCorrect);

for i = 1:trialNumberCorrect
    oneTrial = waveCorrect(TrialStartCorrect(i) : TrialStartCorrect(i)+sampleNumber-1);
    X = double(oneTrial);
    y = filter(b1,1,X);
    y1 = resample(y,rfs,fs);% resample to 1000Hz sampling rate (1ms each sample)
    for j = 0  : (windowLength - fftLength)/slidingStep
        signal = y1(j*10+1:j*10+fftLength);
        FsingleTrialAC = fft(signal);
        tmp= abs(FsingleTrialAC(1:fftLength/2));
         fftMatrix(:,j+1)= tmp';
    end
    fSum = sum(sum(fftMatrix));
    if fSum>0.01
        fftMatrixSum(:,:,i) = fftMatrix;
    else
        stop = 1
        break;
    end
end%trial

trialNumberIncorrect = length(TrialStartIncorrect);
fftMatrixW = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1);
fftMatrixSumW = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1,trialNumberIncorrect);

for i = 1:trialNumberIncorrect
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
    fSum = sum(sum(fftMatrixW));
    if fSum>0.01
        fftMatrixSumW(:,:,i) = fftMatrixW;
    else
        stop = 1
        break;
    end
end%trial

% fftMatrixSum3(:,:,chI) = fftMatrixSum/trialNumberCorrect;
% fftMatrixSum3W(:,:,chI) = fftMatrixSumW/trialNumberIncorrect;
% trialNum(dateI,chI) = trialNumberCorrect;
% trialNumW(dateI,chI) = trialNumberIncorrect;
titleNa = [odir 'fftMatrix' rat date '-ch' int2str(chI)];
save(titleNa, 'fftMatrixSum', 'fftMatrixSumW'); 
end%ch
% titleNa = ['fftMatrix' rat date]
%title(titleNa); 
% save(titleNa, 'fftMatrixSum3', 'fftMatrixSum3W','trialNum','trialNumW'); 
end%date
    