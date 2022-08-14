function [val index]=fitness62(ind1,sol,nr)
% sol=[psnr(:,1:nps),npcr(:,1:nps),psnr(:,end),npcr(:,end),cc(:,end),ss(:,end)];

h(nr,2)=0;
% nn=2*nps;
for ii=1:nr
    h(ii,1)=sol(ind1(ii));
    h(ii,2)=(ind1(ii))  ;
end
[val1 ind]=sort(h,1,'descend');
index=h(ind(:,1),2);
val=val1(:,1);
% k=0.1*m+h;
% k=sum(sol(:));
end

