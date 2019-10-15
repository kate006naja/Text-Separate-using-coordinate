%% readtfile.m
function [Xc, Yc, Zc, segCount, txt_list] = readtfile(tfile)
% READTFILE function will create a list of text coordinate
% which are x, y and z coordinate of text from quill editor
% and will output it cell and it segment count.

% Process the input parameter
fo = fopen(tfile, 'r');
raw_text = fscanf(fo, '%c');
txt_list = strsplit(raw_text, '\n');

Xc = cell(1);
Yc = cell(1);
Zc = cell(1);
segCount = 0;
for el = txt_list % el = each line of text file
   tmp = char(el); % make each line a character
   if tmp(1) == 'N'
       if segCount > 0 % count per 1 segment
           % Contain X, Y, Z of each segment
           Xc(segCount) = {X}; 
           Yc(segCount) = {Y};
           Zc(segCount) = {Z};
           % finish these it mean X2 x of all segment at cell 
           % by 344 column and each column contain each segment
           % and each segment contain their own variable(x or y or z)
       end
       segCount = segCount + 1;
       X = []; % to discard old variable
       Y = [];
       Z = [];
   end
   
   % this are step of data cleaning (strip and split)
   if tmp(1) == '('
       strip_left  = strip(el, '(');
       cleaned = strip(strip_left, ')');
       splited = split(cleaned, ', ');
       X(end+1) = str2double(splited(1));
       Y(end+1) = str2double(splited(2));
       Z(end+1) = str2double(splited(3));
   end
end
    