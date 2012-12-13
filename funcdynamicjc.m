function f = funcdynamicjc(x,a,bn,nvel,rate)
% Function called by Multi-Objective Genetic Algorithm(gamultiobj) to inverse the parameter C of
% Johnson-Cook model
%
% INPUT
% x          Design variable of gamultiobj
% a          Parameter A of Johnson-Cook model
% bn        Parameter B,n of Johnson-Cook model
% nvel      Number of experiment velocity 
% rate      Strain-rate of dynamic tensile test 
%
% OUTPUT
% f          Fitness of gamultiobj

epsilon_0=0.001;        % Parameter epsilon_0 of Johnson-Cook model
strain=(0.022:0.002:0.1)';      % Inverse Interval

exp11=load('dynamicPoint11.dat');
exp12=load('dynamicPoint12.dat');
fit11=(a+bn(1)*power(strain,bn(2)))*(1+x*log(rate(1,1)/epsilon_0));
fit12=(a+bn(1)*power(strain,bn(2)))*(1+x*log(rate(1,2)/epsilon_0));
fitmean1=(a+bn(1)*power(strain,bn(2)))*(1+x*log(rate(1,3)/epsilon_0));
expmean1=(exp11(:,2)+exp12(:,2))/2;
f(1)=sqrt(sum((fitmean1-exp11(:,2)).^2+(fitmean1-exp12(:,2)).^2)/39);
f(2)=sqrt(sum((fit11-expmean1).^2+(fit12-expmean1).^2)/39);

if(nvel>=2)
    exp21=load('dynamicPoint21.dat');
    exp22=load('dynamicPoint22.dat');
    fit21=(a+bn(1)*power(strain,bn(2)))*(1+x*log(rate(2,1)/epsilon_0));
    fit22=(a+bn(1)*power(strain,bn(2)))*(1+x*log(rate(2,2)/epsilon_0));
    fitmean2=(a+bn(1)*power(strain,bn(2)))*(1+x*log(rate(2,3)/epsilon_0));
    expmean2=(exp21(:,2)+exp22(:,2))/2;
    f(1)=f(1)+sqrt(sum((fitmean2-exp21(:,2)).^2+(fitmean2-exp22(:,2)).^2)/39);
    f(2)=f(1)+sqrt(sum((fit21-expmean2).^2+(fit22-expmean2).^2)/39);
end

if(nvel>=3)
    exp31=load('dynamicPoint31.dat');
    exp32=load('dynamicPoint32.dat');
    fit31=(a+bn(1)*power(strain,bn(2)))*(1+x*log(rate(3,1)/epsilon_0));
    fit32=(a+bn(1)*power(strain,bn(2)))*(1+x*log(rate(3,2)/epsilon_0));
    fitmean3=(a+bn(1)*power(strain,bn(2)))*(1+x*log(rate(3,3)/epsilon_0));
    expmean3=(exp31(:,2)+exp32(:,2))/2;
    f(1)=f(1)+sqrt(sum((fitmean3-exp31(:,2)).^2+(fitmean3-exp32(:,2)).^2)/39);
    f(2)=f(1)+sqrt(sum((fit31-expmean3).^2+(fit32-expmean3).^2)/39);
end

if(nvel>=4)
    exp41=load('dynamicPoint41.dat');
    exp42=load('dynamicPoint42.dat');
    fit41=(a+bn(1)*power(strain,bn(2)))*(1+x*log(rate(4,1)/epsilon_0));
    fit42=(a+bn(1)*power(strain,bn(2)))*(1+x*log(rate(4,2)/epsilon_0));
    fitmean4=(a+bn(1)*power(strain,bn(2)))*(1+x*log(rate(4,3)/epsilon_0));
    expmean4=(exp41(:,2)+exp42(:,2))/2;
    f(1)=f(1)+sqrt(sum((fitmean4-exp41(:,2)).^2+(fitmean4-exp42(:,2)).^2)/39);
    f(2)=f(1)+sqrt(sum((fit41-expmean4).^2+(fit42-expmean4).^2)/39);
end

if(nvel>=5)
    exp51=load('dynamicPoint51.dat');
    exp52=load('dynamicPoint52.dat');
    fit51=(a+bn(1)*power(strain,bn(2)))*(1+x*log(rate(5,1)/epsilon_0));
    fit52=(a+bn(1)*power(strain,bn(2)))*(1+x*log(rate(5,2)/epsilon_0));
    fitmean5=(a+bn(1)*power(strain,bn(2)))*(1+x*log(rate(5,3)/epsilon_0));
    expmean5=(exp51(:,2)+exp52(:,2))/2;
    f(1)=f(1)+sqrt(sum((fitmean5-exp51(:,2)).^2+(fitmean5-exp52(:,2)).^2)/39);
    f(2)=f(1)+sqrt(sum((fit51-expmean5).^2+(fit52-expmean5).^2)/39);
end

if(nvel>=6)
    exp61=load('dynamicPoint61.dat');
    exp62=load('dynamicPoint62.dat');
    fit61=(a+bn(1)*power(strain,bn(2)))*(1+x*log(rate(6,1)/epsilon_0));
    fit62=(a+bn(1)*power(strain,bn(2)))*(1+x*log(rate(6,2)/epsilon_0));
    fitmean6=(a+bn(1)*power(strain,bn(2)))*(1+x*log(rate(6,3)/epsilon_0));
    expmean6=(exp61(:,2)+exp62(:,2))/2;
    f(1)=f(1)+sqrt(sum((fitmean6-exp61(:,2)).^2+(fitmean6-exp62(:,2)).^2)/39);
    f(2)=f(1)+sqrt(sum((fit61-expmean6).^2+(fit62-expmean6).^2)/39);
end        
