function varargout = projectGui(varargin)





% PROJECTGUI MATLAB code for projectGui.fig

%      PROJECTGUI, by itself, creates a new PROJECTGUI or raises the existing

%      singleton*.

%

%      H = PROJECTGUI returns the handle to a new PROJECTGUI or the handle to

%      the existing singleton*.

%

%      PROJECTGUI('CALLBACK',hObject,eventData,handles,...) calls the local

%      function named CALLBACK in PROJECTGUI.M with the given input arguments.

%

%      PROJECTGUI('Property','Value',...) creates a new PROJECTGUI or raises the

%      existing singleton*.  Starting from the left, property value pairs are

%      applied to the GUI before projectGui_OpeningFcn gets called.  An

%      unrecognized property name or invalid value makes property application

%      stop.  All inputs are passed to projectGui_OpeningFcn via varargin.

%

%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one

%      instance to run (singleton)".

%

% See also: GUIDE, GUIDATA, GUIHANDLES



% Edit the above text to modify the response to help projectGui



% Last Modified by GUIDE v2.5 03-Apr-2017 10:47:31



% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;

gui_State = struct('gui_Name',       mfilename, ...

                   'gui_Singleton',  gui_Singleton, ...

                   'gui_OpeningFcn', @projectGui_OpeningFcn, ...

                   'gui_OutputFcn',  @projectGui_OutputFcn, ...

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





% --- Executes just before projectGui is made visible.

function projectGui_OpeningFcn(hObject, eventdata, handles, varargin)

% This function has no output args, see OutputFcn.

% hObject    handle to figure

% eventdata  reserved - to be defined in a future version of MATLAB

% handles    structure with handles and user data (see GUIDATA)

% varargin   command line arguments to projectGui (see VARARGIN)

% This creates the 'background' axes



bg_im=imread('but.png');



set(handles.reset,'Cdata',bg_im);



br_im=imread('br.png');



set(handles.browse,'Cdata',br_im);



bm_im=imread('unnamed.png');



set(handles.measure,'Cdata',bm_im);



ha = axes('units','normalized','position',[0 0 1 1]);



bg=imread('background.jpg'); imagesc(bg);



set(ha,'handlevisibility','off','visible','off')



uistack(ha,'bottom');

% Choose default command line output for projectGui

handles.output = hObject;



% Update handles structure

guidata(hObject, handles);



% UIWAIT makes projectGui wait for user response (see UIRESUME)

% uiwait(handles.figure1);





% --- Outputs from this function are returned to the command line.

function varargout = projectGui_OutputFcn(hObject, eventdata, handles) 

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





% --- Executes on button press in reset.

function reset_Callback(hObject, eventdata, handles)

% hObject    handle to reset (see GCBO)

% eventdata  reserved - to be defined in a future version of MATLAB

% handles    structure with handles and user data (see GUIDATA)



im=getappdata(0,'b');

[m n p]=size(im);

im=ones(m,n);

axes(handles.axes2);

imshow(im);

axes(handles.axes3);

imshow(im);

% --- Executes on button press in browse.

function browse_Callback(hObject, eventdata, handles)

% hObject    handle to browse (see GCBO)

% eventdata  reserved - to be defined in a future version of MATLAB

% handles    structure with handles and user data (see GUIDATA)

[fname path]=uigetfile('*.jpg','select an image');

A=strcat(path,fname);

im=imread(A);

im=imcrop(im);

axes(handles.axes2);

imshow(im);

setappdata(0,'b',im);





% --- Executes on button press in grayscale.

function grayscale_Callback(hObject, eventdata, handles)

% hObject    handle to grayscale (see GCBO)

% eventdata  reserved - to be defined in a future version of MATLAB

% handles    structure with handles and user data (see GUIDATA)



im=getappdata(0,'b');



if(size(im,3)==3)

    gray=rgb2gray(im);

else 

    gray=im;

end



axes(handles.axes3);

imshow(gray);

setappdata(0,'c',gray);



% --- Executes on button press in contrastmap.

function contrastmap_Callback(hObject, eventdata, handles)

% hObject    handle to contrastmap (see GCBO)

% eventdata  reserved - to be defined in a future version of MATLAB

% handles    structure with handles and user data (see GUIDATA)

gray=getappdata(0,'c');

ca=adaptiveMap(gray);

axes(handles.axes3);

imshow(ca);

setappdata(0,'d',ca);



% --- Executes on button press in binarymap.

function binarymap_Callback(hObject, eventdata, handles)

% hObject    handle to binarymap (see GCBO)

% eventdata  reserved - to be defined in a future version of MATLAB

% handles    structure with handles and user data (see GUIDATA)

ca=getappdata(0,'d');

[m n]=size(ca);

ot=graythresh(im2double(ca));



%figure,imshow(ot);title('double');

	ot=ot*255;

temp=ca;

%[m n]=size(ca);

for p=1:1:m

for q=1:1:n

pixel=temp(p,q);

if(pixel<=ot)

temp(p,q)=255;

else

	temp(p,q)=0;

end

end

end



bw2=uint8(temp);

axes(handles.axes3);

imshow(bw2);

setappdata(0,'e',bw2);



% --- Executes on button press in edgemap.

function edgemap_Callback(hObject, eventdata, handles)

% hObject    handle to edgemap (see GCBO)

% eventdata  reserved - to be defined in a future version of MATLAB

% handles    structure with handles and user data (see GUIDATA)

bw2=getappdata(0,'e');

ca=getappdata(0,'d');

gray=getappdata(0,'c');



bw=edge(gray,'canny');

axes(handles.axes3);

imshow(bw);

%imtool(bw);

%wid=linewidthofimage(imagepath);

% B={};

% C={};

[m n]=size(gray);

for i=1:m

    qw=[];

    for j=1:n

       

       if bw(i,j)==1 && bw2(i,j)==0

%            pos=j;

%            qw=cat(2,qw,pos);

            com(i,j)=255;



       else

           com(i,j)=0;

       end

       

       

    end

    B{i}=qw;

    

end

figure, imshow(com);

% se=strel('line',7,45);

% co=imclose(com,se);

%figure, imshow(com);

setappdata(0,'f',com);

% --- Executes on button press in localthreshold.

function localthreshold_Callback(hObject, eventdata, handles)

% hObject    handle to localthreshold (see GCBO)

% eventdata  reserved - to be defined in a future version of MATLAB

% handles    structure with handles and user data (see GUIDATA)

com=getappdata(0,'f');

gray=getappdata(0,'c');

img_input=gray;

% input=localThreshold(img_input);

% axes(handles.axes3);

% imshow(input);

% setappdata(0,'g',input);

 [nRows nCols]=size(img_input);

var_row=round(nRows/3);

var_col=round(nCols/2);



img_crop_1=imcrop(img_input,[1 1 var_col var_row]);

img_crop_2=imcrop(img_input,[var_col 1 var_col var_row]);

img_crop_3=imcrop(img_input,[1 var_row var_col var_row]);

img_crop_4=imcrop(img_input,[var_col var_row var_col var_row]);

img_crop_5=imcrop(img_input,[1 var_row+var_row var_col var_row]);

img_crop_6=imcrop(img_input,[var_col var_row+var_row var_col var_row]);



img_input1=com;

img_crop_1=imcrop(img_input1,[1 1 var_col var_row]);

img_crop_2=imcrop(img_input1,[var_col 1 var_col var_row]);

img_crop_3=imcrop(img_input1,[1 var_row var_col var_row]);

img_crop_4=imcrop(img_input1,[var_col var_row var_col var_row]);

img_crop_5=imcrop(img_input1,[1 var_row+var_row var_col var_row]);

img_crop_6=imcrop(img_input1,[var_col var_row+var_row var_col var_row]);

% figure,subplot(3,2,1),imshow(img_crop_1),subplot(3,2,2),imshow(img_crop_2),subplot(3,2,3),imshow(img_crop_3),subplot(3,2,4),imshow(img_crop_4),subplot(3,2,5),imshow(img_crop_5),subplot(3,2,6),imshow(img_crop_6)

%%%%%%%%%%%%%%%%%%%%%%Find threshold value%%%%%%%%%%%%%%%%

avg_level_1=mean(mean(img_crop_1))+(std2(img_crop_1))/2;

%(mean(std(img_crop_1)))/2;

 avg_level_2=mean(mean(img_crop_2))+(std2(img_crop_2))/2;

avg_level_3=mean(mean(img_crop_3))+(std2(img_crop_3))/2;

avg_level_4=mean(mean(img_crop_4))+(std2(img_crop_4))/2;

avg_level_5=mean(mean(img_crop_5))+(std2(img_crop_5))/2;

 avg_level_6=mean(mean(img_crop_6))+(std2(img_crop_6))/2;

%%%%%%%%%%%%%%%%%%%%%%Changing to binary%%%%%%%%%%%%%%%%%%%%

for i=1:nRows

    for j=1:nCols

        if(i>1 & i<var_row & j>1 & j<var_col)

            if(img_input(i,j)>avg_level_1)

                img_input(i,j)=255;

            else

                img_input(i,j)=0;

            end

        end

        

        if(i>var_row & i<(var_row+var_row) &j>1 &j<var_col)

            if(img_input(i,j)>=avg_level_2)

                img_input(i,j)=255;

            else

                img_input(i,j)=0;

            end

        end

        if(i>(var_row+var_row) && i<nRows & j>1 & j<var_col)

            if(img_input(i,j)>=avg_level_3)

                img_input(i,j)=255;

            else

                img_input(i,j)=0;

            end

        end

        if(i>=1 & i<var_row & j>var_col & j<nCols)

            if(img_input(i,j)>=avg_level_4)

                img_input(i,j)=255;

            else

                img_input(i,j)=0;

            end

        end

        if(i>var_row & i<(var_row+var_row) & j>var_col & j<nCols)

            if(img_input(i,j)>=avg_level_5)

                img_input(i,j)=255;

            else

                img_input(i,j)=0;

            end

        end

        if(i>(var_row+var_row) & i<nRows & j>var_col & j<nCols)

            if(img_input(i,j)>=avg_level_6)

                img_input(i,j)=255;

            else

                img_input(i,j)=0;

            end

        end

    end

end

im=img_input;

axes(handles.axes3);

imshow(im);

setappdata(0,'g',im);

% --- Executes on button press in enchancement.

function enchancement_Callback(hObject, eventdata, handles)

% hObject    handle to enchancement (see GCBO)

% eventdata  reserved - to be defined in a future version of MATLAB

% handles    structure with handles and user data (see GUIDATA)



%outp=postProcess(input);

input1=getappdata(0,'f');

com=getappdata(0,'f');

 com1=bwareaopen(com,10);

 [p q]=size(com);

 cc=bwlabel(uint8(com1));

 

   

    

input2=getappdata(0,'c');

input3=getappdata(0,'g');



imtool(com);

 for m=2:p-1

  

    for n=2:q-1

        if((cc(m,n)~=0) && (input1(m, n)==255))

             if ((input3(m-1,n)==0 && input3(m+1,n)==0 )|| (input3(m-1,n)==255 && input3(m+1,n)==255 ))

            

	if(input2(m-1,n)<input2(m+1,n))

                input3(m-1,n)=0;

             else

                input3(m-1,n)=255;

            end



	if(input2(m+1,n)<input2(m-1,n))

                input3(m+1,n)=0;

             else

                input3(m+1,n)=255;

            end

             end

	if((input3(m,n-1)==0 && input3(m,n+1)==0)|| (input3(m,n-1)==255 && input3(m,n+1)==255))

	     

	if(input2(m,n-1)<input2(m,n+1))

                input3(m,n-1)=0;

             else

                input3(m,n-1)=255;

            end



	if(input2(m,n+1)<input2(m,n-1))

                input3(m,n+1)=0;

             else

                input3(m,n+1)=255;

            end

   

             end

        end

    end

 end

 in=input3;

 axes(handles.axes3);

imshow(in);

setappdata(0,'w',in);

imwrite(in,'output.jpg');



function measure_Callback(hObject, eventdata, handles)

% hObject    handle to measure (see GCBO)



post=getappdata(0,'w');



un=uint8(post);

[xm ym]=size(post);



u0_G=imread('imm.png');

u0_GT=imresize(u0_G,[200 200]);

u=imresize(un,[200 200]);



size(u0_GT);



if (numel(u0_GT) == 0)

    u0_GT = NaN * ones([xm ym]);

end



  

% TP pixels

temp_tp = [u == 0] & [u0_GT == 0];



% FP pixels

temp_fp = [u == 0] & [u0_GT ~= 0];



% FN pixels

temp_fn = [u ~= 0] & [u0_GT == 0];



% TN pixels 

temp_tn = [u ~= 0] & [u0_GT ~= 0];







% counts

count_tp = sum(sum(temp_tp));

count_fp = sum(sum(temp_fp));

count_fn = sum(sum(temp_fn));

count_tn = sum(sum(temp_tn));

% PSNR

err=mse(u,u0_GT);

temp_PSNR = 10 * log10( 255*255/ err);

PSNR = temp_PSNR



% NRM (Negative Rate Metric) (*10^-2)

NR_FN = count_fn / (count_fn + count_tp);

NR_FP = count_fp / (count_fp + count_tn);

temp_NRM = (NR_FN + NR_FP) / 2;

NRM  = temp_NRM







% MPM: Misclassification penalty metric

Contour = bwmorph(~u0_GT, 'remove');

Dist = bwdist(Contour, 'Chessboard');

D = sum(Dist(:));

MP_FN = sum(Dist(temp_fn)) / D;

MP_FP = sum(Dist(temp_fp)) / D;

temp_MPM = (MP_FN + MP_FP) / 2;

MPM = temp_MPM

% eventdata  reserved - to be defined in a future version of MATLAB

% handles    structure with handles and user data (see GUIDATA)







% --- Executes on button press in ocr.

function ocr_Callback(hObject, eventdata, handles)

% hObject    handle to ocr (see GCBO)

im=getappdata(0,'c');

im_imad = uint8(imadjust(uint8(im)));



se=strel('disk',8);

dilate=imdilate(im_imad,se);



cl=imclose(dilate,se);

im2=uint8(imerode(cl,se));



h=imsubtract(im2,im_imad);



ot=graythresh(im2double(h));



	ot=ot*255;

temp=h;

[m n]=size(temp);

%temp=im2bw(h,ot);

for p=1:1:m

for q=1:1:n

pixel=temp(p,q);

if(pixel<=ot)

temp(p,q)=255;

else

	temp(p,q)=0;

end

end

end



output=uint8(temp);

%output=getappdata(0,'w');

%figure,imshow(output1);

%output=output1;

%figure,imshow(output);

%output=imread('q2.jpg');



 threshold=graythresh(output);

 output=~im2bw(output,threshold);



 [L Ne]=bwlabel(output);

 propied=regionprops(L,'BoundingBox');

 

 hold on

for n=1:size(propied,1)

    rectangle('position',propied(n).BoundingBox,'EdgeColor','b','LineWidth',1.5)



  

end



pause(1);

fid = fopen('text.txt', 'wt');

ocrtxt = ocr(output);

rtext=ocrtxt.Text;

   fprintf(fid, '%s',rtext);

fclose(fid);

%inp=fileread('text.txt');





% eventdata  reserved - to be defined in a future version of MATLAB

% handles    structure with handles and user data (see GUIDATA)





% --- Executes on button press in measure.
