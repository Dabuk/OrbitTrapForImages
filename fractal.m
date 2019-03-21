function varargout = fractal(varargin)
% FRACTAL MATLAB code for fractal.fig
%      FRACTAL, by itself, creates a new FRACTAL or raises the existing
%      singleton*.
%
%      H = FRACTAL returns the handle to a new FRACTAL or the handle to
%      the existing singleton*.
%
%      FRACTAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FRACTAL.M with the given input arguments.
%
%      FRACTAL('Property','Value',...) creates a new FRACTAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fractal_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fractal_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fractal

% Last Modified by GUIDE v2.5 11-Mar-2019 19:41:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fractal_OpeningFcn, ...
                   'gui_OutputFcn',  @fractal_OutputFcn, ...
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


% --- Executes just before fractal is made visible.
function fractal_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fractal (see VARARGIN)

% Choose default command line output for fractal
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fractal wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = fractal_OutputFcn(hObject, eventdata, handles) 
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
% declare global variables to hold the image and handle
global X;
%global hAxes1;

% open an image
[FileName,PathName] = uigetfile('*.bmp;*.tif;*.jpg;*.hdf','Select the image file');
FullPathName = [PathName,'\',FileName];
X = imread(FullPathName);

% get the handle and display it
%hAxes1 = findobj(gcf,'Tag','plot1');
axes(handles.plot1)%, 'CurrentAxes', hAxes1);
imshow(X);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% declare global variables to hold the image and handle
global X;
global new;
%get parameters
xmin = get(handles.slider1,'Value');
xmax = get(handles.slider2,'Value');
ymin = get(handles.slider3,'Value');
ymax = get(handles.slider4,'Value');

creal = get(handles.slider6,'Value');
cimag = get(handles.slider7,'Value');
const = complex(creal,cimag);

iter = get(handles.slider5,'Value');

baseoption = get(handles.listbox1,'Value');
modif = get(handles.listbox2,'Value');
showim = get(handles.listbox3,'Value');

poly = str2num(get(handles.edit1,'String'));

% get the handle and display it
hAxes2 = findobj(gcf,'Tag','axes2');
set(gcf, 'CurrentAxes', hAxes2);
new = main(X, xmin, xmax, ymin, ymax, const, iter, baseoption, modif, poly, showim);
axes(handles.plot2)
imshow(new);
msgbox('Operation Completed','Success');


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sliderValue = get(handles.slider1,'Value');
set(handles.xminval,'String',num2str(sliderValue));

%sliderValue = get(handles.slider1,'Value');
if sliderValue >= get(handles.slider2,'Value')
    newmaxval = sliderValue + 0.00001;
    set(handles.slider2,'Value',newmaxval);
    set(handles.xmaxval,'String',num2str(newmaxval));  
end


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
slider1Value = get(handles.slider1,'Value');
slider2Value = get(handles.slider2,'Value');

if slider2Value <= slider1Value
    ed = errordlg('max x-value should be greater than min x-value','Error');
    set(ed, 'WindowStyle', 'modal');
    newval = slider1Value + 0.00001;
    set(handles.slider2,'Value',newval);
    uiwait(ed);
end
 
sliderValue = get(handles.slider2,'Value');
set(handles.xmaxval,'String',num2str(sliderValue));
 



% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sliderValue = get(handles.slider3,'Value');
set(handles.yminval,'String',num2str(sliderValue));

%sliderValue = get(handles.slider3,'Value');
if sliderValue >= get(handles.slider4,'Value')
    newmaxval = sliderValue + 0.00001;
    set(handles.slider4,'Value',newmaxval);
    set(handles.ymaxval,'String',num2str(newmaxval));  
end



% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
slider1Value = get(handles.slider3,'Value');
slider2Value = get(handles.slider4,'Value');

if slider2Value <= slider1Value
    ed = errordlg('max y-value should be greater than min y-value','Error');
    set(ed, 'WindowStyle', 'modal');
    newval = slider1Value + 0.00001;
    set(handles.slider4,'Value',newval);
    uiwait(ed);
end
 
sliderValue = get(handles.slider4,'Value');
set(handles.ymaxval,'String',num2str(sliderValue));

% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
currentItems = get(handles.listbox1, 'String');
index = get(handles.listbox1,'value');
class(index)
if index == 1
   temp = {'None';'Phoenix';'Phoenix2';'Manowar';'BurningShip';'Polynomial'};
   set(handles.listbox2,'String',temp)
elseif index == 2
   temp = {'None';'Phoenix';'Phoenix2';'Manowar';'BurningShip';'Polynomial'};
   set(handles.listbox2,'String',temp)
   set(handles.slider6,'Value',-0.7);
   set(handles.slider7,'Value',0.27015);
   set(handles.text10,'String',num2str(-0.7));
   set(handles.text11,'String',num2str(0.27015));   
elseif index == 3
   temp = {'Popcorn';'Lambda';'Nova-Julia';'Newton1';'Newton2';'Newton3';'sin';'cos';'exponential';'magnetic';'cosh';'sinh';'Feather';'Peacock'};
   set(handles.listbox2,'String',temp)
end


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
val = get(handles.slider5,'Value');
val = round(val);
set(handles.iterval,'String',num2str(val));
set(handles.slider5,'Value',val);


% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



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

% --- Executes during object creation, after setting all properties.
function plot2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plot2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate plot2


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2
index = get(handles.listbox2,'value');
if index==1
    set(handles.slider6,'Value',1.0);
    set(handles.slider7,'Value',0.0);
    set(handles.text10,'String',num2str(1.0));
    set(handles.text11,'String',num2str(0.0));
elseif index==2
    set(handles.slider6,'Value',.56666);
    set(handles.slider7,'Value',-0.5);
    set(handles.text10,'String',num2str(.56666));
    set(handles.text11,'String',num2str(-0.5));
elseif index==3
    set(handles.slider6,'Value',.56666);
    set(handles.slider7,'Value',0.0);
    set(handles.text10,'String',num2str(0.56666));
    set(handles.text11,'String',num2str(0.0));
elseif index==4
    set(handles.slider6,'Value',-0.01);
    set(handles.slider7,'Value',0.0);
    set(handles.text10,'String',num2str(-0.01));
    set(handles.text11,'String',num2str(0.0));
elseif index==5
    set(handles.slider6,'Value',-0.01);
    set(handles.slider7,'Value',0.0);
    set(handles.text10,'String',num2str(-0.01));
    set(handles.text11,'String',num2str(0.0));
end


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on mouse press over axes background.
function plot2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to plot2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider7_Callback(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sliderValue = get(handles.slider7,'Value');
set(handles.text11,'String',num2str(sliderValue));


% --- Executes during object creation, after setting all properties.
function slider7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sliderValue = get(handles.slider6,'Value');
set(handles.text10,'String',num2str(sliderValue));


% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in listbox3.
function listbox3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox3


% --- Executes during object creation, after setting all properties.
function listbox3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global new;
imwrite(new,'output.png');
