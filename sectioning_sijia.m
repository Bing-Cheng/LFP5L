function[SMST_list]=sectioning(folder,start,destfolder,stype)
% Sectioning
% Example: sectioning(E:\T12,[1,inf]) 'start' indicates the date to start
% sectioning. 1 means from the first day of recording. inf means sectioning
% all files.
Ver_num = '1.2';

if nargin < 4 
    stype = 'all';
end

if nargin < 3
    destfolder = folder;
end

flagv = [0,0,0]; % Regular,Between,Resting

if isempty(strfind(stype,'all')) == 0
    flagv = [1,1,1];
else
    flagv = [~isempty(strfind(stype,'reg')),~isempty(strfind(stype,'bet')),~isempty(strfind(stype,'res'))];
end




current_folder=cd(destfolder);
if exist('Sectioned_Reg','dir') ~= 7
    mkdir('Sectioned_Reg')
end
if exist('Sectioned_Bet','dir') ~= 7
    mkdir('Sectioned_Bet')
end
if exist('Sectioned_Res','dir') ~= 7
    mkdir('Sectioned_Res')
end

cd(folder)

cd EventData
SMST_list=dir('*SMST.mat');
SMST_list=char(SMST_list(1:length(SMST_list)).name);
SMST_Rest_list=dir('*Resti*');
SMST_Rest_list=char(SMST_Rest_list(1:length(SMST_Rest_list)).name);
SMST_list=setdiff(SMST_list,SMST_Rest_list,'rows');
cd ..


TRD=length(SMST_list);% Total Recording Days
fid = fopen([destfolder,'\Sectioning_log.txt'],'at');
fprintf(fid,'%s\t %s\t %s\n','sectioning',['Ver ',Ver_num],datestr(now));
fprintf(fid,'%s\n',stype);

war_counter = 0;

