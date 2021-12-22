function varargout = Interface(varargin)
% INTERFACE MATLAB code for Interface.fig
%      INTERFACE, by itself, creates a new INTERFACE or raises the existing
%      singleton*.
%
%      H = INTERFACE returns the handle to a new INTERFACE or the handle to
%      the existing singleton*.
%
%      INTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFACE.M with the given input arguments.
%
%      INTERFACE('Property','Value',...) creates a new INTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Interface_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Interface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Interface

% Last Modified by GUIDE v2.5 22-Dec-2021 13:35:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Interface_OpeningFcn, ...
                   'gui_OutputFcn',  @Interface_OutputFcn, ...
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


% --- Executes just before Interface is made visible.
function Interface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Interface (see VARARGIN)

% dataset 1 : 
Nombre_point=1000;
var_bruit=3;
fech=10000;
fo=1000;
Te=1/fech;
abscisse=0:1:Nombre_point-1;
bruit = randn(1,Nombre_point)*var_bruit;
signal=cos(2*pi*(fo/fech)*abscisse)+bruit;
handles.Cosinus=signal;
% dataset 2 : 
bruit = randn(1,Nombre_point)*var_bruit;
handles.BBGC=bruit;

% dataset  : 

% dataset 2 : 

% dataset 2 : 

% dataset 2 : 

handles.currentData=handles.BBGC;
%plot(handles.currentData);
% Choose default command line output for Interface
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Interface wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Interface_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in fenetre.
function fenetre_Callback(hObject, eventdata, handles)
% hObject    handle to fenetre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 str = get(handles.fenetre,'String');
 val=get(handles.fenetre,'Value');
% 
 switch str{val}
     case 'Rectangulaire'
         handles.Rectangulaire=1;
         handles.Hamming=0;
         handles.Hanning=0;
         handles.Bertlatt=0;
         disp("Rectangulaire")
     case 'Hamming'
         handles.Rectangulaire=0;
         handles.Hamming=1;
         handles.Hanning=0;
         handles.Bertlatt=0;
         disp("Hamming")
     case 'Hanning'
         handles.Rectangulaire=0;
         handles.Hamming=0;
         handles.Hanning=1;
         handles.Bertlatt=0;
         disp("Hanning")
     case 'Bertlatt'
         handles.Rectangulaire=0;
         handles.Hamming=0;
         handles.Hanning=0;
         handles.Bertlatt=1;
         disp("Bertlatt");

 end

 guidata(hObject,handles);
% Hints: contents = cellstr(get(hObject,'String')) returns fenetre contents as cell array
%        contents{get(hObject,'Value')} returns selected item from fenetre


% --- Executes during object creation, after setting all properties.
function fenetre_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fenetre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in periodogramme_welch.
function periodogramme_welch_Callback(hObject, eventdata, handles)
% hObject    handle to periodogramme_welch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp("on est dans periodogramme_welch");
recouvrement=1;
taillewindows=100;
Nfft = length(handles.currentData);
% permet d'ajouter le padding nÃ©cessaire pour avoir une puissance de 2 
while ((log2(Nfft)-floor(log2(Nfft))) ~= 0)
    Nfft=Nfft+1;
    handles.currentData=[handles.currentData 0];
    
end
fech=10000;

%windows = transpose(hanning(length(signal)/4)); %fenêtre de hanning
%windows = transpose(bartlett(length(signal)/4));
if (handles.Rectangulaire ==1)
    windows=ones(1,taillewindows);
    disp("fenetre rectangle")
end
if (handles.Hamming ==1)
    windows = transpose(hamming(taillewindows)); %fenêtre de hamming
    disp("fenetre hamming");
end
if (handles.Hanning ==1)
    windows = transpose(hanning(taillewindows));
    disp("fenetre hanning");
end
if (handles.Bertlatt ==1)
    windows = transpose(bartlett(taillewindows));
    disp("fenetre bertlatt");
end

[periodogramme_welch, tabperio2]= Monnew_Welch(handles.currentData,Nfft,fech,windows,recouvrement);
plot(periodogramme_welch);



