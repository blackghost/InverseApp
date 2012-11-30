dat=load('preStatic.dat');

strain=log(1+dat(:,1));
stress=dat(:,2).*(1+dat(:,1));
eqplStrain=strain-stress/210000;
start=1;
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

% plot(curve(:,1),curve(:,2))
% xlabel('Equivalent Plastic Strain')
% ylabel('True Stress')
% title('True Stress - Equivalent Plastic Strain')

fid=fopen('staticCurve.dat','w');
for k=1:size(curve)
	fprintf(fid,'%10.8f  %10.8f\n',curve(k,1),curve(k,2));
end
fclose(fid);
    
staStrain=0.02:0.002:0.08;
staStress=interp1(curve(:,1),curve(:,2),staStrain);
fid=fopen(['staticPoint.dat'],'w');
for j=1:size(staStress')
    fprintf(fid,'%10.8f  %10.8f\n',staStrain(j),staStress(j));
end
fclose(fid);

clear curve dat st* eqpl* i* point k j

% static parameter inverse
nvars=2;
lb=[400 0.05];
ub=[1600 0.6];

% Start with the default options
options = gaoptimset;
% Modify options setting
options = gaoptimset(options,'Display' ,'off');

sta=@(x) staticfcn(x,a);
[bn,fval,exitflag,output,population,score] = ...
    ga(sta,nvars,[],[],[],[],lb,ub,[],options);
bn
clear nvars lb ub options fval exitflag output population score

% Display the static parameter inverse result
% curve=load('staticCurve.dat');
% plot(curve(:,1),curve(:,2))
% xlabel('Equivalent Plastic Strain')
% ylabel('True Stress')
% title('True Stress - Equivalent Plastic Strain')
% hold on
% 
% plot(curve(:,1),yield+x(1)*power(curve(:,1),x(2)))
% clear curve  

%clear all;

for vel=1:5
    for expr=1:2
        dat=load(['filteredDynamic',num2str(vel),num2str(expr),'.dat']);
        strain=log(1+dat(:,1));
        stress=dat(:,2).*(1+dat(:,1));
        eqplStrain=strain-stress/210000;
        start=1;
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

%         figure(vel*10+expr)
%         plot(curve(:,1),curve(:,2))
%         xlabel('Equivalent Plastic Strain')
%         ylabel('True Stress')
%         title('True Stress - Equivalent Plastic Strain')

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

nvars=1;
lb=0.001;
ub=0.02;
PopulationSize_Data=60;

% Start with the default options
options = gaoptimset;
% Modify options setting
options = gaoptimset(options,'PopulationSize' ,PopulationSize_Data);
options = gaoptimset(options,'Display' ,'off');
options = gaoptimset(options,'PlotFcns' ,{ @gaplotpareto });
options = gaoptimset(options,'OutputFcns' ,{ [] });
dy=@(x) dynamicfcn(x,a,bn);
[xc,fval,exitflag,output,population,score] = ...
gamultiobj(dy,nvars,[],[],[],[],lb,ub,options);

format long
[n,m]=size(xc);
f1=min(fval(:,1));
f2=min(fval(:,2));
for i=1:n
    d(i)=sqrt((fval(i,1)-f1)^2+(fval(i,2)-f2)^2);
end
[mind,imind]=min(d);
c=xc(imind)
disp('The Parameter of Johnson-Cook Model is:')
disp(['A=',num2str(a),', B=',num2str(bn(1)),', n=',num2str(bn(2)),', C=',num2str(c),'.'])



% for vel=1:nvel
%     for expr=1:2
%         curve=load(['dynamicCurve',num2str(vel),num2str(expr),'.dat']);
%         plot(curve(:,1),curve(:,2))
%         hold on
%         xlabel('Equivalent Plastic Strain')
%         ylabel('True Stress')
%         title('True Stress - Equivalent Plastic Strain')
%         clear curve;
%     end
% end
% 
% epso=0.001;
% e=0:0.002:0.16;
% plot(e,(yield+x(1)*power(e,x(2)))*(1+c*log(23/epso)),e,(yield+x(1)*power(e,x(2)))*(1+c*log(44/epso)),e,(yield+x(1)*power(e,x(2)))*(1+c*log(156/epso)),e,(yield+x(1)*power(e,x(2)))*(1+c*log(331/epso)),e,(yield+x(1)*power(e,x(2)))*(1+c*log(525/epso)))
% 

