% load('Results25052018.mat');

hold on;
bar(Results);
axis([0 length(Results)+1 98.8/100 99.1/100]);
set(gca, 'FontSize', 16);
text(1:length(Results),Results,num2str(Results'),'vert','bottom','horiz','center', 'FontSize', 16); 
box off;
ylabel('accuracy');
xlabel('implementations');