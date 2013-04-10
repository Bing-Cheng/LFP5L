close all;
clear;




datatype = 'Wave';
rat = 'B5L';

% float:  
%blockname ={'R5L-12-14-10-B'};
forFloat = 32767000;
%Short:
     blockname ={'B5L-04-29-11','B5L-05-05-11','B5L-05-10-11','B5L-05-16-11','B5L-05-20-11','B5L-05-26-11','B5L-05-31-11','B5L-06-01-11',...
    'B5L-06-02-11','B5L-06-03-11','B5L-06-06-11','B5L-06-07-11','B5L-06-10-11',};

block_ch = [1:16];
odir =  'H:\LFP5LOutput\B11\trialWave\';
modeFlag = 1;%0:resting; 1:cue on; 2:interval;

dir = ['H:\sectionedDataLFP\B11\sectioned\'];

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
cc = colormap(Lines);
scale = 1000;
trialNumberCorrect = length(TrialStartCorrect);
fftMatrix = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1);
fftMatrixSum =zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1,trialNumberCorrect);
k = 0; 
fig = 1;
    h = figure(fig);
    hold on;
for i = 1:trialNumberCorrect
    k = k+1;
    if k>7
       
        titleName = [rat '-' date '-ch' int2str(chI) 'Correct-' int2str(trialNumberCorrect)  '-' int2str(fig) '-' int2str(k)];
            title(titleName);
            saveas(h,[odir titleName],'jpg');
         k=1;
         fig = fig +1;
            h = figure(fig);
    hold on;
    end
    oneTrial = waveCorrect(TrialStartCorrect(i) : TrialStartCorrect(i)+sampleNumber-1);
    X = double(oneTrial*forFloat);
    y = filter(b1,1,X);
    y1 = resample(y,rfs,fs);% resample to 1000Hz sampling rate (1ms each sample)

    plot(y1/scale+k*50,'color',cc(k,:))
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
    end
end%trial

trialNumberIncorrect = length(TrialStartIncorrect);
fftMatrixW = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1);
fftMatrixSumW = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1,trialNumberIncorrect);

        titleName = [rat '-' date '-ch' int2str(chI) 'Correct-' int2str(trialNumberCorrect) '-' int2str(fig) '-' int2str(k)];
            title(titleName);
            saveas(h,[odir titleName],'jpg');
        fig = fig +1;
            h = figure(fig);
    hold on;
k = 0; 
for i = 1:trialNumberIncorrect
        k = k+1;
    if k>7
       
        titleName = [rat '-' date '-ch' int2str(chI) 'Incorrect-' int2str(trialNumberIncorrect) '-' int2str(fig) '-' int2str(k)];
            title(titleName);
            saveas(h,[odir titleName],'jpg');
         k=1;
         fig = fig +1;
            h = figure(fig);
            hold on;
    end
    oneTrialW = waveIncorrect(TrialStartIncorrect(i) : TrialStartIncorrect(i)+sampleNumber-1);
    XW = double(oneTrialW*forFloat);
    yW = filter(b1,1,XW);
    y1W = resample(yW,rfs,fs);
    plot(y1W/scale+k*50,'color',cc(k,:))
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
    end
end%trial
        titleName = [rat '-' date '-ch' int2str(chI) 'Incorrect-' int2str(trialNumberIncorrect) '-' int2str(fig) '-' int2str(k)];
            title(titleName);
            saveas(h,[odir titleName],'jpg');
% % fftMatrixSum3(:,:,chI) = fftMatrixSum/trialNumberCorrect;
% % fftMatrixSum3W(:,:,chI) = fftMatrixSumW/trialNumberIncorrect;
% % trialNum(dateI,chI) = trialNumberCorrect;
% % trialNumW(dateI,chI) = trialNumberIncorrect;
% titleNa = [odir 'fftMatrix' rat date '-ch' int2str(chI)];
% save(titleNa, 'fftMatrixSum', 'fftMatrixSumW'); 
close all;
end%ch
% titleNa = ['fftMatrix' rat date]
%title(titleNa); 
% save(titleNa, 'fftMatrixSum3', 'fftMatrixSum3W','trialNum','trialNumW'); 
end%date
    