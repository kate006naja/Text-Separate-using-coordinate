xer = [];
yer = [];
for i = 1:70
    t = Erx(i);
    X = t{1, 1};
    xer = horzcat(xer, X);
    
    t = Ery(i);
    Y = t{1, 1};
    yer = horzcat(yer, Y);
end

figure(2);
plot(xer, yer, '*');
figure(3); plot(meankeep);
hold on
plot(meankeep, '*');