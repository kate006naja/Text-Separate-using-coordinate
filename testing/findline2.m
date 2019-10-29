% findline2.m 
% using min and max as a threshold

close all;
clear all;
clc;

%% open file and store value in cell
file = ("8.txt");
[Xc, Yc, Zc, segCount, txt_list] = readtfile(file);

% inversing Y value in its cell
[Yci] = invY(Yc, segCount);

%% finding min and max in y

lx = length(Xc); % length of x var (can be use for y too)
Mx = zeros(lx, 3);
My = zeros(lx, 3); % creates lx amount of row and 3 columns

for i = 1:length(Yci)
   Mx(i,1) = min(Xc{i});
   Mx(i,2) = mean(Xc{i});
   Mx(i,3) = max(Xc{i});
   
   My(i,1) = min(Yci{i});
   My(i,2) = mean(Yci{i});
   My(i,3) = max(Yci{i});
end

LineNo = zeros(lx, 1);
l = 0;
newline = 0;
maxy = My(1, 3); % act as a first threshold (max)
miny = My(1, 1); % act as a first threshold (min)
sepline = [];
% maxy = My(1, 3);
%miny = My(1, 1);

for i = 2:lx % start from the second value
    if My(i, 3) < miny % to see if the max of that value
                       % is lower than old min
        newline = newline + 1;
        if newline > 3 % if newline is greater than 3 that mean
                       % we are so sure that that is a new line
            l = l+1;
            newline = 0; % restart parameter if sure its a new line
            miny = My(i, 1);
            LineNo(i-3: i, 1) = l;
            sepline = horzcat(sepline, i-3);
        else
            LineNo(i, 1) = l;
        end
    else
        newline = 0; % this mean they dont have any new line
        LineNo(i, 1) = l; % no new line and skip it
    end
end
%for i = sepline
%    xxx = Xc(i);
%    yyy = Yci(i);
%    plot(xxx{1, 1}, yyy{1, 1}, '*');
%end
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
figure(1);
plot(corX, corY, '.');
plot(corY, '.');