clear; 
close all
% x = [46.6 -34.5 47.9]';
% bhandle = bar(x); 
% ch = get(bhandle,'Children'); %get children of the bar group
% fvd = get(ch,'Faces'); %get faces data
% fvcd = get(ch,'FaceVertexCData'); %get face vertex cdata
% [zs, izs] = sortrows(x,1); %sort the rows ascending by first columns
% for i = 1:length(x)
% row = izs(i);
% fvcd(fvd(row,:)) = i; %adjust the face vertex cdata to be that of the row
% end
% set(ch,'FaceVertexCData',fvcd) %set to new face vertex cdata

% the data
     v=ceil(5*rand(1,10));
     bh=bar(v);
% - change the bars' colors
     ch=get(bh,'children');
     cd=repmat(1:numel(v),5,1);
     
     cd=[cd(:);nan];
     set(ch,'facevertexcdata',cd);
% - play with colormaps
     colormap(jet);
     disp('press a key to show a user defined colormap');
 %    pause;
     colormap([[1,0,0];[0,1,0];[1,0,0];[0,1,0]]);