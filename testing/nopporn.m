lx = length(Xc);
Mx = zeros(lx, 3);
My = zeros(lx, 3);
for i = 1:lx,
   Mx(i,1) = mean(Xc{i});
   Mx(i,2) = min(Xc{i});
   Mx(i,3) = max(Xc{i});
   
   My(i,1) = mean(Yc{i});
   My(i,2) = min(Yc{i});
   My(i,3) = max(Yc{i});
end

LineNo = zeros(lx,1);
l = 0;
newline = 0;
maxy = My(1,3);
for i = 2:lx,
    if My(i, 2) > maxy,
        newline = newline + 1;
        if newline > 2, 
            l = l + 1;
            newline = 0;
            maxy = My(i,3);
            LineNo(i-2:i,1) = l;
        else,
            LineNo(i,1) = l;
        end
    else,
        newline = 0;
        LineNo(i,1)= l;
    end

end


