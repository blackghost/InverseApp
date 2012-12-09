
% Generate static curve, point
dat=load('preStatic.dat');
strain=log(1+dat(:,1));
stress=dat(:,2).*(1+dat(:,1));
eqplStrain=strain-stress/210000;
start=1;
switch constitutive
    case 1
        for iStart=1:size(strain)-1
            if(eqplStrain(iStart)<0&&eqplStrain(iStart+1)>0)
                start=iStart;
            end
        end
        curve(1,1)=0;
        curve(1,2)=stress(start);
        point=1;
        for iPoint=start:size(strain)
            if(eqplStrain(iPoint)>curve(point,1))
                point=point+1;
                curve(point,1)=eqplStrain(iPoint);
                curve(point,2)=stress(iPoint);
            end
        end
    case 2
        for iStart=1:size(strain)-1
            if(strain(iStart)<0&&strain(iStart+1)>0)
                start=iStart;
            end
        end
        curve(1,1)=0;
        curve(1,2)=stress(start);
        point=1;
        for iPoint=start:size(strain)
            if(strain(iPoint)>curve(point,1))
                point=point+1;
                curve(point,1)=strain(iPoint);
                curve(point,2)=stress(iPoint);
            end
        end
end

fid=fopen('staticCurve.dat','w');
for k=1:size(curve)
	fprintf(fid,'%10.8f  %10.8f\n',curve(k,1),curve(k,2));
end
fclose(fid);
    
staStrain=0.02:0.002:0.08;
staStress=interp1(curve(:,1),curve(:,2),staStrain);
fid=fopen('staticPoint.dat','w');
for j=1:size(staStress')
    fprintf(fid,'%10.8f  %10.8f\n',staStrain(j),staStress(j));
end
fclose(fid);

clear curve dat st* eqpl* i* point k j

% Static parameter inverse
nvars=2;
lb=[400 0.05];
ub=[1600 0.6];

options = gaoptimset;
options = gaoptimset(options,'Display' ,'off');

switch constitutive
    case 1
        sta=@(x) funcstaticjc(x,a);
    case 2
        sta=@(x) funcstaticcs(x);
end
[bn,fval,exitflag,output,population,score] = ...
    ga(sta,nvars,[],[],[],[],lb,ub,[],options);
clear nvars lb ub options fval exitflag output population score

% Generate dynamic curve, point
for vel=1:nvel
    for expr=1:2
        dat=load(['filteredDynamic',num2str(vel),num2str(expr),'.dat']);
        strain=log(1+dat(:,1));
        stress=dat(:,2).*(1+dat(:,1));
        eqplStrain=strain-stress/210000;
        start=1;
        switch constitutive
            case 1
                for iStart=1:size(strain)-1
                    if(eqplStrain(iStart)<0&&eqplStrain(iStart+1)>0)
                        start=iStart;
                    end
                end
                curve(1,1)=0;
                curve(1,2)=stress(start);
                point=1;
                for iPoint=start:size(strain)
                    if(eqplStrain(iPoint)>curve(point,1))
                        point=point+1;
                        curve(point,1)=eqplStrain(iPoint);
                        curve(point,2)=stress(iPoint);
                    end
                end
            case 2
                for iStart=1:size(strain)-1
                    if(strain(iStart)<0&&strain(iStart+1)>0)
                        start=iStart;
                    end
                end
                curve(1,1)=0;
                curve(1,2)=stress(start);
                point=1;
                for iPoint=start:size(strain)
                    if(strain(iPoint)>curve(point,1))
                        point=point+1;
                        curve(point,1)=strain(iPoint);
                        curve(point,2)=stress(iPoint);
                    end
                end
        end
        
        fid=fopen(['dynamicCurve',num2str(vel),num2str(expr),'.dat'],'w');
        for k=1:size(curve)
            fprintf(fid,'%10.8f  %10.8f\n',curve(k,1),curve(k,2));
        end
        fclose(fid);

        dyStrain=0.022:0.002:0.1;
        dyStress=interp1(curve(:,1),curve(:,2),dyStrain);
        fid=fopen(['dynamicPoint',num2str(vel),num2str(expr),'.dat'],'w');
        for j=1:size(dyStress')
            fprintf(fid,'%10.8f  %10.8f\n',dyStrain(j),dyStress(j));
        end
        fclose(fid);
        clear curve;
    end
end
clear curve dat st* eqpl* i* point k j dy* vel expr

% Dynamic parameter inverse
PopulationSize_Data=60;
options = gaoptimset;
options = gaoptimset(options,'PopulationSize' ,PopulationSize_Data);
options = gaoptimset(options,'Display' ,'off');
options = gaoptimset(options,'PlotFcns' ,{ @gaplotpareto });
options = gaoptimset(options,'OutputFcns' ,{ [] });
switch constitutive
    case 1
        nvars=1;
        lb=0.001;
        ub=0.02;
        dyn=@(x) funcdynamicjc(x,a,bn,nvel,rate);
    case 2
        nvars=2;
        lb=[40 0.01];
        ub=[8000 8];
        dyn=@(x) funcdynamiccs(x,bn,nvel,rate);
end
[xc,fval,exitflag,output,population,score] = ...
gamultiobj(dyn,nvars,[],[],[],[],lb,ub,options);

% Determine the best C
format long
[n,m]=size(xc);
f1=min(fval(:,1));
f2=min(fval(:,2));
for i=1:n
    d(i)=sqrt((fval(i,1)-f1)^2+(fval(i,2)-f2)^2);
end
[mind,imind]=min(d);
c=xc(imind,:);


