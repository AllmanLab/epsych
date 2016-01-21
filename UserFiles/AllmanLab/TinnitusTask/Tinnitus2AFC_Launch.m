% function Tinnitus2AFC_Launch
% 
% global RUNTIME
% 
% f = findobj('type','figure','-and','name','Tinnitus2AFC_Monitor');
% close(f);
% 
% for i = 1:RUNTIME.NSubjects
%     Tinnitus2AFC_Monitor(RUNTIME.TRIALS(i).Subject.BoxID);
% end


function Tinnitus2AFC_Launch

global RUNTIME

for i = 1:RUNTIME.NSubjects
    
    
    fobj = findobj('type','figure','-and','name',sprintf('Tinnitus Box ID: %d',RUNTIME.TRIALS(i).BoxID));
    if ~isempty(fobj), close(fobj); end
    
    Tinnitus2AFC_Monitor(RUNTIME.TRIALS(i).BoxID);

end