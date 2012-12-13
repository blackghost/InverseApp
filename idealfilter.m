% Ideal Low pass filter
for vel=1:nvel
    for expr=1:2
        
        % FFT transformation 
        dat=load(['preDynamic',num2str(vel),num2str(expr),'.dat']);
        time=dat(:,1);
        strain=dat(:,2);
        y=dat(:,3);
        for i=1:10
            if(length(y)/power(2,i)==1)
                N=length(y);
            elseif(length(y)/power(2,i)>1&&length(y)/power(2,i+1)<1)
                N=power(2,i+1);
                break;
            end
        end
        n=0:N-1;
        t=time(2)-time(1);
        f=n/t/N;
        ffty=fft(y,N);
        absffty=abs(ffty);
        
        % Ideal Low pass filter,set high frequency magnitude to zero,then
        % Inverse FFT transformation
        for iPoint=1:N/2
            if(absffty(iPoint)<=500)
                ffty(iPoint:N-iPoint+2)=0i;
                break;
            end
        end
        y2=real(ifft(ffty));
        stress=y2(1:length(y));
        
        % Save filtered data to filtered*.dat file
        strain(1)=0;
        stress(1)=0;
        fidout=fopen(['filteredDynamic',num2str(vel),num2str(expr),'.dat'],'w');
        for iFile=1:length(y)
            fprintf(fidout,'%10.8f  %10.8f\n',strain(iFile),stress(iFile));
        end
        fclose(fidout);
    end
end
clear vel expr dat time strain y i N n t f ffty absffty iPoint y2 stress iFile