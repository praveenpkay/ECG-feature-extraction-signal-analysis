function f = so6()
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

for k = 2 : length(sig)-1
    if (sig(k) > sig(k-1) && sig(k) > sig(k+1) && sig(k) > 0.2)
        R_peaks = [ R_peaks k];
        beat_count = beat_count + 1;
    end
end
R_peaks=R_peaks(2:length(R_peaks)-1);
HRV=[];
for i=2:length(R_peaks)
    z=R_peaks(i)-R_peaks(i-1);
    z=z/fs;
    z=z*1000
    HRV=[HRV z]; 
end
% HRV
figure(1)
title('Heart Rate Variablity')
for i=HRV
    plot(HRV)
end
end
