function TRIALS = TrialFcn_FreqTuning_SanesLab(TRIALS)
global TONE_CAL NOISE_CAL

%If it's the start
if TRIALS.tidx == 1
    
    %Load tone calibration file
    [fn,pn,fidx] = uigetfile('C:\gits\epsych\UserFiles\SanesLab\SpeakerCalibrations\*.cal','Select tone calibration file');
    tone_calfile = fullfile(pn,fn);
    
    disp(['Tone calibration file is: ' tone_calfile])
    TONE_CAL = load(tone_calfile,'-mat');
    
    %Launch frequency tuning gui
    freq_tuning_gui
    
end