function [ Arr ] = ReplaceStrInArray( Arr,Str,StrRep )
%--------------------------------------------------------------------------

    Isqm = strncmp(Str,Arr,length(Str)); 

    nqm = find(Isqm==1);
    Arr(nqm) = cellstr(StrRep);

%--------------------------------------------------------------------------
end

