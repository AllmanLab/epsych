function Allman_TOJ_2AFC_Launch_AS

global RUNTIME

for i = 1:RUNTIME.NSubjects
    
    
    fobj = findobj('type','figure','-and','name',sprintf('TOJ Box ID: %d',RUNTIME.TRIALS(i).BoxID));
    if ~isempty(fobj), close(fobj); end
    
    Allman_TOJ_2AFC_Monitor_AS(RUNTIME.TRIALS(i).Subject.BoxID);

end