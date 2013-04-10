close all;
clear;




datatype = 'Wave';
rat = 'A5L';
blockname ={...%'A5L-08-06-09-A',
    'A5L-08-28-09-A','A5L-08-31-09-A','A5L-09-01-09-A'...
%     ,'A5L-09-08-09-A','A5L-09-09-09-A','A5L-09-10-09-A',...
%     'A5L-09-11-09-H','A5L-09-16-09-A','A5L-09-17-09-A','A5L-09-18-09-A','A5L-09-21-09-A','A5L-09-22-09-A','A5L-09-23-09-A','A5L-09-24-09-A','A5L-09-25-09-B',...
%     'A5L-09-28-09-A','A5L-09-29-09-A','A5L-09-30-09-A','A5L-10-01-09-B','A5L-10-05-09-A','A5L-10-06-09-A','A5L-10-07-09-A','A5L-10-08-09-A',...
%     'A5L-10-09-09-A','A5L-10-12-09-A','A5L-10-14-09-A','A5L-10-15-09-A','A5L-10-19-09-A','A5L-10-20-09-A','A5L-10-22-09-A','A5L-10-23-09-A','A5L-10-26-09-A',...
%     'A5L-10-27-09-A','A5L-10-28-09-A','A5L-10-29-09-A','A5L-10-30-09-A','A5L-11-02-09-A','A5L-11-03-09-A','A5L-11-05-09-A'
     };
block_ch = [1:16];

modeFlag = 1;%0:resting; 1:cue on; 2:interval;

dir = ['G:\dataLFP\A09_wave\sectionedBE2s\'];
odir =  'G:\preparedDataLFP\A09\';
windowLength = 2000;
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
indForStop = 0;
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Correction
trialNumberCorrectCorrection = length(TrialStartCorrectCorrection);
fftMatrixRCorrection = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1);
fftMatrixSumRCorrection =zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1,trialNumberCorrectCorrection);
fftPhaseRCorrection = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1);
fftPhaseSumRCorrection =zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1,trialNumberCorrectCorrection);

for i = 1:trialNumberCorrectCorrection
    oneTrial = waveCorrectCorrection(TrialStartCorrectCorrection(i) : TrialStartCorrectCorrection(i)+sampleNumber-1);
    X = double(oneTrial);
    y = filter(b1,1,X);
    y1 = resample(y,rfs,fs);% resample to 1000Hz sampling rate (1ms each sample)
    for j = 0  : (windowLength - fftLength)/slidingStep
        signal = y1(j*10+1:j*10+fftLength);
        FsingleTrialAC = fft(signal);
        tmp= abs(FsingleTrialAC(1:fftLength/2));
         fftMatrixRCorrection(:,j+1)= tmp';
         tmp1= angle(FsingleTrialAC(1:fftLength/2));
         fftPhaseRCorrection(:,j+1)= tmp1';
    end
    fSum = sum(sum(fftMatrixRCorrection));
    if fSum>0.01
        fftMatrixSumRCorrection(:,:,i) = fftMatrixRCorrection;
        fftPhaseSumRCorrection(:,:,i) = fftPhaseRCorrection;
    else
        fftMatrixSumRCorrection(:,:,i:end) = [];
        fftPhaseSumRCorrection(:,:,i:end) = [];
        indForStop = indForStop + 1
        break;
    end
end%trial

trialNumberIncorrectCorrection = length(TrialStartIncorrectCorrection);
fftMatrixWCorrection = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1);
fftMatrixSumWCorrection = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1,trialNumberIncorrectCorrection);
fftPhaseWCorrection = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1);
fftPhaseSumWCorrection = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1,trialNumberIncorrectCorrection);

for i = 1:trialNumberIncorrectCorrection
    oneTrialW = waveIncorrectCorrection(TrialStartIncorrectCorrection(i) : TrialStartIncorrectCorrection(i)+sampleNumber-1);
    XW = double(oneTrialW);
    yW = filter(b1,1,XW);
    y1W = resample(yW,rfs,fs);
    for j = 0  : (windowLength - fftLength)/slidingStep
        signal = y1W(j*10+1:j*10+fftLength);
        FsingleTrialAC = fft(signal);
        tmp= abs(FsingleTrialAC(1:fftLength/2));
        fftMatrixWCorrection(:,j+1)= tmp';
        tmp1= angle(FsingleTrialAC(1:fftLength/2));
        fftPhaseWCorrection(:,j+1)= tmp1';
    end
    fSum = sum(sum(fftMatrixWCorrection));
    if fSum>0.01
        fftMatrixSumWCorrection(:,:,i) = fftMatrixWCorrection;
        fftPhaseSumWCorrection(:,:,i) = fftPhaseWCorrection;
    else
        fftMatrixSumWCorrection(:,:,i:end) = [];
        fftPhaseSumWCorrection(:,:,i:end) = [];
        indForStop = indForStop + 1
        break;
    end
