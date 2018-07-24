% load('Results25052018.mat');
% close all;
clc;

set(0,'defaulttextinterpreter','latex');

color = [0,0.3294118,0.623529];

hold on;
bar(Results, 'FaceColor', color);
axis([0.25 length(Results)+0.75 min(Results)-0.1 max(Results)+0.1]);
%axis([0.25 length(Results)+0.75 0 30]);
set(gca, 'FontSize', 16);
text(1:length(Results),Results + 0.001,num2str(Results'),'vert','bottom','horiz','center', 'FontSize', 16); 
box off;
%ylabel('accuracy');
%xlabel('implementations');

set(gca, 'FontSize', 16);