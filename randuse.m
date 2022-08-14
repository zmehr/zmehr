function [ randf ] = randuse(rand11, nv,n )
%RANDUSE Summary of this function goes here
%   Detailed explanation goes here

for i=1:1:nv
    randd(i,n:-1:1)=de2bi(rand11(i),n);
end
k=1;
for i=1:1:nv
    randf(1,k:k+(n-1))=randd(i,:);
    k=k+n;
end
end

