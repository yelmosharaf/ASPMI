N=256;
x=wgn(N,1,0);
subplot(231)
PSD_length=2*N-1;
[y1, k1]=correl(x,'biased');
[y2, k2]=correl(x,'unbiased');
w=-pi:2*pi/PSD_length:pi-(2*pi/PSD_length);
plot(k1,real(y1),'linewidth', 2);
hold on
plot(k2,real(y2),'linewidth', 0.5);
title('WGN autocorrelation function', 'fontsize', 12);
xlabel('k');
ylabel('r(k)')
legend('biased', 'unbiased');
grid on 
grid minor 
axis tight
subplot(234)
plot(w,real(correlogram(y1,N)),'linewidth', 2);
hold on
plot(w,real(correlogram(y2,N)),'linewidth', 0.5);
title('WGN Correlogram', 'fontsize', 12);
xlabel('Frequency rads/sample');
ylabel('P(w)')
grid on 
grid minor 
legend('biased', 'unbiased');
axis tight
b = 0.125*ones(8,1);
a=1;
x_wgn=wgn(N,1,0);
x_filt=filter(b,a,x_wgn);
[y1_filt, k1]=correl(x_filt,'biased');
[y2_filt, k2]=correl(x_filt,'unbiased');
subplot(232)
plot(k1,real(y1_filt),'linewidth', 2);
hold on
plot(k2,real(y2_filt),'linewidth', 0.5);
title('Filtered WGN autocorrelation function', 'fontsize', 12);
xlabel('k');
ylabel('r(k)')
legend('biased', 'unbiased');
grid on 
grid minor 
axis tight
subplot(235)
plot(w,real(correlogram(y1_filt,N)),'linewidth', 2);
hold on
plot(w,real(correlogram(y2_filt,N)),'linewidth', 0.5);
title('Filtered WGN Correlogram', 'fontsize', 12);
xlabel('Frequency rads/sample');
ylabel('P(w)')
grid on 
grid minor 
legend('biased', 'unbiased');
axis tight
x_d=exp(-2*pi*0.1*1i*(0:N-1)');
[y1_d, k1]=correl(x_d,'biased');
[y2_d, k2]=correl(x_d,'unbiased');
subplot(233)
plot(k1,real(y1_d),'linewidth', 2);
hold on
plot(k2,real(y2_d),'linewidth', 0.5);
title('Exponential autocorrelation function', 'fontsize', 12);
xlabel('k');
ylabel('r(k)')
legend('biased', 'unbiased');
grid on 
grid minor 
axis tight
subplot(236)
plot(w,real(correlogram(y1_d,N)),'linewidth', 2);
hold on
plot(w,real(correlogram(y2_d,N)),'linewidth',0.5);
title('Exponential Correlogram', 'fontsize', 12);
xlabel('Frequency rads/sample');
ylabel('P(w)')
grid on 
grid minor 
legend('biased', 'unbiased');
axis tight