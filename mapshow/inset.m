function [h_main, h_inset]=inset(main_handle, inset_handle,inset_size)

% The function plotting figure inside figure (main and inset) from 2 existing figures.
% inset_size is the fraction of inset-figure size, default value is 0.35
% The outputs are the axes-handles of both.
% 
% An examle can found in the file: inset_example.m
% 
% Moshe Lindner, August 2010 (C).

if nargin==2
    inset_size=0.35;
end

inset_size=inset_size*.7;
figure
new_fig=gcf;
main_fig = findobj(main_handle,'Type','axes');
h_main = copyobj(main_fig,new_fig);
pMain = get(main_fig,'Position');

    pMain1 = pMain{1};

    
set(h_main(1),'Position',pMain1);
inset_fig = findobj(inset_handle,'Type','axes');
h_inset = copyobj(inset_fig,new_fig);
ax1=get(main_fig,'Position');
ax = ax1{1};
set(h_inset,'Position', [.35 + .7*ax(1)+ax(3)-inset_size 0.3+.5*ax(2)+ax(4)-inset_size inset_size*0.5 inset_size])