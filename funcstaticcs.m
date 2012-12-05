
% Function to caculate static parameter
function f = funcstaticcs(x)
data=load('staticPoint.dat');
strain=data(:,1);
stress=data(:,2);
fit=x(1)*power(strain,x(2));
f=sqrt(sum((fit-stress).^2)/30);



        
        
