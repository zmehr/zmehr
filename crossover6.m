function [crosspop,num,bcr,ss,cc,psn2] =crossover6(crosspop,pop,n,nvar,ncross,num,bcr,nps,ss,cc,psn2)
f=[pop.cost];
% f=1./f;
f=f./sum(f);
f=cumsum(f);
mn=nvar-1;
rr=1;
nv=n*(nvar-1);
pa1=zeros(nvar-1,n);
for ii=1:2:ncross
    i1=find(rand<=f,1,'first');
    i2=find(rand<=f,1,'first');
    p1=pop(i1).pos;
    p2=pop(i2).pos;
    j=randi([1 nv]);
    o1=[p1(1:j) p2(j+1:nv)];
    o2=[p2(1:j) p1(j+1:nv)];
    for i=1:n:nv
        xo1=num2str(o1(1,i:i+(n-1)));
        po1(rr)= bin2dec(xo1);
        xo2=num2str(o2(1,i:i+(n-1)));
        po2(rr)= bin2dec(xo2);
        rr=rr+1;
    end
    rr=1;
    o1=unique([po1 randperm(nvar-1)-1],'stable');
    o2=unique([po2 randperm(nvar-1)-1],'stable');
    o1=randuse(o1,mn,n);
    o2=randuse(o2,mn,n);   
    a=randi([0,1]);
    if (p1(end)+p2(end))>1
            o3=(p1(end)+p2(end))/2;
    else 
            o3=(p1(end)+p2(end));
    end
        
    c1=[o1,o3];
    crosspop(ii).pos=c1;
    [bcr,ss,cc,psn2]=alg36(c1,n,nvar,num,bcr,ss,cc,psn2);
    num=num+1;
    sol=[bcr(:,1:nps),bcr(:,end),cc(:,end),ss(:,end),psn2(:,end)];
    crosspop(ii).cost=fitness6(sol,nps);
    a=randi([0,1]);
    if (p1(end)+p2(end))>1
            o4=(p1(end)+p2(end))/2;
    else 
            o4=(p1(end)+p2(end));
    end
%     o4=(p1(end)+p2(end))/2;
    c2=[o2,o4];
    crosspop(ii+1).pos=c2;
    [bcr,ss,cc,psn2]=alg36(c2,n,nvar,num,bcr,ss,cc,psn2);
    num=num+1;
    sol=[bcr(:,1:nps),bcr(:,end),cc(:,end),ss(:,end),psn2(:,end)];
    crosspop(ii+1).cost=fitness6(sol,nps);
end
end