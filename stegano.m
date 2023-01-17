function varargout = stegano(varargin)
% STEGANO MATLAB code for stegano.fig
%      STEGANO, by itself, creates a new STEGANO or raises the existing
%      singleton*.
%
%      H = STEGANO returns the handle to a new STEGANO or the handle to
%      the existing singleton*.
%
%      STEGANO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STEGANO.M with the given input arguments.
%
%      STEGANO('Property','Value',...) creates a new STEGANO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before stegano_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to stegano_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help stegano

% Last Modified by GUIDE v2.5 16-Jan-2023 19:54:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @stegano_OpeningFcn, ...
                   'gui_OutputFcn',  @stegano_OutputFcn, ...
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


% --- Executes just before stegano is made visible.
function stegano_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to stegano (see VARARGIN)

% Choose default command line output for stegano
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes stegano wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = stegano_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox.
function listbox_Callback(hObject, eventdata, handles)
% hObject    handle to listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox


% --- Executes during object creation, after setting all properties.
function listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in enkripbtn.
function enkripbtn_Callback(hObject, eventdata, handles)
% hObject    handle to enkripbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cool=guidata(gcbo);
I=get(cool.oriaxes,'Userdata');
pesan=get(cool.listbox,'Userdata');
%pesan=[pesan 'QQQQ'];
%teksbin=reshape(dec2bin(pesan,8).',1,[]);
%gbr2=stegolsb(I,teksbin);
I
msg=pesan
c = imread(I);
c
c(1:1:1)= length(msg) ; %to count massage Char to easly retrive all the massage 
c=imresize(c,[size(c,1) size(c,2)],'nearest');
message = msg ; %add ' .' to prevint lossing one char  
message = strtrim(message);
m = length(message) * 8;
AsciiCode = uint8(message);
binaryString = transpose(dec2bin(AsciiCode,8));
binaryString = binaryString(:);
N = length(binaryString);
b = zeros(N,1);
for k = 1:N
  if(binaryString(k) == '1')
      b(k) = 1;
  else
      b(k) = 0;
  end
end
s = c;
  height = size(c,1);
  width = size(c,2);
k = 1;
for i = 1 : height
  for j = 1 : width
      LSB = mod(double(c(i,j)), 2);
      if (k>m || LSB == b(k))
          s(i,j) = c(i,j);
      elseif(LSB == 1)
          s(i,j) = (c(i,j) - 1);
      elseif(LSB == 0)
          s(i,j) = (c(i,j) + 1);
      end
  k = k + 1;
  end
end
imgWTxt = 'msgimage.png';
imwrite(s,imgWTxt);

after = imread('msgimage.png');
handles.current_data1=after;
axes(cool.lsbaxes);
imshow(handles.current_data1);
set(cool.lsbaxes,'Userdata',after);

% --- Executes on button press in opentxtbtn.
function opentxtbtn_Callback(hObject, eventdata, handles)
% hObject    handle to opentxtbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cool=guidata(gcbo);
[namafile,direktori]=uigetfile('*.txt','Open Text File');
path=[direktori,namafile];
teks=fopen(path,'r');
charteks=fread(teks,'uint8=>char');
fclose(teks);
pesan=sprintf(charteks);
set(cool.listbox,'string',pesan);
set(cool.listbox,'Userdata',pesan);

% --- Executes on button press in openlsbbtn.
function openlsbbtn_Callback(hObject, eventdata, handles)
% hObject    handle to openlsbbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cool=guidata(gcbo);
[namafile,direktori]=uigetfile('*.bmp','Load Image');
namafile
direktori
pathnya=[direktori,namafile]
I=imread(pathnya);
handles.current_data1=I;
axes(cool.lsbimaxes);
imshow(handles.current_data1);
set(cool.lsbimaxes,'Userdata',namafile);


% --- Executes on button press in dekripbtn.
function dekripbtn_Callback(hObject, eventdata, handles)
% hObject    handle to dekripbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cool=guidata(gcbo);
I=get(cool.lsbimaxes,'Userdata');
%teksbin=ekstraklsb(I);
I
s = imread(I);
height = size(s,1);
width = size(s,2);
m =  double( s(1:1:1) ) * 8  ;
k = 1;
for i = 1 : height
  for j = 1 : width
      if (k <= m)
          b(k) = mod(double(s(i,j)),2);
          k = k + 1;
      end
  end
end
binaryVector = b;
binValues = [ 128 64 32 16 8 4 2 1 ];
binaryVector = binaryVector(:);
if mod(length(binaryVector),8) ~= 0
error('Length of binary vector must be a multiple of 8.');
end
binMatrix = reshape(binaryVector,8,[]);
textString = char(binValues*binMatrix);
disp(textString);
    
teksbin = textString

set(cool.listboxdecrypt,'String',teksbin);
set(cool.listboxdecrypt,'Userdata',teksbin);


% --- Executes on button press in savebtn.
function savebtn_Callback(hObject, eventdata, handles)
% hObject    handle to savebtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cool=guidata(gcbo);
[namafile,direktori]=uiputfile('*.txt','Simpan Pesan');
pesantekslsb=get(cool.listboxdecrypt,'Userdata');
teks=fopen(namafile,'w');
fprintf(teks,pesantekslsb);
fclose(teks);


% --- Executes on selection change in listboxdecrypt.
function listboxdecrypt_Callback(hObject, eventdata, handles)
% hObject    handle to listboxdecrypt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listboxdecrypt contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listboxdecrypt


% --- Executes during object creation, after setting all properties.
function listboxdecrypt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listboxdecrypt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function openfile_Callback(hObject, eventdata, handles)
% hObject    handle to openfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cool=guidata(gcbo);
[namafile,direktori]=uigetfile({'*.jpg';'*.bmp';'*.png';'*.tif'},'Open Image File');
namafile
direktori
pathnya=[direktori,namafile];
if isequal (namafile,0)
    return;
end
I=imread(pathnya);
handles.current_data1=I;
axes(cool.oriaxes);
imshow(handles.current_data1);
set(cool.oriaxes,'Userdata',namafile);


% --------------------------------------------------------------------
function saveimagelsb_Callback(hObject, eventdata, handles)
% hObject    handle to saveimagelsb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cool=guidata(gcbo);
[namafile,direktori]=uiputfile('*.png','Save LSB Image File');
gbr2=get(cool.lsbaxes,'Userdata');
gbr2
imwrite(gbr2,namafile);

% --------------------------------------------------------------------
function btnEXIT_Callback(hObject, eventdata, handles)
% hObject    handle to btnEXIT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.figure1);
