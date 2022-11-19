function [ code ] = AAtoCode( AA )
%-------------------------------------------------------------------------
%1.A   %2.C   %3.D   %4.E   %5.F   %6.G   %7.H   %8.I   %9.K   
%10.L  %11.M  %12.N  %13.P  %14.Q  %15.R  %16.S  %17.T  %18.U 
%19.V  %20.W  %21.Y  %22.Other

    if     (AA=='A') code = 1;
    elseif (AA=='C') code = 2;
    elseif (AA=='D') code = 3;
    elseif (AA=='E') code = 4;
    elseif (AA=='F') code = 5;
    elseif (AA=='G') code = 6;
    elseif (AA=='H') code = 7;
    elseif (AA=='I') code = 8;
    elseif (AA=='K') code = 9;
    elseif (AA=='L') code = 10;
    elseif (AA=='M') code = 11;
    elseif (AA=='N') code = 12;
    elseif (AA=='P') code = 13;
    elseif (AA=='Q') code = 14;
    elseif (AA=='R') code = 15;
    elseif (AA=='S') code = 16;
    elseif (AA=='T') code = 17;
    elseif (AA=='U') code = 18;
    elseif (AA=='V') code = 19;
    elseif (AA=='W') code = 20;
    elseif (AA=='Y') code = 21;
    %elseif (strcmp(AA,'Other') || strcmp(AA,'*')) code = 22;
    else             code = 22;
    end
%--------------------------------------------------------------------------
end

