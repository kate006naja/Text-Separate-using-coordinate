%% CharacterSep1.m

%% Using first Line by adjust it to 35
Mx1 = Mx(1:35, :);
% for Easy SegX and SegY using
SegX1 = SegX(1, :);
SegX1 = SegX1(~cellfun('isempty', SegX1)); % remove empty content
SegY1 = SegY(1, :);
SegY1 = SegY1(~cellfun('isempty', SegY1));
%% Set the first threshold
minX = Mx1(1, 1); % act as a first threshold (min)
medX = Mx1(1, 2);
maxX = Mx1(1, 3); % act as a first threshold (max)

%% Set Parameter
newChar = 0; % if you got next char(not vowel) just go in condition
Charcount = 1; % use to Count char where vowel and tone are in same char
votoX = []; % vowel and tone collecting
votoY = [];
% Ans should be 27 (not conclude first char)

% Test in first line which have 35 character (contain vowel and tone)
% but now vowel and tone are not the same character
%figure(1);
for i = 2:35 % From 35 segment
    % new char ? then count and set threshold
    if Mx1(i, 1) > maxX % .0003 is just a bit of char distance
        Charcount = Charcount + 1;
        minX = Mx1(i, 1);
        maxX = Mx1(i, 3);
        % if it vowel or tone done it here
    elseif Mx1(i, 1) < maxX
        votoX = horzcat(votoX, SegX1(i));
        votoY = horzcat(votoY, SegY1(i));
        if Mx1(i+1, 1) < maxX
            votoX = horzcat(votoX, SegX1(i+1));
            votoY = horzcat(votoY, SegY1(i+1));
        end   
    end
end
Charcount
% vowel and tone plot
figure(3)
for i = 1:numel(votoX)
    t = votoX(i);
    X = t{1, 1};
    
    t = votoY(i);
    Y = t{1, 1};
    plot(X, Y, '*');
    pause(0.05)
    if i ~= 0; hold on; end
    %plot(min(X), median(Y), '*');
    %plot(max(X), median(Y), '*');
end
for i = 25
    t = SegX(1, i);
    X = t{1, 1};
    
    t = SegY(1, i);
    Y = t{1, 1};
    plot(X, Y, 'o');
end

for i = 1:35
    t = SegX(1, i);
    X = t{1, 1};
    
    t = SegY(1, i);
    Y = t{1, 1};
    plot(X, Y);
    pause(0.05)
    if i ~= 0; hold on; end
    %plot(min(X), median(Y), '*');
    %plot(max(X), median(Y), '*');
end

