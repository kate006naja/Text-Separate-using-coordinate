
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

