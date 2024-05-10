function varargout = LST_GUI(varargin)
% LST_GUI MATLAB code for LST_GUI.fig
%      LST_GUI, by itself, creates a new LST_GUI or raises the existing
%      singleton*.
%
%      H = LST_GUI returns the handle to a new LST_GUI or the handle to
%      the existing singleton*.
%
%      LST_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LST_GUI.M with the given input arguments.
%
%      LST_GUI('Property','Value',...) creates a new LST_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LST_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LST_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LST_GUI

% Last Modified by GUIDE v2.5 10-May-2024 17:47:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @LST_GUI_OpeningFcn, ...
    'gui_OutputFcn',  @LST_GUI_OutputFcn, ...
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


% --- Executes just before LST_GUI is made visible.
function LST_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LST_GUI (see VARARGIN)

% Choose default command line output for LST_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes LST_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = LST_GUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% handles    structure with handles and user data (see GUIDATA)
[f p] = uigetfile('*.*','choose your Radiance file');
if p == 0 & f == 0
else
    [Radiance] = imread([p f]);
    if isnan(Radiance)
        errordlg('All the values Are NaN','Value ERROR')
    else
        handles.Radiance = Radiance;
    end
    add = [p f];
    set(handles.edit1,'String',add);
    msgbox('Radiance file loaded','success');
end
guidata(hObject,handles);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[f p] = uigetfile('*.*','choose your bringhtness temp file');
if p == 0 & f == 0
else
    [BTT,Reference] = geotiffread([p f]);
    info = geotiffinfo([p f]);
    if isnan(BTT)
        errordlg('All the values Are NaN','Value ERROR')
    else
        handles.Reference = Reference;
        handles.info = info;
        handles.BTT = BTT;
    end
    add = [p f];
    set(handles.edit2,'String',add);
    msgbox('Bringhtness temp file loaded','success');
end
guidata(hObject,handles);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[f p] = uigetfile('*.*','choose your reflectance file');
if p == 0 & f == 0
else
    [REF] = imread([p f]);
    if isnan(REF)
        errordlg('All the values Are NaN','Value ERROR')
    else
        if isnan(REF)
            disp('nan')
        else
            handles.REF = REF;
            handles.Dimension = size(handles.REF,3);
        end
    end
    add = [p f];
    set(handles.edit3,'String',add);
    axes(handles.axes1);
    imshow(handles.REF(:,:,2:4));
    msgbox('Reflectance file loaded','success');
    handles.Dimension = size(handles.REF,3);
    if handles.Dimension == 6
        set(handles.splitRB,'visible','off');
    end
    guidata(hObject,handles);
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
[f p] = uiputfile({'*.tif'},'save your NDVI image...');
name = [p,f];
if isempty(p) && isempty(f)
else
    geotiffwrite(name, handles.NDVI, handles.Reference, 'GeoKeyDirectoryTag',...
        handles.info.GeoTIFFTags.GeoKeyDirectoryTag)
    set(handles.edit4,'string',[p f])
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[f p] = uiputfile({'*.tif'},'save your LST image(single channel)...');
name = [p,f];
if isempty(p) && isempty(f)
else
    geotiffwrite(name, handles.LST, handles.Reference, 'GeoKeyDirectoryTag',...
        handles.info.GeoTIFFTags.GeoKeyDirectoryTag)
    set(handles.edit5,'string',[p f])
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
radiance = handles.Radiance;
image = handles.REF;
BT = handles.BTT;

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% separate bands.
B1 = image(:,:,1);  B2 = image(:,:,2);
B3 = image(:,:,3);  B4 = image(:,:,4);
B5 = image(:,:,5);  B6 = image(:,:,6);
B7 = image(:,:,7);
% some parameters.
[row,col,band] = size(image);
Emissivity = []; % For store emissivity image.
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% calculate NDVI and FVC.
NDVI = (B5-B4)./(B5+B4);
handles.NDVI = NDVI;

FVC = ((NDVI - 0.1)./(max(max(NDVI)) - 0.1)).^2;

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% calculate Emissivity.
h = waitbar(0, 'calculate Emissivity. please wait...');
for i = 1:size(NDVI,1)
    waitbar(i/size(NDVI,1),h)
    for j = 1:size(NDVI,2)
        if NDVI(i,j) < 0
            Emissivity(i,j) = 0.991;
        elseif (NDVI (i,j) >= 0 && NDVI (i,j) < 0.1)
            Emissivity(i,j) = 0.979 - 0.046 * B4(i,j);
        elseif  NDVI (i,j) < 0.6 && NDVI (i,j) >= 0.16
            Emissivity(i,j) = (0.987 .* FVC(i,j)) +  (0.971 .* (1 - FVC(i,j)));
        else
            Emissivity(i,j) = 0.99;
        end
    end
end
close(h)

if get(handles.radiobutton2,'value') == 1
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
    wv = str2double(get(handles.edit6,'string'));
    khi1 = (0.4019 .* (wv .^ 2))+(0.02916 .* wv) + 1.01523;
    khi2 = (-0.38333 .* (wv .^ 2))+(-1.50294 .* wv) + 0.20324;
    khi3 = (0.00918 .* (wv .^ 2))+(1.36072 .* wv) - 0.27514;
    gamma = ((BT .^ 2) ./ (2324 .* radiance));
    sigma = BT - ((BT .^ 2)./1324);
    LST = (gamma .* ((1 ./ Emissivity) .* (((khi1 .* radiance) + khi2) + khi3))) + sigma;
    axes(handles.axes3);
    imshow(LST); colormap('hot');
    handles.LST = LST;

elseif get(handles.radiobutton1,'value') == 1
    LST = (BT./(1+(0.00115 .* BT ./ 1.4388) .* log10(Emissivity)));
    axes(handles.axes3)
    imshow(LST); colormap('hot');
    handles.LST = LST;
end

% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit6,'visible','on');

% Hint: get(hObject,'Value') returns toggle state of radiobutton2



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit6,'visible','off');

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
