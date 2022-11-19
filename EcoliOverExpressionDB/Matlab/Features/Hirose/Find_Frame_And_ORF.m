function [ selected_frame selected_ORF ] = Find_Frame_And_ORF(seq)
%--------------------------------------------------------------------------   
    set(gcf,'Visible','off');
    set(0,'DefaultFigureVisible','off');
    
    frames = seqshoworfs(seq,'Frame','all');
    ORFs = [];

    for i=1:6

       next_frame = frames(1,i);
       next_starts = next_frame.Start;
       next_stops = next_frame.Stop;

       
       for j=1:size(next_stops,2) 
           start = next_starts(1,j);
           stop =  next_stops(1,j);
           ORFs = [ORFs ; start, stop, i ];
       end

       if( size(next_starts,2) == size(next_stops,2)+1 )
           %So 1 ORF without Stop has been remained.
           start = next_starts( 1 , size(next_starts,2) );
           stop = length(seq)+1;
           ORFs = [ORFs ; start, stop, i ];
       end

    end

    ORFs_lenghts = ORFs(:,2) - ORFs(:,1);
    [~, idx] = max(ORFs_lenghts);

    selected_frame = ORFs(idx,3);
    if(selected_frame > 3)
        seq = seqrcomplement(seq);
%         if    (selected_frame == 4)   selected_frame = 1;
%         elseif(selected_frame == 5)   selected_frame = 2;
%         elseif(selected_frame == 6)   selected_frame = 3;
%         end
    end

    begining  = ORFs(idx,1);
    ending = ORFs(idx,2);
    selected_ORF = strcat( seq( begining : ending-1 ) , 'TAG');

    %Note: This function finds the exact sub-sequence, forward or reverse,
    %which has the longest ORF. So when the caller function wants to
    %translates the selected ORF, it should do it with "frame=1".
    
%--------------------------------------------------------------------------
end

