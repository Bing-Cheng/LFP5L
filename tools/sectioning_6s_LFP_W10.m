clear all
ratname = 'W5L';
rdir = 'E:\dataLFP\W10_wave\channel_data\';
cdir = [rdir 'W10_022312\'];
edir = [rdir 'event\'];
odir = [rdir 'sectioned\'];

format = 'mat'; % or 'txt'
Signame = 'Wave';
tail = 'A';
blockname = {'W5L-01-06-11-A','W5L-01-07-11-A','W5L-01-10-11-A','W5L-01-11-11-A','W5L-01-13-11-A','W5L-01-26-11-A','W5L-01-27-11-A',...
    'W5L-01-31-11-A','W5L-02-01-11-A','W5L-02-03-11-A','W5L-02-04-11-A','W5L-02-07-11-A','W5L-02-08-11-A'};

channelset = [1 : 16]; % type the channels here
fs = 24414.1;

for filenamecount = 1 : length(blockname)
    date1 = blockname{filenamecount}
    date= date1(5:12);
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
 filenameOut = strcat(odir, Signame,'_',ratname,'-',date,'-',tail,'_channel',num2str(channelset(channelnum)));
        eval(['save ',char(filenameOut),'_sec.mat waveCorrect waveIncorrect TrialStartCorrect TrialStartIncorrect;']);
 end%CHANNEL
end%DATE

