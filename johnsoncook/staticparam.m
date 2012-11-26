function f = staticparam(x)

data=load('staticPoint.dat');
strain=data(:,1);
stress=data(:,2);

fit=765+x(1)*power(strain,x(2));

f=sum((fit-stress).^2);



        
        
