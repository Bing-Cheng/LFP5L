% This program is used for picking CORRECT trials from a whole session of
% recording, in each day.
% Parameters needed: date, ReadyPress, RewardE
% Files needed: 1)raw waveform(1*N matrix) 2)RePr(N*2 matrix)
% 3)RewE(N*2 matrix)
% RePr and RewE have two kinds of formats: .txt and .mat. Make sure to
% choose appropriate format
% Make sure to change current directory to which contains the files needed.
% This program is modified to generate waveforms of a single day.
% Last modified by Yuan Yuan, April 9, 2010
clear all
cdir = 'G:\B10_data\channel_data\B10_05_09\';
edir = 'G:\B10_data\channel_data\B5L_event\';
%G:\w_data\channel_data\W5L-07-06-09
format = 'mat'; % or 'txt'
ratname = 'B5L';
Signame = 'Wave';
    
% dateW={'06-24-10'    '06-28-10'    '06-29-10'    '06-30-10'    '07-01-10'    '07-02-10'    '07-06-10'    '07-07-10'...
%     '07-08-10'    '07-09-10'    '07-12-10'    '07-15-10'    '07-19-10'    '07-20-10'    '07-21-10'    '07-27-10'...
%     '07-28-10'    '07-29-10'    '08-04-10'    '08-05-10'    '08-06-10'    '08-09-10'    '08-10-10'    '08-12-10'};

dateW = {...'04-12-11','04-13-11','04-14-11','04-15-11','04-18-11','04-28-11',
    '04-29-11','05-05-11','05-10-11','05-16-11','05-20-11','05-26-11','05-31-11','06-01-11','06-02-11',...
    '06-03-11','06-06-11',...
    '06-07-11','06-10-11'};

tail = 'A';
blockname = {'B5L-04-29-11-A','B5L-05-05-11-A','B5L-05-10-11-A','B5L-05-16-11-B','B5L-05-20-11-A','B5L-05-26-11-A','B5L-05-31-11-A','B5L-06-01-11-A',...
    'B5L-06-02-11-A','B5L-06-03-11-A','B5L-06-06-11-A','B5L-06-07-11-A','B5L-06-10-11-A',};

channelset = [1 : 16]; % type the channels here
fs = 24414.1;
%reading [2 12 14 16 18]
for filenamecount=4:13
    date = dateW{filenamecount}
    date1= date(1:5);
 switch(format)
% if in .txt format
    case('txt')
        %L5L-06-21-10-LeRe
        LeftPress = strcat(edir, ratname,'-',date,'-LePr.txt'); 
        RightPress = strcat(edir, ratname,'-',date,'-RiPr.txt'); 
        ReadyPress = strcat(edir,  ratname,'-',date,'-RePr.txt'); 
        RewardE = strcat(edir, ratname,'-',date,'-RewE.txt'); 

% if in .mat format
    case('mat')
        LeftPress = strcat(edir, ratname,'-',date,'-',tail,'-LePr'); 
        RightPress = strcat(edir, ratname,'-',date,'-',tail,'-RiPr'); 
        ReadyPress = strcat(edir,  ratname,'-',date,'-',tail,'-RePr'); 
        RewardE = strcat(edir, ratname,'-',date,'-',tail,'-RewE');
 end
 for channelnum=1:length(channelset)
filename = strcat(cdir, Signame,'_',ratname,'-',date,'-',tail,'_channel',num2str(channelset(channelnum)));
          eval(['load ', char(filename),'.mat;'])
                LePrS = load(LeftPress);
                RiPrS = load(RightPress);
                RePrS = load(ReadyPress);
                RewES = load(RewardE);
        LePr = LePrS.LePr;
        RiPr =  RiPrS.RiPr;
                RePr = RePrS.RePr;
                RewE = RewES.RewE;
        for count = 1:10
        if RePr(1,2)==0
            RePr_new = RePr(2:end,:);
            clear RePr
            RePr = RePr_new;
            clear RePr_new;
        end
        if RewE(1,2)==0%added by cb 05/21/11, rat L 06-24-10 RewE has a zero at beginning
            RewE_new = RewE(2:end,:);
            clear RewE
            RewE = RewE_new;
            clear RewE_new;
        end
        end

        flag =2;
        while flag<length(RePr)+1
            if RePr(flag,2)==RePr(flag-1,2)
                RePr(flag:(length(RePr)-1),:)=RePr(flag+1:end,:);
                RePr = RePr(1:end-1,:);
            end
            flag = flag+1;
        end
        flag =2;
        while flag<length(RePr)+1
            if RePr(flag,2)==RePr(flag-1,2)
                RePr(flag:(length(RePr)-1),:)=RePr(flag+1:end,:);
                RePr = RePr(1:end-1,:);
            end
            flag = flag+1;
        end
        flag =2;
        while flag<length(RePr)+1
            if RePr(flag,2)==RePr(flag-1,2)
                RePr(flag:(length(RePr)-1),:)=RePr(flag+1:end,:);
                RePr = RePr(1:end-1,:);
            end
            flag = flag+1;
        end
 
        %section

        waveCorrect=[];
        TrialStartCorrect=[];
        waveIncorrect=[];
        TrialStartIncorrect=[];
        lMax = max(LePr(:,2));
        rMax = max(RiPr(:,2));
        cMax1 = max(lMax,rMax);
        trsR = RewE(:,2);
        reMax = max(trsR);
        cMax2 = max(reMax,cMax1);
        readyMax = size(RePr,1);
        cMax = min(readyMax,cMax2);
        trsW = [1:cMax];
        if (trsR(1)==1)
            trsR(1) = [];
        end
        if (trsR(end)>cMax)
            trsR(end) = [];
        end
        trsW(trsR) = [];
        if (trsW(1)==1)
            trsW(1) = [];
        end
%         if trsR(end)~=cMax
%             trs(end) = [];%remove an incorrect trial if it is the last one because there is not enough data after that
%         end
        for i=trsR'%correct trials
            wave1=data(floor(fs*(RePr(i,1)-2)) : floor(fs*(RePr(i,1)+4)));
                TrialStartCorrect = [TrialStartCorrect,length(waveCorrect)+1]; 
                waveCorrect=[waveCorrect, wave1];
         end%i=trs        
        for i=trsW%incorrect trials
            wave1=data(floor(fs*(RePr(i,1)-2)) : floor(fs*(RePr(i,1)+4)));
                TrialStartIncorrect = [TrialStartIncorrect,length(waveIncorrect)+1]; 
                waveIncorrect=[waveIncorrect, wave1];
        end%i=trs
 
        eval(['save ',char(filename),'_sec.mat waveCorrect waveIncorrect TrialStartCorrect TrialStartIncorrect;']);
 end%CHANNEL
end%DATE

