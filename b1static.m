
% Get static tensile result
clc;
[FileName,PathName] = uigetfile('*.csv','Select the excel-file of static tensile experiment')
whos FileName
whos PathName
staticraw=importdata([PathName,FileName], ',', 2);
dat=staticraw.data;
strain=dat(:,3);
stress=dat(:,4);
fid=fopen('preStatic.dat','w');
for i=1:size(dat)
    fprintf(fid,'%10.8f  %10.8f\n',strain(i),stress(i));
end
fclose(fid);
clear FileName PathName staticraw dat strain stress i

% Find the yield point
a=load('preStatic.dat');
for i=1:length(a)
    if(a(i,1)<0.002 && a(i+1)>=0.002)
        yielda=i;
    end
    if(a(i,1)<0.01 && a(i+1)>=0.01)
        yieldb=i;
        break
    end
end
for x=yielda:yieldb
    y1=210000*(a(x,1)-0.002);
    y2=210000*(a(x+1,1)-0.002);
    if((a(x,2)-y1)*(a(x+1,2)-y2)<=0)
        yield=a(x,2)+(a(x+1,2)-a(x,2))*abs(a(x,2)-y1)/(abs(a(x,2)-y1)+abs(a(x+1,2)-y2));
        break;
    end
end
clear a i yielda yieldb x y1 y2