end%trial

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Reinforcement
trialNumberCorrectReinforcement = length(TrialStartCorrectReinforcement);
fftMatrixRReinforcement = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1);
fftMatrixSumRReinforcement =zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1,trialNumberCorrectReinforcement);
fftPhaseRReinforcement = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1);
fftPhaseSumRReinforcement =zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1,trialNumberCorrectReinforcement);

for i = 1:trialNumberCorrectReinforcement
    oneTrial = waveCorrectReinforcement(TrialStartCorrectReinforcement(i) : TrialStartCorrectReinforcement(i)+sampleNumber-1);
    X = double(oneTrial);
    y = filter(b1,1,X);
    y1 = resample(y,rfs,fs);% resample to 1000Hz sampling rate (1ms each sample)
    for j = 0  : (windowLength - fftLength)/slidingStep
        signal = y1(j*10+1:j*10+fftLength);
        FsingleTrialAC = fft(signal);
        tmp= abs(FsingleTrialAC(1:fftLength/2));
         fftMatrixRReinforcement(:,j+1)= tmp';
         tmp1= angle(FsingleTrialAC(1:fftLength/2));
         fftPhaseRReinforcement(:,j+1)= tmp1';
    end
    fSum = sum(sum(fftMatrixRReinforcement));
    if fSum>0.01
        fftMatrixSumRReinforcement(:,:,i) = fftMatrixRReinforcement;
        fftPhaseSumRReinforcement(:,:,i) = fftPhaseRReinforcement;
    else
        fftMatrixSumRReinforcement(:,:,i:end) = [];
        fftPhaseSumRReinforcement(:,:,i:end) = [];
        indForStop = indForStop + 1
        break;
    end
end%trial

trialNumberIncorrectReinforcement = length(TrialStartIncorrectReinforcement);
fftMatrixWReinforcement = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1);
fftMatrixSumWReinforcement = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1,trialNumberIncorrectReinforcement);
fftPhaseWReinforcement = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1);
fftPhaseSumWReinforcement = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1,trialNumberIncorrectReinforcement);

for i = 1:trialNumberIncorrectReinforcement
    oneTrialW = waveIncorrectReinforcement(TrialStartIncorrectReinforcement(i) : TrialStartIncorrectReinforcement(i)+sampleNumber-1);
    XW = double(oneTrialW);
    yW = filter(b1,1,XW);
    y1W = resample(yW,rfs,fs);
    for j = 0  : (windowLength - fftLength)/slidingStep
        signal = y1W(j*10+1:j*10+fftLength);
        FsingleTrialAC = fft(signal);
        tmp= abs(FsingleTrialAC(1:fftLength/2));
        fftMatrixWReinforcement(:,j+1)= tmp';
        tmp1= angle(FsingleTrialAC(1:fftLength/2));
        fftPhaseWReinforcement(:,j+1)= tmp1';
    end
    fSum = sum(sum(fftMatrixWReinforcement));
    if fSum>0.01
        fftMatrixSumWReinforcement(:,:,i) = fftMatrixWReinforcement;
        fftPhaseSumWReinforcement(:,:,i) = fftPhaseWReinforcement;
    else
        fftMatrixSumWReinforcement(:,:,i:end) = [];
        fftPhaseSumWReinforcement(:,:,i:end) = [];
        indForStop = indForStop + 1
        break;
    end
end%trial

% fftMatrixSum3(:,:,chI) = fftMatrixSum/trialNumberCorrect;
% fftMatrixSum3W(:,:,chI) = fftMatrixSumW/trialNumberIncorrect;
% trialNum(dateI,chI) = trialNumberCorrect;
% trialNumW(dateI,chI) = trialNumberIncorrect;
titleNa = [odir 'BEfftMatrix' rat date '-ch' int2str(chI)];
save(titleNa, 'fftMatrixSumRCorrection', 'fftMatrixSumWCorrection', 'fftPhaseSumRCorrection', 'fftPhaseSumWCorrection', ...
        'fftMatrixSumRReinforcement', 'fftMatrixSumWReinforcement', 'fftPhaseSumRReinforcement', 'fftPhaseSumWReinforcement'); 
end%ch
% titleNa = ['fftMatrix' rat date]
%title(titleNa); 
% save(titleNa, 'fftMatrixSum3', 'fftMatrixSum3W','trialNum','trialNumW'); 
end%date
    