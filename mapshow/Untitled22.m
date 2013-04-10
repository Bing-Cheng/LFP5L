load count.dat;
y = count(1:10,:); % Loading the dataset creates a variable 'count' 
figure; subplot(1,2,1);
bar3(y,'detached');
title('Detached');
subplot(1,2,2);
bar3(y,0.5,'detached');
title('Width = 0.5');