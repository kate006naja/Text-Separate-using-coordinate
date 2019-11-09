% xobserve1.m
% just to observing x and plot it in X way (plot(Y, X))

close all;
clear all;
clc;

%% Open file and store it values
file = ("3.txt");
[Xc, Yc, Zc, segCount, txt_list] = readtfile(file);
[Yci] = invY(Yc, segCount);













figure(1);
for i = 1:segCount-1 % Plotting in every segment
   t = Xc(i); % Store each segment of 'x' into each column of cell
   X = t{1,1};
   
   t = Yci(i); % Store each segment of 'y' into each column of cell
   Y = t{1,1}; 
   
   t = Zc(i); % Store each segment of 'z' into each column of cell
   Z = t{1,1};
   
   plot(X, Y); % Plot each segment ( each Char )
   % time pause per each loop
   pause(0.0001);
   if i ~= 0, hold on; end
end

corY = [];
corX = [];
for i = 1:segCount-1
    t = Yci(i);
    Y = t{1 ,1};
    %plot(Y);
    corY = horzcat(corY, Y);
    t = Xc(i);
    X = t{1, 1};
    corX = horzcat(corX, 1-X);
end
figure(2);
plot(corX, corY, '.');
plot(corX, '.-');