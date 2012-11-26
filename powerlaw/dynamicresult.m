clear all;clc;

files=[11,12,21,22,31,32,41,42,51,52];
for i=1:size(files')
    files=[11,12,21,22,31,32,41,42,51,52];
    curve=load(['dynamicCurve',num2str(files(i)),'.dat']);
    plot(curve(:,1),curve(:,2))
    hold on
    xlabel('True Strain')
    ylabel('True Stress')
    title('True Stress - True Strain')
    clear all;
end

x=[7800 1.89];
k=1300;
n=0.042;
epso=0.001;
e=0:0.002:0.32;

plot(e,k*power(e,n)*(1+power(23/x(1),1/x(2))),e,k*power(e,n)*(1+power(44/x(1),1/x(2))),e,k*power(e,n)*(1+power(156/x(1),1/x(2))),e,k*power(e,n)*(1+power(331/x(1),1/x(2))),e,k*power(e,n)*(1+power(525/x(1),1/x(2))));



        
        
