function varargout = Multisensory_Analysis(varargin)
% MULTISENSORY_ANALYSIS MATLAB code for Multisensory_Analysis.fig
%      MULTISENSORY_ANALYSIS, by itself, creates a new MULTISENSORY_ANALYSIS or raises the existing
%      singleton*.
%
%      H = MULTISENSORY_ANALYSIS returns the handle to a new MULTISENSORY_ANALYSIS or the handle to
%      the existing singleton*.
%
%      MULTISENSORY_ANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MULTISENSORY_ANALYSIS.M with the given input arguments.
%
%      MULTISENSORY_ANALYSIS('Property','Value',...) creates a new MULTISENSORY_ANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Multisensory_Analysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Multisensory_Analysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Multisensory_Analysis

% Last Modified by GUIDE v2.5 02-Feb-2016 14:54:36

% Ashley Schormans April 2016 [aschorma@uwo.ca]

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Multisensory_Analysis_OpeningFcn, ...
                   'gui_OutputFcn',  @Multisensory_Analysis_OutputFcn, ...
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


% --- Executes just before Multisensory_Analysis is made visible.
function Multisensory_Analysis_OpeningFcn(hObject, eventdata, h, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Multisensory_Analysis (see VARARGIN)

% Choose default command line output for Multisensory_Analysis
h.output = hObject;

% Update handles structure
guidata(hObject, h);

% UIWAIT makes Multisensory_Analysis wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Multisensory_Analysis_OutputFcn(hObject, eventdata, h) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = h.output;




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


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, h)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

folder = uigetdir();
allFileNames = dir(fullfile(folder,'*.mat'));
files = struct2cell(allFileNames);
Files = files(1,:);

set(h.popupmenu1,'String',folder)
set(h.listbox1,'String',Files)


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, h)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, h)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1

datadir = get(h.popupmenu1,'String');
d = cellstr(get(hObject,'String'));
v = get(hObject,'Value');

