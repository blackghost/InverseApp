clc;clear all;

files=[11,12,21,22,31,32,41,42,51,52];

for i=1:size(files')
    files=[11,12,21,22,31,32,41,42,51,52];
    dat=load(['..\filter\dynamic',num2str(files(i)),'.dat']);
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

    figure(files(i))
    plot(curve(:,1),curve(:,2))
    xlabel('Equivalent Plastic Strain')
    ylabel('True Stress')
    title('True Stress - Equivalent Plastic Strain')

    fid=fopen(['dynamicCurve',num2str(files(i)),'.dat'],'w');
    for k=1:size(curve)
        fprintf(fid,'%10.8f  %10.8f\n',curve(k,1),curve(k,2));
    end
    fclose(fid);

    dyStrain=0.022:0.002:0.1;
    dyStress=interp1(curve(:,1),curve(:,2),dyStrain);
    fid=fopen(['dynamicPoint',num2str(files(i)),'.dat'],'w');
    for j=1:size(dyStress')
        fprintf(fid,'%10.8f  %10.8f\n',dyStrain(j),dyStress(j));
    end
    fclose(fid);
    clear all;
end


