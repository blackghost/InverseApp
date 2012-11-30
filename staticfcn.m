

function f = staticfcn(x,a)
data=load('staticPoint.dat');
strain=data(:,1);
stress=data(:,2);
fit=a+x(1)*power(strain,x(2));
f=sqrt(sum((fit-stress).^2)/30);





        
        
