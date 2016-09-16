function varargout = Tinnitus2AFC_LoadData_GUI(varargin)
% TINNITUS2AFC_LOADDATA_GUI MATLAB code for Tinnitus2AFC_LoadData_GUI.fig
%      TINNITUS2AFC_LOADDATA_GUI, by itself, creates a new TINNITUS2AFC_LOADDATA_GUI or raises the existing
%      singleton*.
%
%      H = TINNITUS2AFC_LOADDATA_GUI returns the handle to a new TINNITUS2AFC_LOADDATA_GUI or the handle to
%      the existing singleton*.
%
%      TINNITUS2AFC_LOADDATA_GUI('CALLBACK',hObj,e,h,...) calls the local
%      function named CALLBACK in TINNITUS2AFC_LOADDATA_GUI.M with the given input arguments.
%
%      TINNITUS2AFC_LOADDATA_GUI('Property','Value',...) creates a new TINNITUS2AFC_LOADDATA_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Tinnitus2AFC_LoadData_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Tinnitus2AFC_LoadData_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIh

% Edit the above text to modify the response to help Tinnitus2AFC_LoadData_GUI

% Last Modified by GUIDE v2.5 26-Jul-2015 18:14:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Tinnitus2AFC_LoadData_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Tinnitus2AFC_LoadData_GUI_OutputFcn, ...
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



% --- Executes just before Tinnitus2AFC_LoadData_GUI is made visible.
function Tinnitus2AFC_LoadData_GUI_OpeningFcn(hObj, e, h, varargin)
% This function has no output args, see OutputFcn.
% hObj    handle to figure
% e  reserved - to be defined in a future version of MATLAB
% h    structure with h and user data (see GUIDATA)
% varargin   command line arguments to Tinnitus2AFC_LoadData_GUI (see VARARGIN)

% Choose default command line output for Tinnitus2AFC_LoadData_GUI
h.output = hObj;

% Update h structure
guidata(hObj, h);

% get last path used
lastdir = getpref('Tinnitus2AFC_LoadData_GUI','INPath',[]);
if isempty(lastdir), return; end
LocateDataDir(h,lastdir);

% UIWAIT makes Tinnitus2AFC_LoadData_GUI wait for user response (see UIRESUME)
% uiwait(h.figure1);








%% Browsing for Data

% --- Executes on button press in locate_datadir.
function locate_datadir_Callback(hObject, eventdata, h)
% hObject    handle to locate_datadir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
lastdir = getpref('BehaviorAnalysisGUI','datadir',cd);
if ~ischar(lastdir), lastdir = cd; end

datadir = uigetdir(lastdir,'Locate Data Directory');

if ~datadir, return; end

LocateDataDir(h,datadir);

setpref('BehaviorAnalysisGUI','datadir',datadir);

function LocateDataDir(h,datadir)
set(h.figure1,'Pointer','watch'); drawnow

datasets = dir([datadir '\*.mat']);

% check if datasets have DATA
fprintf('Checking %d files ...',length(datasets))
s = false(size(datasets));
for i = 1:length(datasets)
    r = whos('-file',fullfile(datadir,datasets(i).name));
    s(i) = strcmp(r.name,'Data');
end
datasets(~s) = [];

% check whcih Box

fprintf(' %d valid files found\n',sum(s))

if isempty(datasets)
    uiwait(helpdlg('No valid datasets were found in the selected directory'));
    dsnames = {''};
else
    dsnames = {datasets.name};
end

set(h.datadir,'String',datadir);
set(h.data_list,'Value',1,'String',dsnames);

set(h.figure1,'Pointer','arrow');




function datadir_Callback(hObject, eventdata, handles)
% hObject    handle to datadir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of datadir as text
%        str2double(get(hObject,'String')) returns contents of datadir as a double


% --- Executes during object creation, after setting all properties.
function datadir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to datadir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes on selection change in data_list.
function data_list_Callback(hObj, eventdata, h)
% hObject    handle to data_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns data_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from data_list

%get directory and filename
datadir = get(h.datadir,'String');
d = cellstr(get(hObj,'String'));
v = get(hObj,'Value');

