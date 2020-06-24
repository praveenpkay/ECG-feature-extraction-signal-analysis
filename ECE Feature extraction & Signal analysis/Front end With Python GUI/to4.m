function f=to4()
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
BPM=beat_count/time_in_min

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
R_peaks=R_peaks(2:length(R_peaks)-1);
S_peaks=S_peaks(2:length(S_peaks)-1);
Q_peaks=[];
for i = R_peaks
    for j = 1:20
        z=i-j;
        if (sig(z)<0)
            if(sig(z)<sig(z+1) && sig(z) <sig(z-1))
                Q_peaks=[Q_peaks z];
            end 
        end
    end
end
P_peaks=[];
for i = Q_peaks
    for j = 1:30
        z=i-j;
        if (sig(z)>0.05)
            if(sig(z)>sig(z+1) && sig(z)>sig(z-1))
                P_peaks=[P_peaks z];
            end
        end
    end
end
T_peaks=[];
for i = S_peaks
    for j = 1:100
        z=i+j;
        if (sig(z)>0.025)
            if(sig(z)>sig(z+1) && sig(z)>sig(z-1))
                T_peaks=[T_peaks z];
            end
        end
    end
end
P_left=[];
strr=[];
for i = P_peaks
    for j =1:15
        z=i-j;
        if (sig(z)>0 && sig(z)<sig(z+1))
            strr=z;
        end
    end
    P_left=[P_left strr];
end
P_right=[];
strr=[];
for i = P_peaks
    for j =1:15
        z=i+j;
        if (sig(z)>0 && sig(z)>sig(z+1))
            strr=z;
        end
    end
    P_right=[P_right strr];
end

T_left=[];
strr=[];
for i = T_peaks
    for j =1:20
        z=i-j;
        if (sig(z)>0 && sig(z)<sig(z+1))
            strr=z;
        end
    end
    T_left=[T_left strr];
end
T_right=[];
strr=[];
for i = T_peaks
    for j =1:20
        z=i+j;
        if (sig(z)>0 && sig(z)>sig(z+1))
            strr=z;
        end
    end
    T_right=[T_right strr];
end
S_right=[];
strr=[];
for i = S_peaks
    for j =1:20
        z=i+j;
        if (sig(z)<0 && sig(z)>sig(z+1))
            strr=z;
        end
    end
    S_right=[S_right strr];
end   
S_right=unique(S_right);            
X0_points=[];
%---------------------------------------------
strr=[];
for i = S_right
    for j =1:35
        z=i+j;
        if (find(T_left==z))
            strr=[strr z];
        end
    end
end
sum=0;
for i=1:length(strr)
    z=strr(i)-S_right(i);
    sum=sum+z;
end
ST_Segment=sum/length(strr);
ST_Segment=ST_Segment/fs;
%---------------------------------------------
sum=0;
strr=[];
for i = S_right
    for j =35:60
        z=i+j;
        if (find(T_right==z))
            strr=[strr z];
        end
    end
end
strr1=[];
for i = S_right
    for j =40:60
        z=i-j;
        if (find(P_right==z))
            strr1=[strr1 z];
        end
    end
end
for i=1:length(strr)
    z=strr(i)-strr1(i);
    sum=sum+z;
end
QT_Interval=sum/length(strr);
QT_Interval=QT_Interval/fs;
%------------------------------------------
strr=[];
for i = S_right
    for j =40:60
        z=i-j;
        if (find(P_right==z))
            strr=[strr z];
        end
    end
end
sum=0;
for i=1:length(strr) 
    z=S_right(i)-strr(i);
    sum=sum+z;
end
QRS_Complex=sum/length(strr);
QRS_Complex=QRS_Complex/fs;
f=sprintf('%f seconds',QRS_Complex);