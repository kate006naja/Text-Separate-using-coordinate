
file = ("6.txt");
[Xc, Yc, Zc, segCount, txt_list] = readtfile(file);


% This part is plotting.
for i = 1:segCount-1 % Plotting in every segment
   t = Xc(i); % Store each segment of 'x' into each column of cell
   X = t{1,1};
   X = 10*X; % for easy calculating
   
   t = Yc(i); % Store each segment of 'y' into each column of cell
   Y = t{1,1}; 
   Y = 1-Y;
   Y = 10*Y;
   
   t = Zc(i); % Store each segment of 'z' into each column of cell
   Z = t{1,1}; % inverse Y first
   
   plot(X, Y); % Plot each segment ( each Char )
   % time pause per each loop
   pause(0.05);
   if i ~= 0, hold on; end
end

%%
game = 0;
Ycmed = [];
Ystd = [];
for i = 1:29
    if (game == 0)
        ccy1 = Yc(i);
        ccy1 = mean(ccy1{1, 1});
        Ycmed = horzcat(Ycmed, ccy1);
        if (mod(i, 6) == 0)
            Ycmed = median(Ycmed);
            Ystd = std(Ycmed);
            disp('this is current threshold');
            Ycmed
            game = 1;
        end
    elseif (game == 1)
        ccy2 = Yc(i);
        ccy2 = mean(ccy2{1, 1});
        if (ccy2 >= Ycmed - (2*Ystd)) && (ccy2 <= Ycmed + (2*Ystd))
            disp('stilll in this game !!')
        elseif (ccy2 > Ycmed + (2*Ystd)) || (ccy2 < Ycmed - (2*Ystd))
            disp('new lineeee ???')
            Ycmed
            Ycmed = [];
            game = 0;
        end
    end
end
%%
% Counting y-mean for every line using 6 segment of it
% and finding it median 
Yc1 = Yc(1);
Yc1 = mean(Yc1{1,1});
Yc2 = Yc(2);
Yc2 = mean(Yc2{1,1});
Yc3 = Yc(3);
Yc3 = mean(Yc3{1,1});
Yc4 = Yc(4);
Yc4 = mean(Yc4{1,1});
Yc5 = Yc(5);
Yc5 = mean(Yc5{1,1});
Yc6 = Yc(6);
Yc6 = mean(Yc6{1,1});

Ycsd = std([Yc1 Yc2 Yc3 Yc4 Yc5 Yc6]);
Ycmed1 = median([Yc1 Yc2 Yc3 Yc4 Yc5 Yc6]);
% then this mean every line of Y must depen don this Y median

Yc1 = Yc(15);
Yc1 = mean(Yc1{1,1});
Yc2 = Yc(16);
Yc2 = mean(Yc2{1,1});
Yc3 = Yc(17);
Yc3 = mean(Yc3{1,1});
Yc4 = Yc(18);
Yc4 = mean(Yc4{1,1});
Yc5 = Yc(19);
Yc5 = mean(Yc5{1,1});
Yc6 = Yc(20);
Yc6 = mean(Yc6{1,1});

Ycmed1 = median([Yc1 Yc2 Yc3 Yc4 Yc5 Yc6]);
% How can I know when will it seperate line