%load data
load([sprintf('%s',datadir),'\',sprintf('%s',d{v})]);
DATA = Data;
ntrials = length(DATA);

if isfield(DATA,'TrialType_1'), h.BOXID = 1;
else                            h.BOXID = 2;
end


%%

TrialType   = [DATA.(sprintf('TrialType_%d',h.BOXID))]';   TrialTypeC = cell(size(TrialType)); 
HPFreq      = [DATA.(sprintf('HPFreq_%d',h.BOXID))]'; % uHPFreq = unique(HPFreq);
LPFreq      = [DATA.(sprintf('LPFreq_%d',h.BOXID))]';
Level       = [DATA.(sprintf('Level_%d',h.BOXID))]';
LevelVar    = [DATA.(sprintf('LevelVar_%d',h.BOXID))]';
CueDelay    = [DATA.(sprintf('CueDelay_%d',h.BOXID))]';
NumNosePokes = [DATA.(sprintf('NumNosePokes_%d',h.BOXID))]';
Reward      = [DATA.(sprintf('x_RewardTrial_%d',h.BOXID))]';
bitmask     = [DATA.ResponseCode]';    Responses = cell(size(bitmask));       

%%Convert trial type to text
AMind = TrialType == 0;     TrialTypeC(AMind)    = {'AM'};
QUIETind = TrialType == 1;  TrialTypeC(QUIETind) = {'QUIET'};
NBNind = TrialType == 2;    TrialTypeC(NBNind)   = {'NBN'};

%Convert response 
HITind      = logical(bitget(bitmask,3)); Responses(HITind)  = {'Hit'};
MISSind     = logical(bitget(bitmask,4)); Responses(MISSind) = {'Miss'};
RIGHTind    = logical(bitget(bitmask,7));
LEFTind     = logical(bitget(bitmask,6));
NORESPind   = logical(bitget(bitmask,10));Responses(NORESPind) = {'Abort'};

%idendify diffrent NBN trails
NBN8ind     = NBNind & HPFreq == 7661;
NBN12ind    = NBNind & HPFreq == 11491;
NBN16ind    = NBNind & HPFreq == 15322;
NBN20ind    = NBNind & HPFreq == 19152;
NBN24ind    = NBNind & HPFreq == 22982;

%Rewarded or not?
for n = 1: ntrials
 if strcmp(Responses(n),'Miss')|| strcmp(Responses(n),'Abort')
    Reward(n) = 0;
 end
end

%Set time scale
TS = zeros(ntrials,1);
Tfirsttrial = DATA(1).ComputerTimestamp;
for i = 1:ntrials
    TS(i) = etime(DATA(i).ComputerTimestamp,Tfirsttrial);
end
TS = TS / 60;

%%


%update Trial Counts
set(h.PanTrials,'Title', ['#TRIALS: ', num2str(ntrials)])
set(h.TextHitsNum,'String',num2str(sum(HITind)))
set(h.TextHitsPerc,'String',sprintf('%0.f',(sum(HITind)/ntrials*100)))

set(h.TextMissNum,'String',num2str(sum(MISSind)))
set(h.TextMissPerc,'String',sprintf('%0.f',(sum(MISSind)/ntrials*100)))

set(h.TextLeftNum,'String',num2str(sum(LEFTind)))
set(h.TextLeftPerc,'String',sprintf('%0.f',(sum(LEFTind)/ntrials*100)))

set(h.TextRightNum,'String',num2str(sum(RIGHTind)))
set(h.TextRightPerc,'String',sprintf('%0.f',(sum(RIGHTind)/ntrials*100)))


%update detail graph - responses to left side
L(1)  = sum(QUIETind & LEFTind)/sum(QUIETind)*100;  
L(2)  = sum(AMind & LEFTind)/sum(AMind)*100;        
L(3)  = sum(NBNind & LEFTind)/sum(NBNind)*100;      
L(4)  = sum(NBN8ind & LEFTind)/sum(NBN8ind)*100;    
L(5)  = sum(NBN12ind & LEFTind)/sum(NBN12ind)*100;  
L(6)  = sum(NBN16ind & LEFTind)/sum(NBN16ind)*100;  
L(7)  = sum(NBN20ind & LEFTind)/sum(NBN20ind)*100;  
L(8)  = sum(NBN24ind & LEFTind)/sum(NBN24ind)*100;  

X     =[1 2 3 5 6 7 8 9];

UpdateAxDetail(h.axDetail,X,L);


%update detail table - responses to left side
D = zeros(2,8);
D(1,1) = L(1);  D(2,1)  = sum(QUIETind);
D(1,2) = L(2);  D(2,2)  = sum(AMind);
D(1,3) = L(3);  D(2,3)  = sum(NBNind);
D(1,4) = L(4);  D(2,4)  = sum(NBN8ind);
D(1,5) = L(5);  D(2,5)  = sum(NBN12ind);
D(1,6) = L(6);  D(2,6)  = sum(NBN16ind);
D(1,7) = L(7);  D(2,7)  = sum(NBN20ind);
D(1,8) = L(8);  D(2,8)  = sum(NBN24ind);

set(h.DetailTable,'Data',D)


%update history table
H = cell(ntrials,9);
H(:,1) = TrialTypeC;
H(:,2) = num2cell(HPFreq);
H(:,3) = num2cell(LPFreq);
H(:,4) = num2cell(Level);
H(:,5) = num2cell(LevelVar);
H(:,6) = num2cell(CueDelay);
H(:,7) = num2cell(NumNosePokes);
H(:,8) = Responses;
H(:,9) = num2cell(Reward);
H = flipud(H);

r = length(Responses):-1:1;
r = cellstr(num2str(r'));

set(h.HistoryTable,'Data',H,'RowName',r)

%update history graph

UpdateAxHistory(h.axHistory,TS,HITind,MISSind,NORESPind,RIGHTind,LEFTind,Reward);




%%



function UpdateAxDetail(ax,X,L)
cla(ax);
hold(ax,'on')
bar(ax,X,L,'k');
set(ax,'XTick',X,...
       'XTickLabel',{'Quiet','AM','NBN','NBN 8','NBN 12','NBN 16','NBN20','NBN24'},...
       'YLim',[0 100]);
ylabel(ax,'%left');
hold(ax,'off');




function UpdateAxHistory(ax,TS,HITind,MISSind,NORESPind,RIGHTind,LEFTind,Rind)
cla(ax);

hold(ax,'on')
plot(ax,TS(HITind&LEFTind&Rind), ones(sum(HITind&LEFTind&Rind,1)),'go','markerfacecolor','g');
plot(ax,TS(HITind&LEFTind&~Rind), ones(sum(HITind&LEFTind&~Rind,1)),'go','markerfacecolor','none');
plot(ax,TS(MISSind&LEFTind),ones(sum(MISSind&LEFTind,1)),'ro','markerfacecolor','none');

plot(ax,TS(HITind&RIGHTind&Rind), zeros(sum(HITind&RIGHTind&Rind,1)),'go','markerfacecolor','g');
plot(ax,TS(HITind&RIGHTind&~Rind), zeros(sum(HITind&RIGHTind&~Rind,1)),'go','markerfacecolor','none');
plot(ax,TS(MISSind&RIGHTind),zeros(sum(MISSind&RIGHTind,1)),'ro','markerfacecolor','none');

plot(ax,TS(NORESPind),   0.5*ones(sum(NORESPind),1),'ks','markerfacecolor','none');
hold(ax,'off');

set(ax,'ytick',[0 1],'yticklabel',{'RIGHT','LEFT'},'ylim',[-0.1 1.1]);

xlabel(ax,'time (min)');




%%



% --- Executes during object creation, after setting all properties.
function data_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


















% --- Outputs from this function are returned to the command line.
function varargout = Tinnitus2AFC_LoadData_GUI_OutputFcn(hObj, e, h) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObj    handle to figure
% e  reserved - to be defined in a future version of MATLAB
% h    structure with h and user data (see GUIDATA)

% Get default command line output from h structure
varargout{1} = h.output;























