thetaR1M1Avg = [];
thetaR2M1Avg = [];
thetaW1M1Avg = [];
thetaW2M1Avg = [];
thetaR1M2Avg = [];
thetaR2M2Avg = [];
thetaW1M2Avg = [];
thetaW2M2Avg = [];
 for dateI = 1:dateN
    date1 = blockname{dateI}
    
    titleN = ['Theta Power  ' rat date];
    load([odir titleN]);%, 'thetaR1M1', 'thetaR2M1', 'thetaW1M1', 'thetaW2M1', 'thetaR1M2', 'thetaR2M2', 'thetaW1M2', 'thetaW2M2');
    thetaR1M1Avg = [thetaR1M1Avg; thetaR1M1];
    thetaR2M1Avg = [thetaR2M1Avg; thetaR2M1];
    thetaW1M1Avg = [thetaW1M1Avg; thetaW1M1];
    thetaW2M1Avg = [thetaW2M1Avg; thetaW2M1];
    thetaR1M2Avg = [thetaR1M2Avg; thetaR1M2];
    thetaR2M2Avg = [thetaR2M2Avg; thetaR2M2];
    thetaW1M2Avg = [thetaW1M2Avg; thetaW1M2];
    thetaW2M2Avg = [thetaW2M2Avg; thetaW2M2];
    
 end%date
 thetaR1M1A = mean(thetaR1M1Avg,1);
 thetaR2M1A = mean(thetaR2M1Avg,1);
 thetaW1M1A = mean(thetaW1M1Avg,1);
 thetaW2M1A = mean(thetaW2M1Avg,1);
 thetaR1M2A = mean(thetaR1M2Avg,1);
 thetaR2M2A = mean(thetaR2M2Avg,1);
 thetaW1M2A = mean(thetaW1M2Avg,1);
 thetaW2M2A = mean(thetaW2M2Avg,1);
 
    h = figure; hold on;
    XX = [1 : length(thetaR1M1)];
    plot(XX, thetaR1M1A+thetaR2M1A,'r');
    plot(XX, thetaR1M2A+thetaR2M2A,'g');
    plot(XX, thetaW1M1A+thetaW2M1A,'b');
    plot(XX, thetaW1M2A+thetaW2M2A,'m');

    legend('Ri-M1','Ri-M2','Wr-M1','Wr-M2');
    titleN = ['Theta Power Date Avg ' rat];
    title(titleN);
    saveas(h,[odir titleN],'jpg');
    

  