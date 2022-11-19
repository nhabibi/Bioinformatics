% to get the data from a figure, open it and run below codes:

axs = get(gcf, 'Children');
pos = get(axs(1), 'Children');
X = get(pos, 'XData');
Y = get(pos, 'YData');
figure;
plot(X,Y);

%%%%%%%%%%%%%%%%%%%%%%
% to plot several curves on a figure, you can give to the "plot function"
% matrices instead of vetors:

plot(X,Ys,'o-');
xLabel('Log ( (TP+FP) / Length )');
yLabel('TP / (TP+FP)');
gtext('...');
