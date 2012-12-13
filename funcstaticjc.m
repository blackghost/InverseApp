function f = funcstaticjc(x,a)
% Function called by Genetic Algorithm(ga) to inverse static parameter B,n of Johnson-Cook Model
%
% INPUT
% x          Design variable of ga
% a          Parameter A of Johnson-Cook model
%
% OUTPUT
% f          Fitness of ga

data=load('staticPoint.dat');
strain=data(:,1);
stress=data(:,2);
fit=a+x(1)*power(strain,x(2));
f=sqrt(sum((fit-stress).^2)/30);





        
        
