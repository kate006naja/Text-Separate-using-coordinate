% seplinetoseg1.m
% this is for save each line into cell rows
% by seperating each variables(X, Y and Z)
SegX = cell(1);
SegY = cell(l);
SegZ = cell(l);
close all;
%for i = 0:l
    %for j = 
    %disp(i)
%end
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

                % last char case
                if j == sepline(i+1)
                    SegX{i+1, j-(sepline(i)-1)} = Xc{j};
                    SegY{i+1, j-(sepline(i)-1)} = Yci{j};
                    SegZ{i+1, j-(sepline(i)-1)} = Zc{j};
                end
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

% test plot first and last line
% plot first line
figure(3);
for i = 1:35
    t = SegX(1, i);
    X = t{1, 1};
    
    t = SegY(1, i);
    Y = t{1, 1};
    plot(X, Y);
    pause(0.05)
    if i ~= 0; hold on; end
end

% plot last line
figure(4);
%a214 = Xc(214); b214 = Yci(214);
%plot(a214{1, 1}, b214{1, 1});
for i = 1:17
    t = SegX(8, i);
    X = t{1, 1};
    
    t = SegY(8, i);
    Y = t{1, 1};
    plot(X, Y);
    pause(0.05)
    if i ~= 0; hold on; end
end