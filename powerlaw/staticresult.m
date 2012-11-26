clear all;clc;

curve=load(['staticCurve.dat']);
plot(curve(:,1),curve(:,2))
xlabel('True Strain')
ylabel('True Stress')
title('True Stress - True Strain')

hold on
x=0:0.005:0.15;
%plot(x,1340*power(x,0.05))
plot(x,1300*power(x,0.042))
%plot(x,1260*power(x,0.055))      

