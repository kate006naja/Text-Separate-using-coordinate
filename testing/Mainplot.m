%% Mainplot.m
% Do all the plot thing

clear all;
close all;

%% All functions
% open file and store value in cell
file = ("8.txt"); % 9 is a problem % 5 is good
[Xc, Yc, Zc, segCount, txt_list] = readtfile(file);

% inversing Y value in its cell
[Yci] = invY(Yc, segCount);

% sepline is the mid value to separate each line
% l is how many line you got during the process
[sepline, l] = LineFind(Xc, Yci);

% use function sepline to seg
% to segment eachline into each segment
[SegX, SegY, SegZ] = linesegment(l, sepline, Xc, Yci, Zc);

%% plot 1 | plot X and Y in graph
corY = []; % Store every X Coordinate
corX = []; % Store every Y Coordinate
for i = 1:segCount-1
    t = Yci(i);
    Y = t{1 ,1};
    %plot(Y);
    corY = horzcat(corY, Y);
    t = Xc(i);
    X = t{1, 1};
    corX = horzcat(corX, X);
end
figure(1);
plot(corX, corY, '.');
plot(corY, '.-');

%% plot 2 | plot X and Y in writing way
figure(2);
for i = 1:segCount-1 % Plotting in every segment
   t = Xc(i); % Store each segment of 'x' into each column of cell
   X = t{1,1};
   
   t = Yci(i); % Store each segment of 'y' into each column of cell
   Y = t{1,1}; 
   %Y = 1-Y;
   % wait for me to fix 1-Y in main code
   
   t = Zc(i); % Store each segment of 'z' into each column of cell
   Z = t{1,1}; % inverse Y first
   
   plot(X, Y); % Plot each segment ( each Char )
   % time pause per each loop
   pause(0.00001);
   if i ~= 0, hold on; end
end
% still some error in file 3(which have many space)
% and file 5 which have too large space
%% plot 3 | Plot straight where the line is segment
figure(2);
for i = sepline
    xxx = Xc(i);
    yyy = Yci(i);
    plot(xxx{1, 1}, yyy{1, 1}, '*');
end

%% plot 4 | Line Segment Plotting | Using First Line

% plot first line
figure(3);
lsrow = size(SegX, 1);
lscol = size(SegX, 2);
for i = 1:lscol % depend on how much column(1st line) 
             % this line in SegX or SegY
    t = SegX(1, i);
    X = t{1, 1}; % First row cell
    
    t = SegY(1, i);
    Y = t{1, 1};
    plot(X, Y);
    pause(0.05)
    if i ~= 0; hold on; end
    %plot(min(X), median(Y), '*');
    %plot(max(X), median(Y), '*');
end

%% plot 5 | Line Segment Plotting | Using Last Line
% plot last line
figure(4);
% get the cell size
for i = 1:lscol
    t = SegX(lsrow, i); % Last row cell
    X = t{1, 1};
    
    t = SegY(lsrow, i);
    Y = t{1, 1};
    plot(X, Y);
    pause(0.05)
    if i ~= 0; hold on; end
    %BoxX = [min(X), max(X)];
    %BoxY = [min(Y), max(Y)];
    %plot(BoxX, BoxY, '-');
end