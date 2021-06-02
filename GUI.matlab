function varargout = lecturaHuella(varargin)
% LECTURAHUELLA MATLAB code for lecturaHuella.fig
%      LECTURAHUELLA, by itself, creates a new LECTURAHUELLA or raises the existing
%      singleton*.
%
%      H = LECTURAHUELLA returns the handle to a new LECTURAHUELLA or the handle to
%      the existing singleton*.
%
%      LECTURAHUELLA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LECTURAHUELLA.M with the given input arguments.
%
%      LECTURAHUELLA('Property','Value',...) creates a new LECTURAHUELLA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before lecturaHuella_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to lecturaHuella_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help lecturaHuella

% Last Modified by GUIDE v2.5 21-May-2021 14:43:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lecturaHuella_OpeningFcn, ...
                   'gui_OutputFcn',  @lecturaHuella_OutputFcn, ...
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


% --- Executes just before lecturaHuella is made visible.
function lecturaHuella_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to lecturaHuella (see VARARGIN)

% Choose default command line output for lecturaHuella
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes lecturaHuella wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = lecturaHuella_OutputFcn(hObject, eventdata, handles)
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
global Process1 n Process2
a=get(hObject,'Value');
huella=arduino('COM3');
huella.pinMode(2,'input');
huella.pinMode(3,'input');
Process1=0;
Process2=0;

if a==1
 set(handles.text7,'string','ON')    
    set(handles.text9,'string','COLOQUE HUELLA #1')
    b=0;
end

while b==0
   
   
    LecHuella1=huella.digitalRead(2);
    LecHuella2=huella.digitalRead(3);
   
    if LecHuella1==1
             
        set(handles.text12,'string','OK')
        set(handles.text9,'string','COLOQUE OTRA HUELLA')  
          Process1=1;
    end
     
   
    if  LecHuella2==1
        Process2=1;
        set(handles.text13,'string','OK')
        set(handles.text9,'string','Elija su Proceso')
       
    end
   n=Process1+Process2;
   pause(1)
a=get(hObject,'Value');
if a== 0
    b=1;
     set(handles.text7,'string',' ')
      set(handles.text9,'string',' ')
       set(handles.text12,'string',' ')
        set(handles.text13,'string',' ')
         set(handles.text14,'string',' ')
         set(handles.text4,'string',' ')
         set(handles.text17,'string',' ')
end
end


% --- Executes on button press in encriptar.
function encriptar_Callback(hObject, eventdata, handles)
% hObject    handle to encriptar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Process1   n Process2
a=get(hObject,'Value');
y=0;
if a==1 && Process1==1 && Process2==1
  x=get(handles.edit1,'string');
 set(handles.text14,'string','ENCRIPTADO')
 x=x+0;
    tamanio=size(x);
    for i=1:tamanio(2)
        if x(i)==32
            y=y+1;
            posicion(y)=i;
            h(y)=32;
        end
        if x(i)==44
            y=y+1;
            posicion(y)=i;
            h(y)=44;
        end
        if x(i)==46
            y=y+1;
            posicion(y)=i;
            h(y)=46;
        end
        if x(i)==58
            y=y+1;
            posicion(y)=i;
            h(y)=58;
        end
        if x(i)==59
            y=y+1;
            posicion(y)=i;
            h(y)=59;
        end
    end
     posicion2=size(posicion);
  h1=((x+n)-97) ;
      e=mod(h1,26) ;
      f=(e+97);
       for i=1:posicion2(2)
        f(posicion(i))=h(i);
        end
      g=char (f);
      set(handles.text4,'string',g)
      else
    set(handles.text9,'string','IDENTIFIQUENSE!')
     
 
end

function Desencriptar_Callback(hObject, eventdata, handles)
% hObject    handle to Desencriptar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Process1 n Process2
b=get(hObject,'Value');
y=0;
if b==1 && Process1==1 && Process2==1
  x=get(handles.edit1,'string');
 set(handles.text14,'string','DESENCRIPTADO')
  x=x+0;
    tamanio=size(x);
    for i=1:tamanio(2)
        if x(i)==32
            y=y+1;
            posicion(y)=i;
            h(y)=32;
        end
        if x(i)==44
            y=y+1;
            posicion(y)=i;
            h(y)=44;
        end
        if x(i)==46
            y=y+1;
            posicion(y)=i;
            h(y)=46;
        end
        if x(i)==58
            y=y+1;
            posicion(y)=i;
            h(y)=58;
        end
        if x(i)==59
            y=y+1;
            posicion(y)=i;
            h(y)=59;
        end
    end
     posicion2=size(posicion);
  i=((x-n)-97);
      j=mod(i,26);
      k=(j+97);
      for i=1:posicion2(2)
        k(posicion(i))=h(i);
        end
      l=char(k);
     set(handles.text4,'string',l)
 else
    set(handles.text9,'string','IDENTIFIQUENSE!')
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
% --- Executes on button press in cargar.
function cargar_Callback(hObject, eventdata, handles)
% hObject    handle to cargar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global tx datos
c=get(hObject,'Value');
if c==1
 datos=get(handles.edit2,'string');
 set(handles.text9,'string','TXT CARGANDO')
 
 x=importdata(datos);
 n=strjoin(x);
 tx=double(n);
 set(handles.text9,'string','Elija su Proceso')
 
