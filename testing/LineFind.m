%% writing line segmenting function
% LineFind.m 
% using min and max as a threshold and modifying threshold
% in case of the dot value

function [sepline, l] = LineFind(Xc, Yci)
% find min and max of y

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
l = 0; % count each line
newline = 0;
miny = My(1, 1); % act as a first threshold (min)
maxy = My(1, 3); % act as a first threshold (max)
Ycvalue = [];

sepline = [];
% maxy = My(1, 3);
%miny = My(1, 1);

for i = 2:lx % start from the second Y value
    
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
sepline = horzcat(sepline, lx(end)) % incaase of the last segment

% in last line case (which I addded 1 line)
l = l+1;

