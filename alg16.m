function [ Mne,Mno ] = alg16(posn,n,nvar)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
jj=(2^n)/2;
Mno=[];
Mne=[];
jk=1;
le=length(posn)-1;
for i=1:n:le
    Mn=posn(i:i+n-1);
   if mod( HW(Mn),2)==0       %HW=hamming weight
      Mne=[Mne;Mn];
   else
      Mno=[Mno;Mn];
  end
end
Mno;
Mne;
end