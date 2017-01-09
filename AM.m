clear;
clc;
clf;

t0=0.15;                       %基带信号的周期
ts=0.001;                      %抽样时间
fc=250;                        %载波频率
snr=10;                        %信噪比（单位DB）
fs=1/ts;                       %抽样频率
df=0.3;                        %抽样频率分辨率
t=(0:ts:t0);                   %时间范围0到t0，间隔ts
snr_lin=10^(snr/10);           %信噪比的单位转换
m=[ones(1,t0/(3*ts)),-2*ones(1,t0/(3*ts)),zeros(1,t0/(3*ts)+1)];%基带信号序列
c=cos(2.*pi.*fc.*t);           %载波
u=[2+0.85*m].*c;               %已调信号

[M,m,df1]=fftseq(m,ts,df);       %调用fftseq函数对基带信号经行fft变换
M=M/fs;                          %频率采样
[U,u,df1]=fftseq(u,ts,df);       %调用fftseq函数对已调信号经行fft变换
U=U/fs;                          %频率采样
[C,c,df1]=fftseq(c,ts,df);
f=[0:df1:df1*(length(m)-1)]-fs/2;%频谱横坐标频率取值范围及间隔
dt=0.01;
signal_power=sum(u.*u)*dt/(length(t).*dt);
noise_power=signal_power/snr_lin;
noise_std=sqrt(noise_power);
n=noise_std*randn(1,length(u));
r=u+n; 
[N,n,df1]=fftseq(n,ts,df);          %对噪声进行fft
N = N/fs;                                 %频率采样
[R,r,df1]=fftseq(r,ts,df);            %对最后的信号进行fft
R = R/fs; 

figure(1)
subplot(3,1,1)                           
plot(t,m(1:length(t)))                   %基带信号
xlabel('Time')
title('基带信号')
subplot(3,1,2)                           %载波信号
plot(t,c(1:length(t)))
xlabel('Time')
title('载波信号')
subplot(3,1,3)                           %调制信号
plot(t,u(1:length(t)))
xlabel('Time')           
title('调制信号')         

figure(2)                     
subplot(2,1,1)                           %基带信号频谱
plot(f,abs(fftshift(M)))
xlabel('frequency')
title('基带信号频谱')
subplot(2,1,2)                           %调制信号频谱
plot(f,abs(fftshift(U)))
title('调制信号频谱')          
xlabel('frequency')

figure (3)           
subplot(2,1,1)                          %噪声时域显示
plot(t,n(1:length(t)))
title('噪声信号')
subplot(2,1,2)                           %噪声频域显示
plot(f,abs(fftshift(N)))
axis([-200 200 0 0.15])
title('噪声信号频谱')

figure (4)
subplot(2,1,1)                           %加噪调制信号时域显示
plot(t,r(1:length(t)))
title('信号加噪声信号')
axis([0 0.15 -3 3])
subplot(2,1,2)                           %加噪调制信号频域显示
plot(f,abs(fftshift(R)))
title('信号加噪声信号频谱')
axis([-500 500 0 0.15])
