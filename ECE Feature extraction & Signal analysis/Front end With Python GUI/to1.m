function f = to1()
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
time_in_sec=N/fs;
time_in_min=time_in_sec/60;
BPM=beat_count/time_in_min;
if (BPM >=30 && BPM<=60)
    f=sprintf('%.2f Rhythm: Bradycardia',BPM);
elseif (BPM >60 && BPM<=90)
    f=sprintf('%.2f Rhythm: Normal',BPM);
elseif (BPM >=200)
    f=sprintf('%.2f Rhythm: VFIB',BPM);
else
    f=sprintf('%.2f Rhythm: Tachycardia',BPM);
end
end

