function [ ca ] = adaptiveMap( gray )

%UNTITLED Summary of this function goes here

%   Detailed explanation goes here

dr=3;

dc=3;



[nr,nc]=size(gray);

inew=im2col(padarray(gray,floor([dr,dc]/2),'symmetric'),[dr dc]);

imax=reshape(max(inew,[],1),[nr,nc]);

imin=reshape(min(inew,[],1),[nr,nc]);

s=std2(gray);

A=(s/128)^20;



for i=1:nr

    for j=1:nc

        c(i,j)=(imax(i,j)-imin(i,j))/(imax(i,j)+imin(i,j));

        ca(i,j)=(A.*c(i,j))+(1-A).*(imax(i,j)-imin(i,j));

    end

end

%figure,imshow(ca);

end


