close all;
clear;

ratname = 'A09';

disLength = 24414;
spacing = 200;  
scaling = 100;
    rat = [ratname(1) '5L'];
    load(['G:\preparedDataLFP\', ratname, '_blockname']);

     d = 1;
        date = blockname{d};
       
    h = figure('pos',[10,-50,1000,1000]); hold on;
    for ch = 1 : 16
            load(['G:\dataLFP\', ratname, '_wave\sectioned\Wave_', date, '_channel',int2str(ch), '_sec.mat']);
            
       
        text(-500-floor(ch/10)*150,spacing*ch,int2str(ch),'FontSize',10); 
        plot(waveCorrectCorrection(1:disLength)/scaling+spacing*ch);%,'LineWidth',2);
    end
    x=[1441,-1000,-1000];
    y = [-300,-300,27];
    plot(x,y,'g','LineWidth',2)
    text(-50,-400,'100 ms','FontSize',10); 
     hText =text(-1450,-250,'1 mV','FontSize',10); 
      
set(hText, 'rotation', 90)
 axis off;
 set(h, 'PaperSize', [5 5]);
        titleN = ['Raw Waveform 1'];
        %title(titleN);
        saveas(h,['G:\preparedDataLFP\' titleN],'jpg');
        
       


  