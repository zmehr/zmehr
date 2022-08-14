function [ x ] = threshold( x,t)
%THRESHOLD Summary of this function goes here
%   Detailed explanation goes here
[p,q]=size(x);
for i=1:p
    for j=1:q
        if(x(i,j)>t)
            x(i,j)=1;
        else x(i,j)=0;
        end
    end
end

end

