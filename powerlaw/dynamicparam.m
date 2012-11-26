function f = dynamicparam(x)

k=1300;
n=0.042;
epsilon_0=0.001;
strain=(0.022:0.002:0.1)';

exp11=load('dynamicPoint11.dat');
exp12=load('dynamicPoint12.dat');
fit11=k*power(strain,n)*(1+power(23/x(1),1/x(2)));
fit12=k*power(strain,n)*(1+power(23/x(1),1/x(2)));
fitmean1=k*power(strain,n)*(1+power(23/x(1),1/x(2)));
expmean1=(exp11(:,2)+exp12(:,2))/2;

exp21=load('dynamicPoint21.dat');
exp22=load('dynamicPoint22.dat');
fit21=k*power(strain,n)*(1+power(43/x(1),1/x(2)));
fit22=k*power(strain,n)*(1+power(45/x(1),1/x(2)));
fitmean2=k*power(strain,n)*(1+power(44/x(1),1/x(2)));
expmean2=(exp21(:,2)+exp22(:,2))/2;

exp31=load('dynamicPoint31.dat');
exp32=load('dynamicPoint32.dat');
fit31=k*power(strain,n)*(1+power(174/x(1),1/x(2)));
fit32=k*power(strain,n)*(1+power(138/x(1),1/x(2)));
fitmean3=k*power(strain,n)*(1+power(156/x(1),1/x(2)));
expmean3=(exp31(:,2)+exp32(:,2))/2;

exp41=load('dynamicPoint41.dat');
exp42=load('dynamicPoint42.dat');
fit41=k*power(strain,n)*(1+power(338/x(1),1/x(2)));
fit42=k*power(strain,n)*(1+power(324/x(1),1/x(2)));
fitmean4=k*power(strain,n)*(1+power(331/x(1),1/x(2)));
expmean4=(exp41(:,2)+exp42(:,2))/2;

exp51=load('dynamicPoint51.dat');
exp52=load('dynamicPoint52.dat');
fit51=k*power(strain,n)*(1+power(514/x(1),1/x(2)));
fit52=k*power(strain,n)*(1+power(536/x(1),1/x(2)));
fitmean5=k*power(strain,n)*(1+power(525/x(1),1/x(2)));
expmean5=(exp51(:,2)+exp52(:,2))/2;

f(1)=sqrt(sum((fitmean1-exp11(:,2)).^2+(fitmean1-exp12(:,2)).^2)/49)+sqrt(sum((fitmean2-exp21(:,2)).^2+(fitmean2-exp22(:,2)).^2)/49)+sqrt(sum((fitmean3-exp31(:,2)).^2+(fitmean3-exp32(:,2)).^2)/49)+sqrt(sum((fitmean4-exp41(:,2)).^2+(fitmean4-exp42(:,2)).^2)/49)+sqrt(sum((fitmean5-exp51(:,2)).^2+(fitmean5-exp52(:,2)).^2)/49);
f(2)=sqrt(sum((fit11-expmean1).^2+(fit12-expmean1).^2)/49)+sqrt(sum((fit21-expmean2).^2+(fit22-expmean2).^2)/49)+sqrt(sum((fit31-expmean3).^2+(fit32-expmean3).^2)/49)+sqrt(sum((fit41-expmean4).^2+(fit42-expmean4).^2)/49)+sqrt(sum((fit51-expmean5).^2+(fit52-expmean5).^2)/49);

        
        
