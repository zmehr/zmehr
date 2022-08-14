function [bcr,ss,cc,psn2] = alg36( posn,n,nvar,num,bcr,ss,cc,psn2)


% x=imread('D:\phd+thesis\codes\xorVC\c.gif');
 x=imread('D:\phd+thesis\codes\xorVC\f.png');
% y=1-y;
% x=imread('D:\phd+thesis\codes\xorVC\m.jpg');
% x=rgb2gray(x);
% x=threshold(x,128);

% y=imread('D:\phd+thesis\codes\xorVC\c.gif');
y=imread('D:\phd+thesis\codes\xorVC\f.png');
y=imread('D:\phd+thesis\codes\xorVC\m.jpg');
y=rgb2gray(y);
y=threshold(y,128);
S=imresize(x,[125 125]);
C=imresize(y,[125 125]);

[Mne,Mno]=alg16(posn,n,nvar-1);
B=posn(end);
k=n;


%%
%%simple example
% imshow(S,[])
% imshow(x);
% y=x<5;
% yy=im2double(x);
% yyy=im2uint8(xx);
% imshow(C,[]);
%
% imshow(x)
%S=[1 0 1 0 1 1 1 0; 1 1 0 1 0 1 1 0; 1 1 0 0 1 0 0 1; 0 0 1 0 1 0 1 0 ; 1 0 1 1 1 1 1 0;0 0 0 0 0 0 0 1];
%C=[0 1 0 1 1 0 1 0;1 0 0 0 1 0 0 0; 1 1 1 0 0 1 1 1;1 0 0 1 0 1 0 1 ; 1 1 0 0 0 0 0 1;0 0 1 1 1 1 1 0];

% S= [1 0 1; 0 1 1; 0 0 1]
% C= [ 1 1 1; 0 0 0;0 1 0]
% S=1-S;
% C=1-C;

%%
%%initial
[h,w]=size(S);
R=[];


for i=1:h
    for j=1:w
        d=genr(B);
        if (d==1)
            [v]= alg26(i,j,n,S,Mno,Mne);
            k=length(v);
            for q=0:k-1
                R(i,j+q*w)=v(1,q+1);
            end
        else
            t=n*C(i,j);
            if (mod(t,2)==0)
                for q=0:k-1
                    
                    R(i,j+q*w)=C(i,j);
                end
            else
                f=randi([1 n]);
                for q=0:k-1
                    if(f==j+q*w)
                        R(i,j+q*w)=1-C(i,j);
                    else
                        R(i,j+q*w)=C(i,j);
                        
                    end
                end
                
            end
        end
    end
end
R6=R;
for i=1:w:(n-1)*w
    R(1:w,1:w)=bitxor(R(1:w,1:w),R(1:w,i+w:i+w+(w-1)));
end
R5=R(1:w,1:w);
hf= figure('visible','off');
subplot(3,3,1)
imshow(S,[])
title('main image')
subplot(3,3,2);
imshow(C,[])
title('cover image')

j=4;
for i=1:w:w*n
    subplot(3,3,j);
    j=j+1;
    imshow(R6(1:w,i:i+w-1),[]);
    title('share')
    pause(0.008)
end

subplot(3,3,j)
imshow(R5)
title(['recover image by B=', num2str(B)])
saveas(hf,strcat('D:\phd+thesis\codes\xorVC\gabinary+shares\GA7\outputs7\m', num2str(num),'.png'));

Rs=double(R5);
S=double(S);
C=double(C);
j=1;k=1;
for i=1:w:w*n
    Rn=double(R6(1:w,i:i+w-1));
    bcr(num,j) = sum(sum(~bitxor(C,Rn)));
%     ss(num,j)=entropy(Rn);
    mse(num,j) = sum((C(:)-Rn(:)).^2) / prod(size(C));
    psn2(num,j) = 10*log10((255*255)/(mse(num,j)));
    j=j+1;
    %
end

mse(num,j)= sum(((S(:)- R5(:))).^2) / prod(size(C))   ;        %main image & recover :PSNR
psn2(num,j)= 10*log10(255*255)/mse(num,j);
% psn1= psnr(C,S1)
bcr(num,j)=sum(sum(~bitxor(S,R5)))/prod(size(C));

ss(num,j)=entropy(Rs);
cc(num,j)=corr2(S,Rs);
%     npcr(num,j)= sum( S(:) == 255-Rs(:))/ prod(size(S));

% mse(num,j) = sum((S(:)-Rs(:)).^2) / prod(size(S));
% psn2(num,j) = 10*log10((255*255)/(mse(num,j)));

end






