close all;
clear;



cd D:\bcheng\work\code\LFP5L\tools;
datatype = 'Wave';
rat = 'S5L';
blockname = {'S5L-12-03-10-A','S5L-12-07-10-A','S5L-12-08-10-A','S5L-12-09-10-A','S5L-12-10-10-A'};
block_ch = [1:16];

modeFlag = 1;%0:resting; 1:cue on; 2:interval;

dir = ['H:\sectionedDataLFP\S10\sectioned\'];
odir =  'H:\preparedDataLFP\S10\';
windowLength = 6000;
fftLength = 500;
fs= 24414;
rfs = 1000;
slidingStep = 10;
sampleNumber = windowLength * fs /1000;
fNumber = [0 : 2*fs/fftLength : fs];
cc = colormap(Lines);
scale = 1000;
forFloat = 32767000;
b1 = fir1(30,1000/24414);% The cut-off frequency Wn must be between 0 < Wn < 1.0, with 1.0 
                           %corresponding to half the sample rate.
                           % cut-off at 500Hz
chN = length(block_ch);
dateN = length(blockname);
trialNum = zeros(dateN,chN);
trialNumW = zeros(dateN,chN);
for dateI =1:dateN
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
h = figure
plot(waveCorrect);
        titleName = [rat '-' date '-ch' int2str(chI) 'Correct'];
            title(titleName);
            saveas(h,[titleName],'jpg');
h = figure
plot(waveIncorrect);


        titleName = [rat '-' date '-ch' int2str(chI) 'Incorrect'];
            title(titleName);
            saveas(h,[titleName],'jpg');

end%ch
% titleNa = ['fftMatrix' rat date]
%title(titleNa); 
% save(titleNa, 'fftMatrixSum3', 'fftMatrixSum3W','trialNum','trialNumW'); 
end%date
    