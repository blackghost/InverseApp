function f = dynamicparam(x)

x1=765;
x2=600;
x3=0.14;
epsilon_0=0.001;
strain=(0.022:0.002:0.1)';

exp11=load('dynamicPoint11.dat');
exp12=load('dynamicPoint12.dat');
fit11=(x1+x2*power(strain,x3))*(1+x*log(23/epsilon_0));
fit12=(x1+x2*power(strain,x3))*(1+x*log(23/epsilon_0));
fitmean1=(x1+x2*power(strain,x3))*(1+x*log(23/epsilon_0));
expmean1=(exp11(:,2)+exp12(:,2))/2;

exp21=load('dynamicPoint21.dat');
exp22=load('dynamicPoint22.dat');
fit21=(x1+x2*power(strain,x3))*(1+x*log(43/epsilon_0));
fit22=(x1+x2*power(strain,x3))*(1+x*log(45/epsilon_0));
fitmean2=(x1+x2*power(strain,x3))*(1+x*log(44/epsilon_0));
expmean2=(exp21(:,2)+exp22(:,2))/2;

exp31=load('dynamicPoint31.dat');
exp32=load('dynamicPoint32.dat');
fit31=(x1+x2*power(strain,x3))*(1+x*log(174/epsilon_0));
fit32=(x1+x2*power(strain,x3))*(1+x*log(138/epsilon_0));
fitmean3=(x1+x2*power(strain,x3))*(1+x*log(156/epsilon_0));
expmean3=(exp31(:,2)+exp32(:,2))/2;

exp41=load('dynamicPoint41.dat');
exp42=load('dynamicPoint42.dat');
fit41=(x1+x2*power(strain,x3))*(1+x*log(338/epsilon_0));
fit42=(x1+x2*power(strain,x3))*(1+x*log(324/epsilon_0));
fitmean4=(x1+x2*power(strain,x3))*(1+x*log(331/epsilon_0));
expmean4=(exp41(:,2)+exp42(:,2))/2;

exp51=load('dynamicPoint51.dat');
exp52=load('dynamicPoint52.dat');
fit51=(x1+x2*power(strain,x3))*(1+x*log(514/epsilon_0));
fit52=(x1+x2*power(strain,x3))*(1+x*log(536/epsilon_0));
fitmean5=(x1+x2*power(strain,x3))*(1+x*log(525/epsilon_0));
expmean5=(exp51(:,2)+exp52(:,2))/2;

f(1)=sqrt(sum((fitmean1-exp11(:,2)).^2+(fitmean1-exp12(:,2)).^2)/39)+sqrt(sum((fitmean2-exp21(:,2)).^2+(fitmean2-exp22(:,2)).^2)/39)+sqrt(sum((fitmean3-exp31(:,2)).^2+(fitmean3-exp32(:,2)).^2)/39)+sqrt(sum((fitmean4-exp41(:,2)).^2+(fitmean4-exp42(:,2)).^2)/39)+sqrt(sum((fitmean5-exp51(:,2)).^2+(fitmean5-exp52(:,2)).^2)/39);
f(2)=sqrt(sum((fit11-expmean1).^2+(fit12-expmean1).^2)/39)+sqrt(sum((fit21-expmean2).^2+(fit22-expmean2).^2)/39)+sqrt(sum((fit31-expmean3).^2+(fit32-expmean3).^2)/39)+sqrt(sum((fit41-expmean4).^2+(fit42-expmean4).^2)/39)+sqrt(sum((fit51-expmean5).^2+(fit52-expmean5).^2)/39);


        
        
