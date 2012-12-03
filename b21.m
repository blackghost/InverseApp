
% Preprocess the dynamic tensile result
[FileName,PathName] = uigetfile('*.dat','Select all the dynamic tensile dat-file','MultiSelect', 'on');
nvel=length(FileName)/2;
for vel=1:nvel
    for expr=1:2
        fidin=fopen(FileName{2*(vel-1)+expr},'r');
        for i=1:16
            strline=fgets(fidin);
        end
        area=str2num(strline(13:21));
        fclose(fidin);

        dynamicraw=importdata(FileName{2*(vel-1)+expr}, '\t', 54);
        dat=dynamicraw.data;
        time=dat(:,1);
        stress=dat(:,4)*1000/area;
        strain=dat(:,13)/100;
        strainrate=dat(:,14);
        [row,column]=size(dat);
        fidout=fopen(['preDynamic',num2str(vel),num2str(expr),'.dat'],'w');
        for i=1:row-1
            if(strain(i+1)~=strain(i))
                fprintf(fidout,'%10.8f  %10.8f  %10.8f  %10.8f\n',time(i),strain(i),stress(i),strainrate(i));
            end
        end
        fclose(fidout);
    end
end
clear area dynamicraw dat time stress strain strainrate i vel expr

% Caculate the strainrates
for vel=1:nvel
    for expr=1:2
        dat=load(['preDynamic',num2str(vel),num2str(expr),'.dat']);
        dat(:,2)=abs(dat(:,2));
        rate(vel,expr)=trapz(dat(1:length(dat),1),dat(1:length(dat),4))/(dat(length(dat),1)-dat(1,1));
    end
    rate(vel,3)=(rate(vel,1)+rate(vel,2))/2;
end
rate=round(rate);
clear dat vel expr