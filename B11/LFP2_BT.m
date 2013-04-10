%close all;

% 
% d=fdesign.lowpass('Fp,Fst,Ap,Ast',450,550,1,50,24414); 
% hd = design(d,'butter');
% [b,a] = tf(hd);
% fvtool(hd);

%d=fdesign.lowpass;
% Hd1=design(d,'kaiserwin');
% [b1,a1] = tf(hd);
% fvtool(Hd1) 
    [b,a] = butter(9,1000/24414);                                                
%     h1 = fvtool(b,a); 
%     [h2, f2] = freqz(b, a, 1024);
% plot(f2, 20*log10(h2), 'b');
% grid on;



datatype = 'Wave';
rat = 'B5L';
block_date = {'04-29-11','05-05-11','05-10-11','05-16-11','05-20-11','05-26-11','05-31-11','06-01-11',...
    '06-02-11','06-03-11','06-06-11','06-07-11','06-10-11',};
block_ch = {'5','7','11','16'};

modeFlag = 1;%0:resting; 1:cue on; 2:interval;

dir = ['E:\B10LFP_sectioned\'];

windowLength = 2000;
fftLength = 500;
fs= 24414;
rfs = 1000;
slidingStep = 10;

chN = length(block_ch);
dateN = length(block_date);
for chI = 1:chN
  %  fftMatrix3 = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1,dateN);
for dateI = 1:dateN
    
        ch = block_ch{chI};
    date = block_date{dateI};

    fin = ['_' rat '-' date '-A_channel'];
    ext = '_incorrecttrialsInterval.mat';

cb_fNameEsig = [dir datatype fin ch ext];
load(cb_fNameEsig)

rfs = 1000;
trialNumber = length(TrialStart);
sampleNumber = windowLength * fs /1000;
singleTrialAC = zeros(sampleNumber,trialNumber);
fNumber = [0 : 2*fs/fftLength : fs];
fftMatrix = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1);
fftMatrixSum = zeros(fftLength/2,(windowLength - fftLength)/slidingStep+1);
for i = 1:length(TrialStart)
    oneTrial = data(TrialStart(i) : TrialStart(i)+sampleNumber-1);
    X = double(oneTrial);
    b1 = fir1(30,1000/24414);
    y = filter(b1,1,X);
%     figure(1);hold on;
%     plot(X);
%     figure(2)
%     plot(y);
    y1 = resample(y,rfs,fs);
%     figure(3)
%     plot(y1);
    for j = 0  : (windowLength - fftLength)/slidingStep
        signal = y1(j*10+1:j*10+fftLength);
        FsingleTrialAC = fft(signal);
        tmp= abs(FsingleTrialAC(1:fftLength/2));
         fftMatrix(:,j+1)= tmp';
    end
fftMatrixSum = fftMatrixSum + fftMatrix;

end%trial
% figure
% imagesc(fftMatrixSum(1:100,:));
% colorbar;
titleNa = ['BT' date  '---'  ch]
%title(titleNa); 
save(titleNa, 'fftMatrixSum'); 
end%date
end%ch
    