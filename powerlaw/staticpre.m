dat=load('..\filter\static.dat');

strain=log(1+dat(:,1));
stress=dat(:,2).*(1+dat(:,1));
start=1;
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

plot(curve(:,1),curve(:,2))
xlabel('True Strain')
ylabel('True Stress')
title('True Stress - True Strain')

fid=fopen('staticCurve.dat','w');
for k=1:size(curve)
    fprintf(fid,'%10.8f  %10.8f\n',curve(k,1),curve(k,2));
end
fclose(fid);

staStrain=0.022:0.002:0.1;
staStress=interp1(curve(:,1),curve(:,2),staStrain);
fid=fopen(['staticPoint.dat'],'w');
for j=1:size(staStress')
    fprintf(fid,'%10.8f  %10.8f\n',staStrain(j),staStress(j));
end
fclose(fid);
%clear all;
