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

    plot(curve(:,1),curve(:,2))
    hold on
    xlabel('Equivalent Plastic Strain')
    ylabel('True Stress')
    title('True Stress - Equivalent Plastic Strain')
    clear all;
end

epso=0.001
e=0:0.002:0.16;
plot(e,(765+600*power(e,0.14))*(1+0.0086*log(23/epso)),e,(765+600*power(e,0.14))*(1+0.0086*log(44/epso)),e,(765+600*power(e,0.14))*(1+0.0086*log(156/epso)),e,(765+600*power(e,0.14))*(1+0.0086*log(331/epso)),e,(765+600*power(e,0.14))*(1+0.0086*log(525/epso)))




        
        
