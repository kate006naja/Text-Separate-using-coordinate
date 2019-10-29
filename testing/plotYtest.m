% This part is plotting.
figure(2);
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
   pause(0.005);
   if i ~= 0, hold on; end
end
% still some error in file 3(which have many space)
% and file 5 which have too large space
for i = sepline
    xxx = Xc(i);
    yyy = Yci(i);
    plot(xxx{1, 1}, yyy{1, 1}, '*');
end


xer = [];
yer = [];
for i = 1:linecount-1
    t = Erx(i);
    X = t{1, 1};
    xer = horzcat(xer, X);
    
    t = Ery(i);
    Y = t{1, 1};
    yer = horzcat(yer, Y);
end
%figure();
plot(xer, yer, '*'); % to see where new line start
figure(3); plot(meankeep);
hold on
plot(meankeep, '*'); % this is the way to plot line