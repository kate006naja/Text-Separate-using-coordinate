% invY.m
function [Yci] = invY(Yc, sgC)
% INVY is happen because when I store Y the Y data are its inverse
% so I want to converse it to normally form and can eaily plot it
for i = 1:sgC-1 % Plotting in every segment
   
   t = Yc(i); % Store each segment of 'y' into each column of cell
   Y = t{1,1}; 
   Y = 1-Y;
   t{1,1} = Y;
   %aaa = num2cell(t{1,1});
   Yc(i) = t;
   % wait for me to fix 1-Y in main code
   
end
Yci = Yc;
end