%load data
load([sprintf('%s',datadir),'\',sprintf('%s',d{v})]);
DATA = Data;
ntrials = length(DATA);

if isfield(DATA,'TrialType_1'),     h.BOXID = 1;
elseif isfield(DATA,'TrialType_2'), h.BOXID = 2;
elseif isfield(DATA,'TrialType_3'), h.BOXID = 3;
elseif isfield(DATA,'TrialType_4'), h.BOXID = 4;
else
end

TrialType    = [DATA.(sprintf('TrialType_%d',h.BOXID))]'; TrialTypeC = cell(size(TrialType)); uTrialType = unique(TrialType);
FlashDelay   = [DATA.(sprintf('FlashDelay_%d',h.BOXID))]'; uFlashDelay = unique(FlashDelay);
NoiseDelay   = [DATA.(sprintf('NoiseDelay_%d',h.BOXID))]'; uNoiseDelay = unique(NoiseDelay);
NoiseReFlash = NoiseDelay - FlashDelay;
NoiseDB      = [DATA.(sprintf('NoiseDB_%d',h.BOXID))]';
CueDelay     = [DATA.(sprintf('RespWinDelay_%d',h.BOXID))]';
RewardTrial  = [DATA.(sprintf('RewardTrial_%d',h.BOXID))]';
bitmask      = [DATA.ResponseCode]';    Responses = cell(size(bitmask)); 


% Convert trial type into text
AVind = TrialType == 0; TrialTypeC(AVind) = {'A-V'};
VAind = TrialType == 1; TrialTypeC(VAind) = {'V-A'}; %Asynchronous
AMBIGind = TrialType == 2; TrialTypeC(AMBIGind) = {'Ambig'};


% Convert response 
HITind      = logical(bitget(bitmask,3)); Responses(HITind) = {'Hit'};
MISSind     = logical(bitget(bitmask,4)); Responses(MISSind) = {'Miss'};
RIGHTind    = logical(bitget(bitmask,6));
LEFTind     = logical(bitget(bitmask,7));
NORESPind   = logical(bitget(bitmask,10)); Responses(NORESPind) = {'Abort'};

% Identify ambiguous data

Aind100 = AMBIGind & NoiseReFlash == 100;
Aind40 = AMBIGind & NoiseReFlash == 40;
Aind10 = AMBIGind & NoiseReFlash == 10; 
Aind0 = AMBIGind & NoiseReFlash == 0;
Aind_10 = AMBIGind & NoiseReFlash == -10;
Aind_40 = AMBIGind & NoiseReFlash == -40;
Aind_100 = AMBIGind & NoiseReFlash == -100;


% Update Trial Counts -----------------------
set(h.TrialCount,'Title',['Trials: ',num2str(ntrials)])
set(h.HitsNum,'String',['Total: ',num2str(sum(HITind))])
set(h.HitPerc,'String',['Percentage: ',sprintf('%0.f',(sum(HITind)/ntrials*100)),' %'])

set(h.MissNum,'String',['Total: ',num2str(sum(MISSind))])
set(h.MissPerc,'String',['Percentage: ',sprintf('%0.f',(sum(MISSind)/ntrials*100)),' %'])

set(h.RightNum,'String',['Total: ',num2str(sum(RIGHTind))])
set(h.RightPerc,'String',['Percentage: ',sprintf('%0.f',(sum(RIGHTind)/ntrials*100)),' %'])

set(h.LeftNum,'String',['Total: ',num2str(sum(LEFTind))])
set(h.LeftPerc,'String',['Percentage: ',sprintf('%0.f',(sum(LEFTind)/ntrials*100)),' %'])


uFlash = uFlashDelay - 1;
uNoise = uNoiseDelay - 1;

% Specifying Data table information
D = NaN(3,9);
D(1,1) = max(uNoise) - min(uFlash); D(2,1) = sum(VAind); D(3,1) = sum(VAind & LEFTind)/sum(VAind)*100;
D(1,9) = min(uNoise) - max(uFlash); D(2,9) = sum(AVind); D(3,9) = sum(AVind & LEFTind)/sum(AVind)*100;
    if length(uTrialType) > 2
    D(1,2) = min(uFlash) + uNoise(4); D(2,2) = sum(Aind100); D(3,2) = sum(Aind100 & LEFTind)/sum(Aind100)*100;
    D(1,3) = min(uFlash) + uNoise(3); D(2,3) = sum(Aind40); D(3,3) = sum(Aind40 & LEFTind)/sum(Aind40)*100;  
    D(1,4) = min(uFlash) + uNoise(2); D(2,4) = sum(Aind10); D(3,4) = sum(Aind10 & LEFTind)/sum(Aind10)*100;  
    D(1,5) = min(uFlash) - uNoise(1); D(2,5) = sum(Aind0); D(3,5) = sum(Aind0 & LEFTind)/sum(Aind0)*100;  
        if min(NoiseReFlash) < 0,
        D(1,6) = min(uFlash) - uNoise(2); D(2,6) = sum(Aind_10); D(3,6) = sum(Aind_10 & LEFTind)/sum(Aind_10)*100;
        D(1,7) = min(uFlash) - uNoise(3); D(2,7) = sum(Aind_40); D(3,7) = sum(Aind_40 & LEFTind)/sum(Aind_40)*100;
        D(1,8) = min(uFlash) - uNoise(4); D(2,8) = sum(Aind_100); D(3,8) = sum(Aind_100 & LEFTind)/sum(Aind_100)*100;
        else
        end
    else
    end

set(h.DataTable,'Data',D)

UpdateAxPerformance(h.performance,NoiseReFlash,HITind);

function UpdateAxPerformance(ax,SOA,HITind)
cla(ax)


uSOA = unique(SOA);

nHits = zeros(size(uSOA));
HitRate = nHits;

for i = 1:length(uSOA)
    SOAind = SOA == uSOA(i);
    nHits(i) = sum(HITind & SOAind);
    HitRate(i) = (nHits(i) / sum(SOAind))*100; 
end

plot(ax,uSOA,HitRate,'-ok','linewidth',2,'markerfacecolor','k');
set(ax,'ylim',[0 100]);
set(ax,'xdir','reverse')
xlabel(ax,'SOA (ms) [Noise - Light]');
ylabel(ax,'Percent Correct (%)');

grid(ax(1),'on');

% --- Executes during object creation, after setting all properties.
function performance_CreateFcn(hObject, eventdata, handles)
% hObject    handle to performance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate performance


% --- Executes on key press with focus on DataTable and none of its controls.
function DataTable_KeyPressFcn(hObject, eventdata, h)
% hObject    handle to DataTable (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

% Figure plot
% if TrialType == 0;
%     Percent(1) = sum(AVind & HITind)/sum(AVind)*100;
% elseif TrialType == 1;
%     Percent(2) = sum(VAind & HITind)/sum(VAind)*100;
% else
% end
% 
% plot(h.performance,SOA,Percent,'-ok','linewidth',2,'markerfacecolor','k');
% set(h.performance,'ylim',[0 1])
% xlabel(h.performance,'SOA (ms)');
