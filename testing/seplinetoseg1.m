% seplinetoseg1.m
% this is for save each line into cell rows
% by seperating each variables(X, Y and Z)
SegX = cell(1);
SegY = cell(l);
SegZ = cell(l);
%for i = 0:l
    %for j = 
    %disp(i)
%end
for i = 0:l
    if i == 0
        for j = 1:sepline(1)-1
            SegX{1, j} = Xc{j};
            SegY{1, j} = Yci{j};
            SegZ{1, j} = Zc{j};
        end
    %elseif i == l(end)
    %    for j = sepline(i)
    else
        for j = sepline(i):sepline(i+1)-1
            SegX{i+1, j-(sepline(i)-1)} = Xc{j};
            SegY{i+1, j-(sepline(i)-1)} = Yci{j};
            SegZ{i+1, j-(sepline(i)-1)} = Zc{j};
        end
    end
end
