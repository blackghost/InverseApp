function varargout = InverseApp(varargin)
% INVERSEAPP M-file for InverseApp.fig
%      INVERSEAPP, by itself, creates a new INVERSEAPP or raises the existing
%      singleton*.
%
%      H = INVERSEAPP returns the handle to a new INVERSEAPP or the handle to
%      the existing singleton*.
%
%      INVERSEAPP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INVERSEAPP.M with the given input arguments.
%
%      INVERSEAPP('Property','Value',...) creates a new INVERSEAPP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before InverseApp_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to InverseApp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help InverseApp

% Last Modified by GUIDE v2.5 09-Dec-2012 20:53:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @InverseApp_OpeningFcn, ...
                   'gui_OutputFcn',  @InverseApp_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before InverseApp is made visible.
function InverseApp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to InverseApp (see VARARGIN)

% Choose default command line output for InverseApp
handles.output = hObject;
handles.plotmenu=get(handles.popupmenu1,'String');
handles.plotmenu{1}='选择要显示的结果';
set(handles.popupmenu1,'String',handles.plotmenu);
axes(handles.axes1);
xlabel('塑性应变');
ylabel('应力(Mpa)');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes InverseApp wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = InverseApp_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
b1static
set(handles.edit1,'String',num2str(round(yield)));
setappdata(hObject,'a',yield);
handles.plotmenu{2}='准静态,反求结果';
set(handles.popupmenu1,'String',handles.plotmenu);
guidata(hObject, handles);

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.popupmenu1,'Value',1);
axes(handles.axes1);
xl=get(handles.axes1,'XLim');
yl=get(handles.axes1,'YLim');
cla
legend('off')
set(handles.axes1,'XLim',xl);
set(handles.axes1,'YLim',yl);
set(handles.edit2,'String','0');
set(handles.edit3,'String','0');
set(handles.edit4,'String','0');
set(handles.edit5,'String','0');
b21dynamic
setappdata(hObject,'nvel',nvel)
setappdata(hObject,'rate',rate)
for vel=1:nvel
    for expr=1:2
        str=FileName{2*(vel-1)+expr};
        index=findstr(str,'-');
        sf=[str(1:index-1),'m/s,实验',str(index+1)];
        dynamicraw{2*(vel-1)+expr,1}=sf;
        dynamicraw{2*(vel-1)+expr,2}=rate(vel,expr);
    end
    str2=FileName{2*vel};
    index=findstr(str2,'-');
    sf2=[str(1:index-1),'m/s'];
    plotlegend{vel}=sf2;
    handles.plotmenu{vel+2}=[sf2,',反求结果'];
    set(handles.popupmenu1,'String',handles.plotmenu);
end
set(handles.uitable1,'Data',dynamicraw);
setappdata(hObject,'plotlegend',plotlegend)
b22filter

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=getappdata(handles.pushbutton1,'a');
nvel=getappdata(handles.pushbutton2,'nvel');
rate=getappdata(handles.pushbutton2,'rate');
constitutive=get(handles.popupmenu2,'Value')
b3inverse
switch constitutive
    case 1
        disp('The Parameter of Johnson-Cook Model is:')
        disp(['A=',num2str(a),', B=',num2str(bn(1)),', n=',num2str(bn(2)),', C=',num2str(c),'.'])
        setappdata(hObject,'matparam',[round(a) round(bn(1))  roundn(bn(2),-3) roundn(c,-4)])
        set(handles.edit2,'String',num2str(round(a)))
        set(handles.edit3,'String',num2str(round(bn(1))))
        set(handles.edit4,'String',num2str(roundn(bn(2),-3)))
        set(handles.edit5,'String',num2str(roundn(c,-4)))
    case 2
        disp('The Parameter of Cowper-Symonds Model is:')
        disp(['k=',num2str(bn(1)),', n=',num2str(bn(2)),', C=',num2str(c(1)),', P=',num2str(c(2)),'.'])
        setappdata(hObject,'matparam',[round(bn(1))  roundn(bn(2),-3) round(c(1)) roundn(c(2),-3)])
        set(handles.edit2,'String',num2str(round(bn(1))))
        set(handles.edit3,'String',num2str(roundn(bn(2),-3)))
        set(handles.edit4,'String',num2str(round(c(1))))
        set(handles.edit5,'String',num2str(roundn(c(2),-3)))
end

