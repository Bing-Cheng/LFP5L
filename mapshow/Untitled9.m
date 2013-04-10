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
     pause;
     colormap([[1,0,0];[0,1,0]]);