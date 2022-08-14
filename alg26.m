function [ v ] = alg26(i,j,n,S,Mno,Mne )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%S=[1 0 1; 0 1 0; 0 0 1];
k=1;
[h1,w1] = size(Mno);
[h2,w2] = size(Mne);

%for i=1:h
%   for j=1:w
if (S(i,j)==0)
    r=randi(h2,1);
    for p=1:n
        v(1,p)= Mne(r,k);
        k=k+1;
    end
else
    r=randi(h1,1);
    for p=1:n
        v(1,p)= Mno(r,k);
        k=k+1;
    end
end

end


