%close all;
clear;

ratname = 'A09';
sampleRate = 24414;
disLength = sampleRate*2;
offset = sampleRate*0;
spacing = 200;  
scaling = 100;
b1 = fir1(30,1000/24414);
    rat = [ratname(1) '5L'];
    load(['G:\preparedDataLFP\', ratname, '_blockname']);

     d = 1;
        date = blockname{d};
       
    h = figure('pos',[10,-50,1000,1000]); hold on;
    wave = zeros(16,disLength);
    for ch = 1 : 16
            load(['G:\dataLFP\', ratname, '_wave\sectioned\Wave_', date, '_channel',int2str(ch), '_sec.mat']);
       oneTrial =waveCorrectCorrection((offset + 1):(offset +disLength));
            X = double(oneTrial);
    wave(ch,:) = filter(b1,1,X);
   
    end
    waveMean = mean(wave);
    for ch = 1 : 16
       text(-2600-floor(ch/10)*150,spacing*ch,int2str(17-ch),'FontSize',10); 
        plot((wave(ch,:)-waveMean+mean(waveMean))/scaling+spacing*ch);%,'LineWidth',2);
    end
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
        
       


  