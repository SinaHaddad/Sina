clc
clear
close all
nr = 50;
nc = 50;
n  = nr*nc;
Lx = 0.1;   %meter
Ly = 0.2;   %meter

Tu = 20;
Tr = 100;
Td = 100;
T_All=[Tu Tr Td];
T_old = ones(n,1)*20;
T_new = ones(n,1)*20;
e=1;
colormap jet
while e>0.05
    for i=1:n
        if i== 1
            T_new(i) = Tu;
        elseif i== nr
            T_new(i) = Td;
        elseif i== n
            T_new(i) = mean([Tr Td]);
        elseif i== n-nr+1
            T_new(i) = mean([Tr Tu]);
        elseif rem(i,nr)== 0
            T_new(i) = Td;
        elseif i>n-nr+1 && i<n
            T_new(i) = Tr;
        elseif rem(i,nr)== 1
            T_new(i) = Tu;
        elseif i>1 && i<nr
            T_new(i) = (T_new(i+1)+T_new(i-1)+2*T_new(i+nr))/4;
        elseif i==225
            T_new(i) = 200;
        else
            T_new(i) = (T_new(i+1)+T_new(i-1)+T_new(i+nr)+T_new(i-nr))/4;
        end
    end
    e = max(abs(T_new-T_old));
    T=reshape(T_new,nr,nc);
    contourf(T(end:-1:1,:),100,'linestyle','none')
    T_old = T_new;
    drawnow
end


