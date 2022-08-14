function [ ] = GA6(  )
%GA Summary of this function goes here
%%%%%%%  BCR
clc;clear all;close all;
delete('D:\phd+thesis\codes\xorVC\gabinary+shares\GA7\outputs7\*');
delete('D:\phd+thesis\codes\xorVC\gabinary+shares\GA7\excell\*');

n=3;
nps=n;
nvar=2^(n)+1;   %Matrix M +B
npop=12;
maxiter=10;
pc=0.4;
ncross=2*round(npop*pc/2);
pm=0.05;
nmut=2*round(npop*pm);
nrep=npop-ncross-nmut;
num=1;
%%
%%initial
tic
e.pos=[];
e.cost=[];
pop=repmat(e,npop,1);
bcr=[];psnr=[];npcr=[];ss=[];cc=[];

for i=1:npop
    rand11=randperm(nvar-1)-1;
    rand1=randuse(rand11,nvar-1,n);
    rand2=rand(1);
    randd=[rand1,rand2];
    pop(i).pos=randd;
    [bcr,ss,cc,psnr]=alg36(pop(i).pos,n,nvar,num,bcr,ss,cc,psnr);
    num=num+1;
    sol=[bcr(:,1:nps),bcr(:,end),cc(:,end),ss(:,end),psnr(:,end)];
    pop(i).cost=fitness6(sol,nps);
    
end

[value index]= sort([pop.cost],'ascend');
AA=[bcr,ss,cc];

best=1000*ones(maxiter,1);
avr=1000*ones(maxiter,1);

for   iter=1:maxiter %value(1)>0
    
    % cross
    crosspop=repmat(e,ncross,1);
    [crosspop,num,bcr,ss,cc,psnr]=crossover6(crosspop,pop,n,nvar,ncross,num,bcr,nps,ss,cc,psnr);
    % mutation
    mutpop=repmat(e,nmut,1);
    [mutpop,num,bcr,ss,cc,psnr]=mutation6(mutpop,crosspop,n,nvar,nmut,num,bcr,nps,ss,cc,psnr);
    
    % reproduction
    reppop=pop(index(1:nrep));
    
    % merge psnr,figure
    ip=index(1:nrep)+(npop*(iter-1));
    l_ip=length(ip);
    kk=npop-nrep+(npop*(iter))+1;
    for k=1:l_ip
        filename = ['D:\phd+thesis\codes\xorVC\gabinary+shares\GA7\outputs7\m' num2str(ip(k),'%d') '.png'];
        aaa=imread(filename);
        filename = ['D:\phd+thesis\codes\xorVC\gabinary+shares\GA7\outputs7\m' num2str((kk),'%d') '.png'];
        imwrite(aaa,filename);
        kk=kk+1;
    end
    
    bcr=[bcr;bcr((ip(1:nrep)),:)];
    psnr=[psnr;psnr((ip(1:nrep)),:)];
    num=num+l_ip;
    
    %merged
    [pop]=[crosspop;mutpop;reppop];
    
    [value index]=sort([pop.cost],'ascend');
    best(iter)=value(1);
    AVR(iter)=mean(value);
    disp([ 'Iter = ' num2str(iter)  ' BEST = ' num2str(value(1))])
end

xlswrite('D:\phd+thesis\codes\xorVC\gabinary+shares\GA7\excell\bcr.xlsx',bcr);
xlswrite('D:\phd+thesis\codes\xorVC\gabinary+shares\GA7\excell\psnr.xlsx',psnr);
% xlswrite('D:\phd+thesis\codes\xorVC\gabinary+shares\GA7\excell\psnr.xlsx',mse);


%% results

disp('===========================================')
disp([ 'Time = ' num2str(toc)])
disp('===========================================')
disp([ 'Best fitness = ' num2str(value(1))])
disp('===========================================')
disp([ 'Best Solution = ' num2str(pop(index(1)).pos)])
disp('===========================================')
disp([ 'sort index = ' num2str((index))])
disp('===========================================')
disp([ 'best figure= ' num2str((maxiter*npop +index(1)))])
figure
plot(best(1:iter),'g','LineWidth',2)
hold on
plot(AVR(1:iter),'m','LineWidth',2)
legend('BEST','MEAN')
xlabel('Iteration')
ylabel('Fitness')
title(' GA for VSS ')

% figuress(pop(index(1)).pos,n,nvar);

end

