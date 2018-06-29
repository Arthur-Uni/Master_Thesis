% load('Results25052018.mat');
close all;
clc;

set(0,'defaulttextinterpreter','latex');

color = [0,0.3294118,0.623529];

hold on;
bar(Results, 'FaceColor', color);
axis([0 length(Results)+1 min(Results)-0.005 max(Results)+0.005]);
set(gca, 'FontSize', 16);
text(1:length(Results),Results + 0.001,num2str(Results'),'vert','bottom','horiz','center', 'FontSize', 16); 
box off;
ylabel('accuracy');
xlabel('implementations');

set(gca, 'FontSize', 16);