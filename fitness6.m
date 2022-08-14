function [k]=fitness6(sol,nps)
% sol=[psnr(:,1:nps),npcr(:,1:nps),psnr(:,end),npcr(:,end),cc(:,end),ss(:,end)];
n=nps;
m=0;
h=0;
[p,q]=size(sol);
nn=nps;
for i=1:nps
    h=h+sol(end,i);
end
h=h/nps;
for i=nn+1:nn+1
    m=m+sol(end,i);
end

k=abs((0.5*m)-((0.52+(n/100))*h));   

end

