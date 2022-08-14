function [mutpop,num,bcr,ss,cc,psn2]=mutation6(mutpop,pop,n,nvar,nmut,num,bcr,nps,ss,cc,psn2)
npop=length(pop);
nv=nvar-1;
for ii=1:nmut
    i=randi([1 npop]);
    p=pop(i).pos;
    
    j1=randi([1 nv-1]);
    j11=(j1-1)*n;
    j2=randi([j1+1 nv]);
    j22=(j2-1)*n;
    nj1=p(j11+1:j11+(n));
    nj2=p(j22+1:j22+(n));
    p(j11+1:j11+n)=nj2;
    p(j22+1:j22+n)=nj1;
    aa=rand(1)+1;
    bb=rand(1);
    
    if  p(end)>0.5
        p(end)=bb*p(end);
    else
        p(end)=aa*p(end);
    end
    mutpop(ii).pos=p;
    [bcr,ss,cc,psn2]=alg36(p,n,nvar,num,bcr,ss,cc,psn2);
    num=num+1;
    sol=[bcr(:,1:nps),bcr(:,end),cc(:,end),ss(:,end),psn2(:,end)];
    mutpop(ii).cost=fitness6(sol,nps);
end
end
