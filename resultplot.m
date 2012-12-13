% Show the inverse result in axes1
selectidx=get(hObject,'Value');
switch selectidx
    case 1                  % Reset axes1
        axes(handles.axes1);
        xl=get(handles.axes1,'XLim');
        yl=get(handles.axes1,'YLim');
        cla 
        legend('off')
        set(handles.axes1,'XLim',xl);
        set(handles.axes1,'YLim',yl);
    case 2                  % static inverse result              
        dat=load('staticCurve.dat');
        strain=dat(:,1);
        stress=dat(:,2);
        switch constitutive
            case 1                  % Johnson-Cook model
                stressinv=matparam(1)+matparam(2)*power(strain,matparam(3));
            case 2                  % Cowper-Symonds model
                stressinv=matparam(1)*power(strain,matparam(2));
        end
        axes(handles.axes1);
        plot(strain,stress,'r',strain,stressinv,'b');
        legend('准静态实验','准静态反求',4);
        xlabel('塑性应变');
        ylabel('应力(Mpa)');
    case 3                  % velocity 1 inverse result
        dat11=load('dynamicCurve11.dat');
        strain11=dat11(:,1);
        stress11=dat11(:,2);
        dat12=load('dynamicCurve12.dat');
        strain12=dat12(:,1);
        stress12=dat12(:,2);
        strain=0:0.001:roundn(max(max(strain11(:,1)),max(strain12(:,1))),-3);
        switch constitutive
            case 1
                stressinv=(matparam(1)+matparam(2)*power(strain,matparam(3)))*(1+matparam(4)*log(rate(1,3)/epsilon_0));
            case 2
                stressinv=matparam(1)*power(strain,matparam(2))*(1+power(rate(1,3)/matparam(3),1/matparam(4)));
        end
        axes(handles.axes1);
        plot(strain11,stress11,'r',strain12,stress12,'g',strain,stressinv,'b');
        legend([plotlegend{1},'实验1'],[plotlegend{1},'实验2'],[plotlegend{1},'反求'],4);
        xlabel('塑性应变');
        ylabel('应力(Mpa)');
    case 4                  % velocity 2 inverse result
        dat21=load('dynamicCurve21.dat');
        strain21=dat21(:,1);
        stress21=dat21(:,2);
        dat22=load('dynamicCurve22.dat');
        strain22=dat22(:,1);
        stress22=dat22(:,2);
        strain=0:0.001:roundn(max(max(strain21(:,1)),max(strain22(:,1))),-3);
        switch constitutive
            case 1
                stressinv=(matparam(1)+matparam(2)*power(strain,matparam(3)))*(1+matparam(4)*log(rate(2,3)/epsilon_0));
            case 2
                stressinv=matparam(1)*power(strain,matparam(2))*(1+power(rate(2,3)/matparam(3),1/matparam(4)));
        end
        axes(handles.axes1);
        plot(strain21,stress21,'r',strain22,stress22,'g',strain,stressinv,'b');
        legend([plotlegend{2},'实验1'],[plotlegend{2},'实验2'],[plotlegend{2},'反求'],4);
        xlabel('塑性应变');
        ylabel('应力(Mpa)');
    case 5                  % velocity 3 inverse result
        dat31=load('dynamicCurve31.dat');
        strain31=dat31(:,1);
        stress31=dat31(:,2);
        dat32=load('dynamicCurve32.dat');
        strain32=dat32(:,1);
        stress32=dat32(:,2);
        strain=0:0.001:roundn(max(max(strain31(:,1)),max(strain32(:,1))),-3);
         switch constitutive
            case 1
                stressinv=(matparam(1)+matparam(2)*power(strain,matparam(3)))*(1+matparam(4)*log(rate(3,3)/epsilon_0));
            case 2
                stressinv=matparam(1)*power(strain,matparam(2))*(1+power(rate(3,3)/matparam(3),1/matparam(4)));
         end
        axes(handles.axes1);
        plot(strain31,stress31,'r',strain32,stress32,'g',strain,stressinv,'b');
        legend([plotlegend{3},'实验1'],[plotlegend{3},'实验2'],[plotlegend{3},'反求'],4);
        xlabel('塑性应变');
        ylabel('应力(Mpa)');
    case 6                  % velocity 4 inverse result
        dat41=load('dynamicCurve41.dat');
        strain41=dat41(:,1);
        stress41=dat41(:,2);
        dat42=load('dynamicCurve42.dat');
        strain42=dat42(:,1);
        stress42=dat42(:,2);
        strain=0:0.001:roundn(max(max(strain41(:,1)),max(strain42(:,1))),-3);
         switch constitutive
            case 1
                stressinv=(matparam(1)+matparam(2)*power(strain,matparam(3)))*(1+matparam(4)*log(rate(4,3)/epsilon_0));
            case 2
                stressinv=matparam(1)*power(strain,matparam(2))*(1+power(rate(4,3)/matparam(3),1/matparam(4)));
         end
        axes(handles.axes1);
        plot(strain41,stress41,'r',strain42,stress42,'g',strain,stressinv,'b');
        legend([plotlegend{4},'实验1'],[plotlegend{4},'实验2'],[plotlegend{4},'反求'],4);
        xlabel('塑性应变');
        ylabel('应力(Mpa)');
    case 7                  % velocity 5 inverse result
        dat51=load('dynamicCurve51.dat');
        strain51=dat51(:,1);
        stress51=dat51(:,2);
        dat52=load('dynamicCurve52.dat');
        strain52=dat52(:,1);
        stress52=dat52(:,2);
        strain=0:0.001:roundn(max(max(strain51(:,1)),max(strain52(:,1))),-3);
         switch constitutive
            case 1
                stressinv=(matparam(1)+matparam(2)*power(strain,matparam(3)))*(1+matparam(4)*log(rate(5,3)/epsilon_0));
            case 2
                stressinv=matparam(1)*power(strain,matparam(2))*(1+power(rate(5,3)/matparam(3),1/matparam(4)));;
         end
        axes(handles.axes1);
        plot(strain51,stress51,'r',strain52,stress52,'g',strain,stressinv,'b');
        legend([plotlegend{5},'实验1'],[plotlegend{5},'实验2'],[plotlegend{5},'反求'],4);
        xlabel('塑性应变');
        ylabel('应力(Mpa)');
    case 8                  % velocity 6 inverse result
        dat61=load('dynamicCurve61.dat');
        strain61=dat61(:,1);
        stress61=dat61(:,2);
        dat62=load('dynamicCurve62.dat');
        strain62=dat62(:,1);
        stress62=dat62(:,2);
        strain=0:0.001:roundn(max(max(strain61(:,1)),max(strain62(:,1))),-3);
        switch constitutive
            case 1
                stressinv=(matparam(1)+matparam(2)*power(strain,matparam(3)))*(1+matparam(4)*log(rate(6,3)/epsilon_0));
            case 2
                stressinv=matparam(1)*power(strain,matparam(2))*(1+power(rate(6,3)/matparam(3),1/matparam(4)));
        end
        axes(handles.axes1);
        plot(strain61,stress61,'r',strain62,stress62,'g',strain,stressinv,'b');
        legend([plotlegend{6},'实验1'],[plotlegend{6},'实验2'],[plotlegend{6},'反求'],4);
        xlabel('塑性应变');
        ylabel('应力(Mpa)');
end