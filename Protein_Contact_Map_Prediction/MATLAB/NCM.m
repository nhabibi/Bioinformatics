function [ cm ] = NCM( p,thr )

    pSize = size(p,1);
    cm = zeros(pSize,pSize);
    for i=1:1:pSize
        for j=1:1:pSize
            if sqrt( (p(i,2)-p(j,2)).^2 + (p(i,3)-p(j,3)).^2 + (p(i,4)-p(j,4)).^2 ) <= thr
                cm(i,j) = 1;
            end
        end
    end

end