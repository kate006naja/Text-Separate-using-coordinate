%% Segment each line into each cell rows
% linesegment.m
% this is for save each line into cell rows
% by seperating each variables(X, Y and Z)
% I'm testing this by just using file "6.txt"

function [SegX, SegY, SegZ] = linesegment(l, sepline, Xc, Yci, Zc)
SegX = cell(1);
SegY = cell(l);
SegZ = cell(l);

%close all;

for i = 0:l
    % First Line Case
    if i == 0
        for j = 1:sepline(1)-1
            SegX{1, j} = Xc{j};
            SegY{1, j} = Yci{j};
            SegZ{1, j} = Zc{j};
        end
        
    % Last Line Case
    elseif i >= l(end)-1
        if i == l(end)-1
            for j = sepline(i):sepline(i+1)
                SegX{i+1, j-(sepline(i)-1)} = Xc{j};
                SegY{i+1, j-(sepline(i)-1)} = Yci{j};
                SegZ{i+1, j-(sepline(i)-1)} = Zc{j};
            end
        elseif i == l(end)
            break
        end
    % Normal Case    
    else
        for j = sepline(i):sepline(i+1)
            SegX{i+1, j-(sepline(i)-1)} = Xc{j};
            SegY{i+1, j-(sepline(i)-1)} = Yci{j};
            SegZ{i+1, j-(sepline(i)-1)} = Zc{j};
        end
    end
end