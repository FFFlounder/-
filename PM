dt=0.00001;
t=[0:dt:3];
fm=2;               %调制信号的频率
mt=cos(2*pi*fm*t);  %调制信号的表达式
a=9;                %载波信号的幅值
fc=30;              %载波信号的频率
ct=a*cos(2*pi*fc*t);%载波信号的表达式
kp=15;
s_pm=a*cos(2*pi*fc*t+kp*1*cos(2*pi*fm*t));%已调信号的表达式
figure(1)
subplot(3,1,1)
plot(t,mt)
title('调制信号');  %绘图
subplot(3,1,2)
plot(t,ct)
title('载波信号');  %绘图
subplot(3,1,3)
plot(t,s_pm)
title('已调信号');%绘图
