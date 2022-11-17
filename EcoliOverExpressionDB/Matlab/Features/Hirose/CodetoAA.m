function [ AA ] = CodetoAA( code )
%-------------------------------------------------------------------------
%1.A   %2.C   %3.D   %4.E   %5.F   %6.G   %7.H   %8.I   %9.K   
%10.L  %11.M  %12.N  %13.P  %14.Q  %15.R  %16.S  %17.T  %18.U 
%19.V  %20.W  %21.Y  %22.Other

    if     (code==1)  AA = 'A';
    elseif (code==2)  AA = 'C';
    elseif (code==3)  AA = 'D';
    elseif (code==4)  AA = 'E';
    elseif (code==5)  AA = 'F';
    elseif (code==6)  AA = 'G';
    elseif (code==7)  AA = 'H';
    elseif (code==8)  AA = 'I';
    elseif (code==9)  AA = 'K';
    elseif (code==10) AA = 'L';
    elseif (code==11) AA = 'M';
    elseif (code==12) AA = 'N';
    elseif (code==13) AA = 'P';
    elseif (code==14) AA = 'Q';
    elseif (code==15) AA = 'R';
    elseif (code==16) AA = 'S';
    elseif (code==17) AA = 'T';
    elseif (code==18) AA = 'U';
    elseif (code==19) AA = 'V';
    elseif (code==20) AA = 'W';
    elseif (code==21) AA = 'Y';
    elseif (code==22) AA = 'Other';
    end
%--------------------------------------------------------------------------
end

