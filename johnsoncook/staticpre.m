dat=load('..\filter\static.dat')

strain=log(1+dat(:,1));
stress=dat(:,2).*(1+dat(:,1));
eqplStrain=strain-stress/210000;
start=1;
for iStart=1:size(strain)-1
	if(eqplStrain(iStart)<0&&eqplStrain(iStart+1)>0)
		start=iStart;
	end
end
curve(1,1)=eqplStrain(start);
curve(1,2)=stress(start);
point=1;
for iPoint=start:size(strain)
	if(eqplStrain(iPoint)>curve(point,1))
		point=point+1;
		curve(point,1)=eqplStrain(iPoint);
		curve(point,2)=stress(iPoint);
	end
end

plot(curve(:,1),curve(:,2))
xlabel('Equivalent Plastic Strain')
ylabel('True Stress')
title('True Stress - Equivalent Plastic Strain')

staStrain=0.022:0.002:0.1;
staStress=interp1(curve(:,1),curve(:,2),staStrain);
fid=fopen(['staticPoint.dat'],'w');
for j=1:size(staStress')
    fprintf(fid,'%10.8f  %10.8f\n',staStrain(j),staStress(j));
end
fclose(fid);
%clear all;

