close all;
clear all;
clc;

file = ("7.txt");
[Xc, Yc, Zc, segCount, txt_list] = readtfile(file);

Ery = cell(1);
Erx = cell(1);
cellcount = 1;
meankeep = [];

[Yci] = invY(Yc, segCount);
game = 0;
Ycmed = [];
Ystd = [];
tcount = 1;
linecount = 0;
for i = 1:segCount-1
    if (game == 0)
        % new threshold counting
        % okay now I understant If i put var like this tcount would always
        % be the same
        ccy1 = Yci(i);
        ccy1 = median(ccy1{1, 1});
        Ycmed = horzcat(Ycmed, ccy1);
        meankeep = horzcat(meankeep, ccy1);
        tcount = tcount + 1;
        if (mod(tcount, 4) == 0)
            Ystd = std(Ycmed);
            Ycmed = median(Ycmed);
            disp('this is new threshold');
            disp(Ycmed)
            game = 1;
        end
    end
    if (game == 1) % dont know how to still run if it still in the threshold
        ccy2 = Yci(i);
        ccy2 = mean(ccy2{1, 1});
        if (ccy2 >= Ycmed - (3*Ystd)) && (ccy2 <= Ycmed + (3*Ystd))
            disp('stilll in this game !!')
            meankeep = horzcat(meankeep, ccy2);
        elseif (ccy2 > Ycmed + (3*Ystd)) || (ccy2 < Ycmed - (3*Ystd))
        % now I know let imagine
        % what if it enter the new line and its like %6 = 5
        % then the next line would be set as the new threshold
        % so I need to trap it first
            disp('new lineeee ???')
            disp(Ycmed)
            cellcount = cellcount + 1;
            Erx(1, i) = Xc(i);
            Ery(1, i) = Yci(i);
            linecount = linecount + 1;
            meankeep = horzcat(meankeep, ccy2);
            Ycmed = [];
            game = 0;
            %pause(4)
        end
    end
end
linecount
%%

% This part is plotting.
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
   pause(0.01);
   if i ~= 0, hold on; end
end
% still some error in file 3(which have many space)
% and file 5 which have too large space