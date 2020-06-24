function f=so5()
close all;
clear;
clc;
sig=fileread('filename.txt')
sig=load(sig)
% sig=yout;
sig=(sig)/325;
N=length(sig);
fs=244.0667;
t=(0:N-1)/fs; 
R_peaks=[];
beat_count=0;

b=1/32*[1 0 0 0 0 0 -2 0 0 0 0 0 1];
a=[1 -2 1];
sigL=filter(b,a,sig);


b=[-1/32 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1/32];
a=[1 -1];
sigH=filter(b,a,sigL);

sig=sigH;
figure(1)
plot(sig)
title('Original Signal')
end