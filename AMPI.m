function varargout = AMPI(varargin)
% AMPI M-file for AMPI.fig
%      AMPI, by itself, creates a new AMPI or raises the existing
%      singleton*.
%
%      H = AMPI returns the handle to a new AMPI or the handle to
%      the existing singleton*.
%
%      AMPI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AMPI.M with the given input arguments.
%
%      AMPI('Property','Value',...) creates a new AMPI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AMPI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AMPI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AMPI

% Last Modified by GUIDE v2.5 15-Dec-2012 14:05:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AMPI_OpeningFcn, ...
                   'gui_OutputFcn',  @AMPI_OutputFcn, ...
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


% --- Executes just before AMPI is made visible.
function AMPI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AMPI (see VARARGIN)

% Choose default command line output for AMPI
handles.output = hObject;

% Initialize popupmenu1 and axes1
handles.plotmenu=get(handles.popupmenu1,'String');
handles.plotmenu{1}='选择要显示的结果';
set(handles.popupmenu1,'String',handles.plotmenu);
axes(handles.axes1);
xlabel('塑性应变');
ylabel('应力(Mpa)');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AMPI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AMPI_OutputFcn(hObject, eventdata, handles) 
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

% Execute staticdata.m to process the static data
staticdata        
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

% Reset popupmenu1 and axes1 
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

% Execute dynamicdata.m to process the dynamic data
dynamicdata              
setappdata(hObject,'nvel',nvel)
setappdata(hObject,'rate',rate)

% Show dynamic data information on uitable1 and update plotmenu1 
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

% Execute idealfilter.m to filter the dynamic data
idealfilter           

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

a=getappdata(handles.pushbutton1,'a');
nvel=getappdata(handles.pushbutton2,'nvel');
rate=getappdata(handles.pushbutton2,'rate');
constitutive=get(handles.popupmenu2,'Value');

% Execute inverse.m to caculate the material parameter
inverse

% Show inverse result on software UI edit*
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

% Output inverse result to InverseResult.txt in current directory
matparam=getappdata(handles.pushbutton3,'matparam');
constitutive=get(handles.popupmenu2,'Value');
fid=fopen('InverseResult.txt','w');
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

% Reset uitable,popupmenu,edit* and axes1
clc;
set(handles.edit1,'String','0');
set(handles.uitable1,'Data',cellstr(' '));
set(handles.edit2,'String','0');
set(handles.edit3,'String','0');
set(handles.edit4,'String','0');
set(handles.edit5,'String','0');
set(handles.popupmenu1,'Value',1);
axes(handles.axes1);
xl=get(handles.axes1,'XLim');
yl=get(handles.axes1,'YLim');
cla
set(handles.axes1,'XLim',xl);
set(handles.axes1,'YLim',yl);
legend('off');
system('del *Curve* *Point* pre* filtered*');       % Delete temporary files

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

rate=getappdata(handles.pushbutton2,'rate');
matparam=getappdata(handles.pushbutton3,'matparam');
plotlegend=getappdata(handles.pushbutton2,'plotlegend');
constitutive=get(handles.popupmenu2,'Value');
epsilon_0=0.001;

% Execute resultplot.m to show the inverse result in axes1
resultplot


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


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2

% Reset edit*,text*,and axes1 when switch constitutive
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
constitutive=get(hObject,'Value');
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
system('del *Curve* *Point* pre* filtered*');       % Delete temporary files



