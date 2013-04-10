close all;
clear;

ratname = 'A09';
sampleRate = 24414;
disLength = sampleRate*2;
offset = sampleRate*0;
fs= 24414;
rfs = 1000;
fftLength = 500;
spacing = 200;  
scaling = 100;
b1 = fir1(30,1000/24414);
    rat = [ratname(1) '5L'];
    load(['G:\preparedDataLFP\', ratname, '_blockname']);

     d = 1;
        date = blockname{d};
       
    
    wave = zeros(16,fftLength);
    fftMatrix  = zeros(16,fftLength/2);
    fftMatrix1  = zeros(16,fftLength/2);
    for ch = 1 : 16
            load(['G:\dataLFP\', ratname, '_wave\sectioned\Wave_', date, '_channel',int2str(ch), '_sec.mat']);
       oneTrial =waveCorrectCorrection((offset + 1):(offset +disLength));
            X = double(oneTrial);
   y = filter(b1,1,X);
     y1 = resample(y,rfs,fs);% resample to 1000Hz sampling rate (1ms each sample)
     wave(ch,:) = y1(1:fftLength);
     signal = y1(1:fftLength);
        FsingleTrialAC = fft(signal);
        tmp= abs(FsingleTrialAC(1:fftLength/2));
         fftMatrix(ch,:)= tmp';
    end
    waveMean = mean(wave);
   h = figure('pos',[10,-50,1000,1000]); hold on;
   for ch = 1 : 16
       text(-2600-floor(ch/10)*150,spacing*ch,int2str(17-ch),'FontSize',10); 
        plot((wave(ch,:)-waveMean+mean(waveMean))/scaling+spacing*ch);%,'LineWidth',2);
   end
%        for ch = 1 : 16
%      signal = (wave(ch,:)-waveMean);
%         FsingleTrialAC = fft(signal);
%         tmp= abs(FsingleTrialAC(1:fftLength/2));
%          fftMatrix1(ch,:)= tmp;
%        end 
%     
%         h = figure('pos',[10,-50,1000,1000]); hold on;
%    for ch = 1 : 16
%        text(-2600-floor(ch/10)*150,spacing*ch,int2str(17-ch),'FontSize',10); 
%         plot(fftMatrix(ch,:)+spacing*ch);%,'LineWidth',2);
%    end
%            h = figure('pos',[10,-50,1000,1000]); hold on;
%    for ch = 1 : 16
%        text(-2600-floor(ch/10)*150,spacing*ch,int2str(17-ch),'FontSize',10); 
%         plot(fftMatrix1(ch,:)+spacing*ch);%,'LineWidth',2);
%    end
%             h = figure('pos',[10,-50,1000,1000]); hold on;
%  plot(mean(fftMatrix),'r');%,'LineWidth',2);
%     
%         plot(mean(fftMatrix1));%,'LineWidth',2);

   
   
   
   
    x=[sampleRate/5,0,0];
    shift = 4000;
    y = [shift-300,shift-300,shift+27];
    plot(x,y,'g','LineWidth',2)
    text(-50,shift-400,'200 ms','FontSize',10); 
     hText =text(-1450,shift-250,'1 mV','FontSize',10); 
      
set(hText, 'rotation', 90)
 axis off;
 set(h, 'PaperSize', [5 5]);
        titleN = ['Raw Waveform 1'];
        %title(titleN);
        saveas(h,['D:\bcheng\work\paper\my\paper2_LFP\fig\' titleN],'png');
        
       


  