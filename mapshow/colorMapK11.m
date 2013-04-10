close all;
clear;
ratName = 'K11';
rat = [ratName(1) '5L'];
disFreq = 50;
idir = ['G:\preparedDataLFP\' ratName '\'];
odir = ['G:\LFP5LOutput\' ratName '\colorMap\'];
load([odir rat 'fft']);

%save([odir rat 'fft'], 'fftR1Dmc', 'fftW1Dmc');

disTime = 401;
disMatrix = zeros(disFreq*5,disTime);
            h = figure('position', [0   100   560   420]);
            
            disMatrix([1:10:disFreq*5],:) = fftR1Dmc(1:disFreq/2,1:401);
            for i=1:9
            disMatrix([i+1:10:disFreq*5],:) = fftR1Dmc(1:disFreq/2,1:401)+(fftR1Dmc(2:disFreq/2+1,1:401)-fftR1Dmc(1:disFreq/2,1:401))*i/10;
            end
            imagesc([-2000 2000],[0,50],disMatrix,[30000,230000]);
            colorbar;
            xlabel('time(ms)');
            ylabel('frequence(Hz)');
            titleName = [rat '-R-c-' int2str(disFreq)];
            %title(titleName);
            saveas(h,[odir titleName],'jpg');
            
            
            h = figure('position', [700   100   560   420]); 
             disMatrix([1:10:disFreq*5],:) = fftW1Dmc(1:disFreq/2,1:401);
            for i=1:9
            disMatrix([i+1:10:disFreq*5],:) = fftW1Dmc(1:disFreq/2,1:401)+(fftW1Dmc(2:disFreq/2+1,1:401)-fftW1Dmc(1:disFreq/2,1:401))*i/10;
            end
            imagesc([-2000 2000],[0,50],disMatrix,[30000,230000]);
            colorbar;
            titleName = [rat  '-W-c-' int2str(disFreq)];
            %title(titleName);
            saveas(h,[odir titleName],'jpg');
            

  