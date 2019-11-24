%% CharacterSep1.m

%% Using first Line by adjust it to 35
Mx1 = Mx(1:35, :);

%% Set the first threshold
minX = Mx1(1, 1); % act as a first threshold (min)
medX = Mx1(1, 2);
maxX = Mx1(1, 3); % act as a first threshold (max)

%% Set Parameter
newChar = 0; % if you got next char(not vowel) just go in condition
Charcount = 1; % use to Count char where vowel and tone are in same char
cbt = [];
jzb = [0];
% Ans should be 27 (not conclude first char)

% Test in first line which have 35 character (contain vowel and tone)
% but now vowel and tone are not the same character
%figure(1);
for i = 2:35
    % new char ? then count and set threshold
    if Mx1(i, 1) > maxX % .0003 is just a bit of char distance
        Charcount = Charcount + 1;
        minX = Mx1(i, 1);
        maxX = Mx1(i, 3);
        jzb = horzcat(jzb, 0);
    elseif Mx1(i+1, 2) < maxX
        jjj = SegX(1, i+1);
        cbt = horzcat(cbt, jjj{1});
        jzb = horzcat(jzb, 1);
        if Mx1(i+2, 2) < maxX
            jjj = SegX(1, i+2);
            cbt = horzcat(cbt, jjj{1});
            jzb = horzcat(jzb, 1);
        end
            
    end
end
Charcount
