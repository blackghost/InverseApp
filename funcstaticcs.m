function f = funcstaticcs(x)
% Function called by Genetic Algorithm(ga) to inverse static parameter k,n of Cowper-Symonds Model
%
% INPUT
% x          Design variable of ga
%
% OUTPUT
% f          Fitness of ga

data=load('staticPoint.dat');
strain=data(:,1);
stress=data(:,2);
fit=x(1)*power(strain,x(2));
f=sqrt(sum((fit-stress).^2)/30);



        
        
