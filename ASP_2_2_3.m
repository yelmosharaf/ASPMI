N=10000;
x=arima('Constant',0,'AR',{2.76,-3.81,2.65,-0.92},'Variance',1);
x=simulate(x,10000);
temp=zeros(13,15);
temp2=zeros(13,15);
v=zeros(13,1);
order=[];
r=[];
x=x(500:end);
Nfft=length(x);
w=-pi:(2*pi/Nfft):pi-(2*pi/Nfft);
[Pxx_1 W_1]=freqz(1,[1,-2.76,3.81,-2.65,0.92],length(x),'twosided');
Pxx_1=abs(Pxx_1).^2;
[Pxx W]=pyulear(x,2,length(x),'twosided');
[Pxx_0 W]=pyulear(x(500:end),14,length(x),'twosided');
 subplot(121)
 plot(w,fftshift(pow2db(Pxx)),'linewidth',2);
 hold on
 plot(w,fftshift(pow2db(Pxx_0)),'linewidth',2);
 plot(w,fftshift(pow2db(Pxx_1)));
axis tight 
grid on 
grid minor 
xlabel('rad/sample'); ylabel('PSD');
title('Autoregressive PSD estimate','fontsize',16)
legend('order=2','order=14','Theoretical PSD');
subplot(122);
[Pxx W]=pyulear(x(500:end),4,length(x),'twosided');
[Pxx_0 W]=pyulear(x(500:end),12,length(x),'twosided');
 plot(w,fftshift(pow2db(Pxx)),'linewidth',2);
 hold on
plot(w,fftshift(pow2db(Pxx_0)),'linewidth',2);
plot(w,fftshift(pow2db(Pxx_1)));
axis tight 
grid on 
grid minor 
xlabel('rad/sample'); ylabel('PSD');
title('Autoregressive PSD estimate','fontsize',16)
legend('order= 4','order= 12','Theoretical PSD');
