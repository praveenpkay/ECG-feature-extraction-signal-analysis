function f=so3()
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
S_peaks=[];
for i = R_peaks
    for j = 1:25
        z=i+j;
        if (sig(z)<0)
            if(sig(z)<sig(z+1) && sig(z) <sig(z-1))
                S_peaks=[S_peaks z];
            end
        end
    end
end
plot(sig)
hold on
title('S Peaks')
for i=S_peaks
    plot(i,sig(i),'b^')
end
end