for i=start(1):min(start(2),TRD)
    
    SMST_id=SMST_list(i,:);
    dstart=regexp(SMST_id,'\d\d-\d\d-\d\d');
    rDate=SMST_id(dstart:dstart+7);
    load([folder,'\EventData\',SMST_id],'-mat');
    
    if isnan(SMST(1))
        warning(['No events in file ',SMST_id]);
        fprintf(fid,'%s\t %s\n ',SMST_id,'No events in file');
        war_counter = war_counter + 1;
        continue
    end
    
    load([folder,'\EventData\',strrep(SMST_id,'SMST','RePr')],'-mat');
    load([folder,'\EventData\',strrep(SMST_id,'SMST','RewE')],'-mat');
    Start_time=SM1find(SMST);
    End_time=SM4find(SMST);
    
    
    if (Start_time(1,1) - RePr(1,1) < 1e-3)&& RePr(1,2) == 0
        Start_time = Start_time(2:end,:);
        End_time = End_time(2:end,:);        
    end
    
  
        
    TTN=length(Start_time(:,1)); % Total Trial Number
    
    
    
    
    
   
     
    if TTN~=max(RePr(:,2))&&TTN~=(max(RePr(:,2))-1)
        
        warning(['load fail or corrupted SMST/RePr ',num2str(i),' ',rDate])
        fprintf(fid,'%s\t %s\n ',SMST_id,'load fail or corrupted SMST/RePr ');
        war_counter = war_counter +1;
     
        continue
        
    end
    if length(Start_time)>length(End_time)
        Start_time=Start_time(1:end-1,:);
    end

    
    cd Channel_Data
    Data_list=dir(['*',rDate,'*']);
    Data_list=char(Data_list(1:length(Data_list)).name);
    Rest_list=dir(['*',rDate,'-Resting*']);
    Rest_list=char(Rest_list(1:length(Rest_list)).name);
    Data_list=setdiff(Data_list,Rest_list,'rows');
    [nrow,~]=size(Data_list);
    if mod(nrow,16)~=0
        cd(current_folder);
        warning('# of neuron data does not match # of recorded days');
        fprintf(fid,'%s\t %s\n ',SMST_id,'# of neuron data does not match # of recorded days');
        war_counter = war_counter +1;
        continue
        
    end   
    cd ..
    
    time_reg = [Start_time(:,1)-2,End_time(:,1)+.5];
    
    
    time_bet = bet_time(Start_time,End_time,RewE);
    
    fprintf(fid,'\n');
    if flagv(1) + flagv(2) > 0
    for k=1:nrow
        Data_id = Data_list(k,:); 
        disp(['==DAY ',num2str(i),'/',num2str(TRD),'==   ',Data_id]);
        load([folder,'\Channel_Data\',Data_id],'-mat')
        fprintf(fid,'%s\t',Data_id);
        if floor(max(time_reg(end,2))*24414.1)>length(data)
            warning('Event longer than data')  
            fprintf(fid,'%s\n','Event longer than data');
            war_counter = war_counter +1;
            continue
        end
        % Regular
        if flagv(1) == 1
            disp('Regular Sectioning')
            
            
            % The section starts at 2sec before trial start(2sec before
            % SMST 1) and ends 1sec after trial end(.5sec after SMST 4)
            
            wave = wavesec(time_reg,data);
            time = time_reg;
            save([destfolder,'\Sectioned_Reg\',Data_id(1:regexp(Data_id,'.mat')-1),'_sec_reg.mat'],'wave','time','-mat');  
            fprintf(fid,'%s\t','Reg');
            clear wave time
        end
        % Between Trial
        if flagv(2) == 1
            disp('Between Trial Sectioning')
            
            if ~isnan(time_bet(1,1))&&~isempty(time_bet)
                time = time_bet;
            wave = wavesec(time_bet,data);
            save([destfolder,'\Sectioned_Bet\',Data_id(1:regexp(Data_id,'.mat')-1),'_sec_bet.mat'],'wave','time','-mat');  
            fprintf(fid,'%s\t','Bet');
            else
                disp('No between trial');
            end
            clear wave time      
        end        
    end
    end  
    % Resting
    if flagv(3) == 1 && ~isempty(Rest_list)
        for k = 1:length(Rest_list(:,1))
            Data_id = Rest_list(k,:);
            disp(Data_id)
            disp('Resting Sectioning')
            load([folder,'\Channel_Data\',Data_id],'-mat')
            wave = wavesec_res(data);
            save([destfolder,'\Sectioned_Res\',Data_id(1:regexp(Data_id,'.mat')-1),'_sec_res.mat'],'wave','-mat');  
            fprintf(fid,'%s\t','Res');
            clear wave
        end
    end
    fprintf(fid,'\n\r');
            
            
end
cd(current_folder)
close all
fprintf(fid,'\n\r');
fclose(fid);
disp('done')
if war_counter > 0
disp([num2str(war_counter), ' Warnings in total'])
end


end



function [wave]=wavesec(time,data)
wave=[];
for i=1:length(time(:,1))
            StartPoint = time(i,1);
            EndPoint = time(i,2);
            if EndPoint<StartPoint
                error('StartPoint and EndPoint are mismatched')
            end
            
            if EndPoint > length(data)
                continue
            end
            wave1=data(floor(24414.1*StartPoint):floor(24414.1*EndPoint));
            wave=[wave, wave1];
            
end
end

function [result]=SM1find(SMST)

max_state = max(SMST(:,2));
row_idx=find(SMST(:,2)==1);
crt=row_idx(2:end)-row_idx(1:end-1);
crt_idx=find(crt ~= max_state+1);
result=SMST(setdiff(row_idx,crt_idx),:);


end

function [result]=SM4find(SMST)

max_state = max(SMST(:,2));
row_idx=find(SMST(:,2)==4);
crt=row_idx(2:end)-row_idx(1:end-1);
crt_idx=find(crt~= max_state + 1);
result=SMST(setdiff(row_idx,crt_idx+1),:);

end

% Between Trial Sectioning
function [time] = bet_time(Start_time,End_time,RewE)

if length(Start_time(:,1)) < 2
    time = nan(1,2);
    
else
fail_list = setdiff([1:length(Start_time(:,1))],RewE(:,2));

if max(fail_list) == length(End_time(:,1))
fail_list = fail_list(1:end-1);
end
time = nan(length(fail_list),2);
time(:,1) = End_time(fail_list,1)+3;
time(:,2) = Start_time(fail_list+1,1)-2;
time_l = time(:,2) - time(:,1);
time(time_l > 5*60,1) = time(time_l > 5*60,2)-5*60;
end

end

function [wave] = wavesec_res(data)

% Resting less than 5 mins: cut off 2 mins from start
% if floor(length(data)/24414.1) < 5*60
End_point = min(floor(7*60*24414.1),length(data));
    wave = data(floor(2*60*24414.1):End_point);
%     
%     %Resting longer than 5 mins: use the last 5 mins
% else 
%     wave = data(end - floor(5*60*24414.1):end);
% end

end