% --- Executes on button press in spectrogramme.
function spectrogramme_Callback(hObject, eventdata, handles)
% hObject    handle to spectrogramme (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see G
taillewindows=floor(length(handles.currentData)/4);

if (handles.Rectangulaire ==1)
    windows=ones(1,taillewindows);
    disp("fenetre rectangle")
end
if (handles.Hamming ==1)
    windows = transpose(hamming(taillewindows)); %fenêtre de hamming
    disp("fenetre hamming");
end
if (handles.Hanning ==1)
    windows = transpose(hanning(taillewindows));
    disp("fenetre hanning");
end
if (handles.Bertlatt ==1)
    windows = transpose(bartlett(taillewindows));
    disp("fenetre bertlatt");
end
Nfft=1000;
fech=10000;
% while ((log2(Nfft)-floor(log2(Nfft))) ~= 0)
%     Nfft=Nfft+1;
%     handles.currentData=[handles.currentData 0];
%     
% end
%fenêtre rectangulaire
%windows = transpose(hamming(length(signal)/4)); %fenêtre de hamming
%windows = transpose(hanning(length(signal)/4)); %fenêtre de hanning
%windows = transpose(bartlett(length(signal)/4)); %fenêtre de bertlett (triangulaire)
[temps,frequence,spectro]=Mon_spectro(handles.currentData,Nfft,fech,windows,50);


imagesc(temps,frequence,transpose(spectro))
xlabel("temps (s)"),ylabel("Fréquence (Hz)"),title("Spectrogramme")



% --- Executes on selection change in signaux.
function signaux_Callback(hObject, eventdata, handles)
% hObject    handle to signaux (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 str = get(hObject,'String');
 val=get(hObject,'Value');
% 
 switch str{val}
     case 'BBGC'
         handles.currentData=handles.BBGC;
         disp("bruit blanc")
     case 'Cosinus'
         disp("on est dans le cos");
         handles.currentData=handles.Cosinus;

 end

 guidata(hObject,handles);
%     case 'Processus à moyenne ajustée'
%     case 'Processus AR'
% 

% Hints: contents = cellstr(get(hObject,'String')) returns signaux contents as cell array
%        contents{get(hObject,'Value')} returns selected item from signaux


% --- Executes during object creation, after setting all properties.
function signaux_CreateFcn(hObject, eventdata, handles)
% hObject    handle to signaux (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fmin_Callback(hObject, eventdata, handles)
% hObject    handle to fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fmin as text
%        str2double(get(hObject,'String')) returns contents of fmin as a double


% --- Executes during object creation, after setting all properties.
function fmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fmax_Callback(hObject, eventdata, handles)
% hObject    handle to fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fmax as text
%        str2double(get(hObject,'String')) returns contents of fmax as a double


% --- Executes during object creation, after setting all properties.
function fmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in periodoramme_daniel.
function periodoramme_daniel_Callback(hObject, eventdata, handles)
% hObject    handle to periodoramme_daniel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

taillewindows=10;
if (handles.Rectangulaire ==1)
    windows=ones(1,taillewindows);
    disp("fenetre rectangle")
end
if (handles.Hamming ==1)
    windows = transpose(hamming(taillewindows)); %fenêtre de hamming
    disp("fenetre hamming");
end
if (handles.Hanning ==1)
    windows = transpose(hanning(taillewindows));
    disp("fenetre hanning");
end
if (handles.Bertlatt ==1)
    windows = transpose(bartlett(taillewindows));
    disp("fenetre bertlatt");
end
[periodogrammedaniel]=Periodogramme_daniel(handles.currentData,windows);
plot(periodogrammedaniel);
title("periodogramme de daniel");
xlabel("Frequence (Hz)");


% --- Executes on button press in periodogramme_moyenne.
function periodogramme_moyenne_Callback(hObject, eventdata, handles)
% hObject    handle to periodogramme_moyenne (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = get(handles.signaux,'String');
 val=get(handles.signaux,'Value');

fech=10000;
fo=1000;
Te=1/fech;
Nombre_point=1000;
abscisse=0:1:Nombre_point-1;
% 
var_bruit=1;
disp("str(val) : ")
disp(str(val));
 switch str{val}
     case 'BBGC'
        N_experience = 10;
        signals=zeros(Nombre_point,N_experience);
        for k=1:N_experience
           bruit = randn(Nombre_point,1)*var_bruit;
           signals(:,k)=bruit;
        end
        disp("bruit blanc")
     case 'Cosinus'
           N_experience = 10;
           signals=zeros(Nombre_point,N_experience);
           for k=1:N_experience
                bruit = randn(Nombre_point,1)*var_bruit;
                signals(:,k)=cos(2*pi*(fo/fech).*abscisse(1,:)')+bruit;
           end
           disp("bruit blanc")
           disp("on est dans le cos");
         

 end

% periodogramme moyenné :
[periodogrammemoyenne,tabperio]=periodogramme_moyenne(signals);
plot(periodogrammemoyenne);
title("periodogramme moyenné sur 10 réalisations");


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1
