%% Coorplot.m
function [corX, corY] = Coorplot(segCount)
% Coorplot function will return figure of Coordinate
% that plot on normal x-y axis graph

corY = [];
corX = [];
for i = 1:segCount-1
    t = Yci(i);
    Y = t{1 ,1};
    %plot(Y);
    corY = horzcat(corY, Y);
    t = Xc(i);
    X = t{1, 1};
    corX = horzcat(corX, X);
end
figure();
plot(corX, corY, '.');
plot(corY, '.-');