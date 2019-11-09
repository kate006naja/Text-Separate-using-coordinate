% findline3.m 
% using min and max as a threshold and modifying threshold
% in case of the dot value

close all;
clear all;
clc;

%% open file and store value in cell
file = ("5.txt");
[Xc, Yc, Zc, segCount, txt_list] = readtfile(file);

% inversing Y value in its cell
[Yci] = invY(Yc, segCount);

%% finding min and max in y

lx = length(Xc); % length of x var (can be use for y too)
Mx = zeros(lx, 3);
My = zeros(lx, 3); % creates lx amount of row and 3 columns

for i = 1:length(Yci)
   Mx(i,1) = min(Xc{i});
   Mx(i,2) = median(Xc{i});
   Mx(i,3) = max(Xc{i});
   
   My(i,1) = min(Yci{i});
   My(i,2) = median(Yci{i});
   My(i,3) = max(Yci{i});
end

LineNo = zeros(lx, 1);
l = 0;
newline = 0;
medy = My(1, 2);
miny = My(1, 1); % act as a first threshold (min)
maxy = My(1, 3); % act as a first threshold (max)
Ycvalue = [];
Ystd = 0;

sepline = [];
% maxy = My(1, 3);
%miny = My(1, 1);

for i = 2:lx % start from the second value
    
    % the condition if it still in the same line or next
    if My(i, 1) - maxy >= 0.3
        newline = 0; % this mean to sep outlier first
        miny = My(i, 1);
    else
        if My(i, 3) < miny - 0.01
            % to see if the max of that value
            % is lower than old min
            % to check if '.' is at last char
            %Ycstd = std(Ycvalue);

            newline = newline + 1;
            if newline > 2 % if newline is greater than 3 that mean
                           % we are so sure that that is a new line
                l = l+1;
                newline = 0; % restart parameter if sure its a new line
                miny = My(i-2, 1);
                LineNo(i-2: i, 1) = l;
                sepline = horzcat(sepline, i-2);
            else
                LineNo(i, 1) = l;
            end
        else
            newline = 0; % this mean they dont have any new line
            LineNo(i, 1) = l; % no new line and skip it
            ccy = Yci(i);
            Ycvalue= horzcat(Ycvalue, ccy{1, 1});
        end
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
plot(corY, '.-');
%%
% This part is plotting.
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
   pause(0.0001);
   if i ~= 0, hold on; end
end
% still some error in file 3(which have many space)
% and file 5 which have too large space
figure(2);
for i = sepline
    xxx = Xc(i);
    yyy = Yci(i);
    plot(xxx{1, 1}, yyy{1, 1}, '*');
end
