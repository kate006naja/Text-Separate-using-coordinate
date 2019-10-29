% findline1.m
% using mean or median as a threshold

close all;
clear all;
clc;

%% open file and store value in cell
file = ("8.txt");
[Xc, Yc, Zc, segCount, txt_list] = readtfile(file);

% inversing Y value in its cell
[Yci] = invY(Yc, segCount);

%% run every segment

% variable store

game = 0; % var to seek if it able to find any threshold(for new line)
newh = 0; % var to find new threshold or just use old threshold
seeh = 0; % var to set if Ycmed is empty or not
tcount = 1; % var to pass through modular gate
linecount = 0;
Ery = cell(1);
Erx = cell(1);

Ycmed = []; % keep segment mean and the line mean
Ystd = []; % keep threshold std
tkeep = []; % keep each line mean
outline = []; % keep new line alert !


% this for decide wheter to find 
% new threshold or just keep running

for i = 1:segCount-1
    % this if are to find threshold
    if (game == 0)
        % this mean finding first threshold
        if (newh == 0)
            ccy1 = Yci(i); % seek into any new segment
            ccy1 = mean(ccy1{1, 1}); % mean of those segment
            Ycmed = horzcat(Ycmed, ccy1); % store each segment mean
            tcount = tcount + 1;
            
            % modular gate(this mean we found our threshold)
            if (mod(tcount, 4) == 0)
                Ystd = std(Ycmed);
                Ycmed = mean(Ycmed);
                tkeep = horzcat(tkeep, Ycmed);
                % set game = 1 so we can test the next segment
                game = 1;
            end
            
        % this mean finding new threshold of new line
        % will mod with the new i
        elseif (newh == 1)
            % set new Ycmed = 0 for beginning new threshold
            if (sum(Ycmed) ~= 0) && (seeh ~= 0)
                Ycmed = [];
                seeh = 0;
                % set new threshold
                
            % fix end
            end
                
            if (seeh == 0)
                % fix i + 1
                ccy2 = Yci(i);
                ccy2 = mean(ccy2{1, 1});
                Ycmed = horzcat(Ycmed, ccy2);
                tcount = tcount + 1;
                seeh = 0;
                if (mod(tcount,4) == 0)
                    Ystd = std(Ycmed);
                    Ycmed = mean(Ycmed);
                    disp('this is new threshold');
                    disp(Ycmed);
                    tkeep = horzcat(tkeep, Ycmed);
                    game = 1;
                end
            end
            % I must store new Ycmed
        end
        
    end
    % this is to keep running
    
    if (game == 1)
        % fix i + 1
        ccy2 = Yci(i);
        % ccy2 is our mean value of each segment
        ccy2 = mean(ccy2{1, 1});
        % this happen if we still in out line
        if (ccy2 >= (Ycmed-(3*Ystd))) && (ccy2 <= (Ycmed + (3*Ystd)))
            disp('this line still in the game');
            %disp(i);
            % the var after this line appear to be
            % game = 1
            % newh = 0
            % seeh = 0
            
        % this happen if the line is out of boundary
        elseif(ccy2 < (Ycmed - (3*Ystd))) || (ccy2 > (Ycmed + (3*Ystd)))
            disp('Ohoh new line alert')
            disp(i)
            % this keep the outline(line that not in the same line)
            % or where it not in the same line anymore
            outline = horzcat(outline, ccy2);
            
            linecount = linecount + 1;
            Erx(linecount) = Xc(i);
            Ery(linecount) = Yci(i);
            
            % set for new line threshold
            game = 0;
            newh = 1;
            seeh = 1;
        end
        
    end
end
disp(linecount)