end

% --- Executes on button press in encriptar2.
function encriptar2_Callback(hObject, eventdata, handles)
% hObject    handle to encriptar2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tx encrip n Process1 Process2 datos

en=get(hObject,'Value');
y=0;
replaceLine = 1;
numLines = 5;
 
if en==1 && Process1==1 && Process2==1
n=Process1+Process2;

 set(handles.text17,'string','ENCRIPTADO')
 x=tx+0;
    tamanio=size(x);
    for i=1:tamanio(2)
        if x(i)==32
            y=y+1;
            posicion(y)=i;
            h(y)=36;
        end
        if x(i)==44
            y=y+1;
            posicion(y)=i;
            h(y)=38;
        end
        if x(i)==46
            y=y+1;
            posicion(y)=i;
            h(y)=191;
        end
        if x(i)==58
            y=y+1;
            posicion(y)=i;
            h(y)=58;
        end
        if x(i)==59
            y=y+1;
            posicion(y)=i;
            h(y)=59;
        end
    end
     posicion2=size(posicion);
  h1=((x+n)-97) ;
      e=mod(h1,26) ;
      f=(e+97);
       for i=1:posicion2(2)
        f(posicion(i))=h(i);
       end
       
      encrip=char (f);
      f=size(datos);
    n1='.encrip';
    datos((f(2)-3))=n1(1);
    datos((f(2)-2))=n1(2);
    datos((f(2)-1))=n1(3);
    datos((f(2)))=n1(4);
    datos((f(2))+1)=n1(5);
    datos((f(2))+2)=n1(6);
    datos((f(2))+3)=n1(7);
     
    mydata = cell(1, numLines);
    mydata{replaceLine} = encrip*2;

    fileID = fopen(datos,'w');
    fprintf(fileID,'%s\n',mydata{:});
    fclose(fileID);
else
    set(handles.text9,'string','IDENTIFIQUENSE!')

end

% --- Executes on button press in desencriptar2.
function desencriptar2_Callback(hObject, eventdata, handles)
% hObject    handle to desencriptar2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tx encrip n Process1 Process2 datos

desn=get(hObject,'Value');
y=0;
replaceLine = 1;
numLines = 5;
 
if desn==1 && Process1==1 && Process2==1


 set(handles.text17,'string','DESENCRIPTADO')
 x=tx+0;
 x=x/2;
    tamanio=size(x);
    for i=1:tamanio(2)
        if x(i)==36
            y=y+1;
            posicion(y)=i;
            h(y)=32;
        end
        if x(i)==38
            y=y+1;
            posicion(y)=i;
            h(y)=44;
        end
        if x(i)==191
            y=y+1;
            posicion(y)=i;
            h(y)=46;
        end
        if x(i)==58
            y=y+1;
            posicion(y)=i;
            h(y)=58;
        end
        if x(i)==59
            y=y+1;
            posicion(y)=i;
            h(y)=59;
        end
    end
     posicion2=size(posicion);
  h1=((x-n)-97) ;
      e=mod(h1,26) ;
      f=(e+97);
       for i=1:posicion2(2)
        f(posicion(i))=h(i);
        end
      encrip=char (f);
         f=size(datos);
    n1='.txt';
    datos(f(2)-6)=40;
    datos(f(2)-5)=100;
    datos(f(2)-4)=41;
    datos(f(2)-3)=n1(1);
    datos(f(2)-2)=n1(2);
    datos(f(2)-1)=n1(3);
    datos(f(2))=n1(4);
     
    mydata = cell(1, numLines);
    mydata{replaceLine} = encrip;

    fileID = fopen(datos,'w');
    fprintf(fileID,'%s\n',mydata{:});
    fclose(fileID);
    else
    set(handles.text9,'string','IDENTIFIQUENSE!')

end

% --- Executes on button press in generarn.
function generarn_Callback(hObject, eventdata, handles)
% hObject    handle to generarn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global encrip

GEN=get(hObject,'Value');
replaceLine = 1;
numLines = 5;
if GEN==1

Ngenerado=get(handles.edit3,'string');
mydata = cell(1, numLines);
 mydata{replaceLine} = encrip;

fileID = fopen(Ngenerado,'w');
fprintf(fileID,'%s\n',mydata{:});
fclose(fileID);

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
