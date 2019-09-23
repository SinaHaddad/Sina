clc
clear
nr = 50;
nc = 50;
n  = nr*nc; 
Lx = 0.1;   %meter
Ly = 0.2;   %meter

Tu = 20;
Tr = 100;
Td = 200;
T_All=[Tu Tr Td];
A = zeros(n);
B = zeros(n,1);

for i=1:n
    if i== 1
        A(i,i) = 1;
        B(i)   = Tu;
    elseif i== nr
        A(i,i) = 1;
        B(i)   = Td;
    elseif i== n
        A(i,i) = 1;
        B(i)   = mean([Tr Td]);
    elseif i== n-nr+1
        A(i,i) = 1;
        B(i)   = mean([Tu Tr]);
    elseif rem(i,nr)== 0
        A(i,i) = 1;
        B(i)   = Td;
    elseif i>n-nr+1 && i<n
        A(i,i) = 1;
        B(i)   = Tr;
    elseif rem(i,nr)== 1
        A(i,i) = 1;
        B(i)   = Tu;
    elseif i>1 && i<nr
        A(i,[i i+1 i-1 i+nr])=[4 -1 -1 -2];
    else
        A(i,[i i+1 i-1 i+nr i-nr])=[4 -1 -1 -1 -1];
    end
end
T = A\B;
T = reshape(T,nr,nc);
x=linspace(0,Lx,nc);
y=linspace(0,Ly,nr);
[X,Y]=meshgrid(x,y);
figure(1)
colormap jet
contourf(X,Y,T(end:-1:1,:),100,'linestyle','none')
axis equal

figure(2)
contour(X,Y,T(end:-1:1,:),min(T_All):10:max(T_All),'color',[0 0 0],'showtext','on')