function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ResultPlot(getappdata(handles.pushbutton2,'nvel'),getappdata(handles.pushbutton3,'matparam'))

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
matparam=getappdata(handles.pushbutton3,'matparam');
constitutive=get(handles.popupmenu2,'Value')
fid=fopen('反求结果.txt','w');
switch constitutive
    case 1
        fprintf(fid,'The Parameter of Johnson-Cook Model is:\r\n');
        fprintf(fid,'A=%d, B=%d, n=%.3f, C=%.4f\n',matparam(1),matparam(2),matparam(3),matparam(4));
    case 2
        fprintf(fid,'The Parameter of Cowper-Symonds Model is:\r\n');
        fprintf(fid,'k=%d, n=%.3f, C=%d, P=%.3f\n',matparam(1),matparam(2),matparam(3),matparam(4));
end
fclose(fid);

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
set(handles.edit1,'String','0');
set(handles.uitable1,'Data',cellstr(' '));
set(handles.edit2,'String','0');
set(handles.edit3,'String','0');
set(handles.edit4,'String','0');
set(handles.edit5,'String','0');
set(handles.popupmenu1,'Value',1);
% handles.plotmenu{1}='选择要显示的结果';
% set(handles.popupmenu1,'String',handles.plotmenu);
% set(handles.popupmenu2,'Value',1)
axes(handles.axes1);
xl=get(handles.axes1,'XLim');
yl=get(handles.axes1,'YLim');
cla
set(handles.axes1,'XLim',xl);
set(handles.axes1,'YLim',yl);
legend('off');


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

selectidx=get(hObject,'Value');
rate=getappdata(handles.pushbutton2,'rate');
matparam=getappdata(handles.pushbutton3,'matparam');
plotlegend=getappdata(handles.pushbutton2,'plotlegend');
constitutive=get(handles.popupmenu2,'Value')
epsilon_0=0.001;

switch selectidx
    case 1
        axes(handles.axes1);
        xl=get(handles.axes1,'XLim');
        yl=get(handles.axes1,'YLim');
        cla 
        legend('off')
        set(handles.axes1,'XLim',xl);
        set(handles.axes1,'YLim',yl);
    case 2
        dat=load('staticCurve.dat');
        strain=dat(:,1);
        stress=dat(:,2);
        switch constitutive
            case 1
                stressinv=matparam(1)+matparam(2)*power(strain,matparam(3));
            case 2
                stressinv=matparam(1)*power(strain,matparam(2));
        end
        axes(handles.axes1);
        plot(strain,stress,'r',strain,stressinv,'b');
        legend('准静态实验','准静态反求',4);
        xlabel('塑性应变');
        ylabel('应力(Mpa)');
    case 3
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
    case 4
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
        legend('2m/s实验1','2m/s实验2','2m/s反求',4);
        xlabel('塑性应变');
        ylabel('应力(Mpa)');
    case 5
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
        legend('5m/s实验1','5m/s实验2','5m/s反求',4);
        xlabel('塑性应变');
        ylabel('应力(Mpa)');
    case 6
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
        legend('10m/s实验1','10m/s实验2','10m/s反求',4);
        xlabel('塑性应变');
        ylabel('应力(Mpa)');
    case 7
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
        legend('15m/s实验1','15m/s实验2','15m/s反求',4);
        xlabel('塑性应变');
        ylabel('应力(Mpa)');
    case 8
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
        legend('0.1m/s实验1','0.1m/s实验2','0.1m/s反求',4);
        xlabel('塑性应变');
        ylabel('应力(Mpa)');
end

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1
% axes(gca)
% xlabel('Equivalent Plastic Strain')
% ylabel('abc')



% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2
set(handles.edit2,'String','0');
set(handles.edit3,'String','0');
set(handles.edit4,'String','0');
set(handles.edit5,'String','0');
set(handles.popupmenu1,'Value',1);
axes(handles.axes1);
xl=get(handles.axes1,'XLim');
yl=get(handles.axes1,'YLim');
cla
legend('off')
set(handles.axes1,'XLim',xl);
set(handles.axes1,'YLim',yl);
constitutive=get(hObject,'Value')
switch constitutive
    case 1
        set(handles.text2,'String','A')
        set(handles.text3,'String','B')
        set(handles.text4,'String','n')
        set(handles.text5,'String','C')
    case 2
        set(handles.text2,'String','k')
        set(handles.text3,'String','n')
        set(handles.text4,'String','C')
        set(handles.text5,'String','P')
end

% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);
system('del dynamic* static* pre* filtered*');



