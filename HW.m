function [ s ] = HW( Mn )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
s=0;
n=length(Mn);
for j=1:n
s=s+ Mn(:,j);
end


end

