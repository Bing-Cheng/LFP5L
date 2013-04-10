close all;
clear;
ratName = 'K11';
rat = [ratName(1) '5L'];
disFreq = 50;
scaleDown= 100000;
idir = ['G:\preparedDataLFP\' ratName '\'];
odir = ['G:\LFP5LOutput\' ratName '\colorMap\'];
pdir = ['D:\bcheng\work\paper\my\paper2_LFP\fig\'];
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
            %colorbar;
            xlabel('time(ms)');
            ylabel('frequence(Hz)');
            titleName = [rat '-R-cue'];
            %title(titleName);
            saveas(h,[odir titleName],'jpg');
     load([odir rat 'fftBEcr']);%, 'fftR1DmcBE', 'fftW1DmcBE', 'fftR1DmrBE', 'fftW1DmrBE');           
            wBE = [51:151];
            h = figure('position', [700   100   560/4   420]); 

            disMatrixBE = zeros(disFreq*5,101);
             disMatrixBE([1:10:disFreq*5],:) = fftR1DmcBE(1:disFreq/2,wBE);
            for i=1:9
            disMatrixBE([i+1:10:disFreq*5],:) = fftR1DmcBE(1:disFreq/2,wBE)+(fftR1DmcBE(2:disFreq/2+1,wBE)-fftR1DmcBE(1:disFreq/2,wBE))*i/10;
            end
            imagesc([-500 500],[0,50],disMatrixBE,[30000,230000]);
            %colorbar;
            titleName = [rat  '-R-end'];
            %title(titleName);
            saveas(h,[odir titleName],'jpg');
            
            
            
 thetaBand = [2:4];%4-8Hz           
h = figure('position', [0   100   560   420]);

hold on;   
XX = [-2000:2000];
dThetaR = interp1([1:401],mean(fftR1Dmc(thetaBand,1:401)),[1:0.1:401]);
            plot(XX,dThetaR/scaleDown,'r','linewidth',1);
dThetaW = interp1([1:401],mean(fftW1Dmc(thetaBand,1:401)),[1:0.1:401]);
            plot(XX,dThetaW/scaleDown,'g','linewidth',1);
            xlabel('time(ms)');
            ylabel('amplitude of theta oscillation (AU)');
            axis([-2000 2000 1 2]);
            titleName = [rat '-thetaAC-RW'];
            legend('SL','FD');
            %title(titleName);
            saveas(h,[pdir titleName],'jpg');
     load([odir rat 'fftBEcr']);%, 'fftR1DmcBE', 'fftW1DmcBE', 'fftR1DmrBE', 'fftW1DmrBE');           
           
            h = figure('position', [700   100   560/4   420]); 
   hold on;
            fftR1DmBE = (fftR1DmcBE+fftR1DmrBE)/2;
             fftW1DmBE = (fftW1DmcBE+fftW1DmrBE)/2;
XX = [-500:500];
dThetaRBE = interp1([1:101],mean(fftR1DmBE(thetaBand,wBE)),[1:0.1:101]);
            plot(XX,dThetaRBE/scaleDown,'r','linewidth',1);
dThetaWBE = interp1([1:101],mean(fftW1DmBE(thetaBand,wBE)),[1:0.1:101]);
            plot(XX,dThetaWBE/scaleDown,'g','linewidth',1);
            axis([-500 500 1 2]);
            %colorbar;
            titleName = [rat  '-thetaBE-RW'];
            %title(titleName);
            saveas(h,[pdir titleName],'jpg');
            

  