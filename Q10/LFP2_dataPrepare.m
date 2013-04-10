close all;
clear;




datatype = 'Wave';
rat = 'Q5L';
%'Q5L-12-03-10-A'     only this day's data is short, others are float
blockname = {'Q5L-12-07-10-A','Q5L-12-08-10-B','Q5L-12-09-10-A','Q5L-12-10-10-A','Q5L-01-06-11-A','Q5L-01-07-11-A',...
    'Q5L-01-10-11-B','Q5L-01-11-11-A','Q5L-01-12-11-A','Q5L-01-14-11-A','Q5L-01-18-11-A','Q5L-01-19-11-A','Q5L-01-20-11-A','Q5L-01-21-11-A','Q5L-01-24-11-A'};


block_ch = [1:16];

modeFlag = 1;%0:resting; 1:cue on; 2:interval;

dir = ['H:\sectionedDataLFP\Q10\sectioned\'];
odir =  'H:\preparedDataLFP\Q10\';
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
forFloat = 32767000;
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
fftPhase = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1);
fftPhaseSum =zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1,trialNumberCorrect);
k=1;
for i = 1:trialNumberCorrect
    oneTrial = waveCorrect(TrialStartCorrect(i) : TrialStartCorrect(i)+sampleNumber-1);
    Xs = sort(oneTrial);
    if (Xs(11)>-0.001 & Xs(end-10)<0.001)%remove bad trials
        X = double(oneTrial*forFloat);
        y = filter(b1,1,X);
        y1 = resample(y,rfs,fs);% resample to 1000Hz sampling rate (1ms each sample)
        for j = 0  : (windowLength - fftLength)/slidingStep
            signal = y1(j*10+1:j*10+fftLength);
            FsingleTrialAC = fft(signal);
            tmp= abs(FsingleTrialAC(1:fftLength/2));
             fftMatrix(:,j+1)= tmp';
             tmp1= angle(FsingleTrialAC(1:fftLength/2));
         fftPhase(:,j+1)= tmp1';
        end
        fSum = sum(sum(fftMatrix));
        if fSum>0.01
            fftMatrixSum(:,:,k) = fftMatrix;
            fftPhaseSum(:,:,k) = fftPhase;
            k= k +1;
        else
            stop = 1
            break;
        end
    else
        Xs(11);
        Xs(end-10);
    end
        
end%trial
fftMatrixSum(:,:,[k:trialNumberCorrect]) = [];

trialNumberIncorrect = length(TrialStartIncorrect);
fftMatrixW = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1);
fftMatrixSumW = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1,trialNumberIncorrect);
fftPhaseW = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1);
fftPhaseSumW = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1,trialNumberIncorrect);
k=1;
for i = 1:trialNumberIncorrect
    oneTrialW = waveIncorrect(TrialStartIncorrect(i) : TrialStartIncorrect(i)+sampleNumber-1);
    XsW = sort(oneTrialW);
    if (XsW(11)>-0.001 & XsW(end-10)<0.001)
        XW = double(oneTrialW*forFloat);
        yW = filter(b1,1,XW);
        y1W = resample(yW,rfs,fs);
        for j = 0  : (windowLength - fftLength)/slidingStep
            signal = y1W(j*10+1:j*10+fftLength);
            FsingleTrialAC = fft(signal);
            tmp= abs(FsingleTrialAC(1:fftLength/2));
            fftMatrixW(:,j+1)= tmp';
             tmp1= angle(FsingleTrialAC(1:fftLength/2));
        fftPhaseW(:,j+1)= tmp1';
        end
        fSum = sum(sum(fftMatrixW));
        if fSum>0.01
            fftMatrixSumW(:,:,k) = fftMatrixW;
            fftPhaseSumW(:,:,k) = fftPhaseW;
            k= k+1;
        else
            stop = 1
            break;
        end
    else
        XsW(11);
        XsW(end-10);
    end
end%trial
fftMatrixSumW(:,:,[k:trialNumberIncorrect]) = [];
% fftMatrixSum3(:,:,chI) = fftMatrixSum/trialNumberCorrect;
% fftMatrixSum3W(:,:,chI) = fftMatrixSumW/trialNumberIncorrect;
% trialNum(dateI,chI) = trialNumberCorrect;
% trialNumW(dateI,chI) = trialNumberIncorrect;
titleNa = [odir 'fftMatrix' rat date '-ch' int2str(chI)];
save(titleNa, 'fftMatrixSum', 'fftMatrixSumW', 'fftPhaseSum', 'fftPhaseSumW'); 
end%ch
% titleNa = ['fftMatrix' rat date]
%title(titleNa); 
% save(titleNa, 'fftMatrixSum3', 'fftMatrixSum3W','trialNum','trialNumW'); 
end%date
    