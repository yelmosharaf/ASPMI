N=16;
f=2;
subplot(121)
for i=1:3
N=N*2;
f=f-0.5;
n=0:N-1;
noise=0.2/sqrt(2)*(randn(size(n))+1i*randn(size(n)));
x=exp(1i*2*pi*0.3*n)+exp(1i*2*pi*0.32*n)+noise;
[p,k]=periodogram(x,rectwin(size(n,2)),128,1,'twosided');
plot(k*1000,pow2db(p),'linewidth',f);
hold on
end
N=512;
n=0:N-1;
noise=0.2/sqrt(2)*(randn(size(n))+1i*randn(size(n)));
x=exp(1i*2*pi*0.3*n)+exp(1i*2*pi*0.32*n)+noise;
[p,k]=periodogram(x,rectwin(size(n,2)),128,1,'twosided');
plot(k*1000,pow2db(p),'linewidth',f);
legend('N=32','N=64','N=128','N=512 (Full Peak)');
xlabel('Frequency(mHZ)');
ylabel('Power/frequency (dB/Hz)');
title('Periodogram Power Density Estimate with 128 frequency bins','fontsize',16);
grid on 
grid minor
subplot(122)
N=16;
f=1;
for i=1:3
N=N*2;
n=0:N-1;
noise=0.2/sqrt(2)*(randn(size(n))+1i*randn(size(n)));
x=exp(1i*2*pi*0.3*n)+exp(1i*2*pi*0.32*n)+noise;
[p,k]=periodogram(x,rectwin(size(n,2)),1000,1,'twosided');
plot(k*1000,pow2db(p),'linewidth',f);
hold on
end
N=512;
n=0:N-1;
noise=0.2/sqrt(2)*(randn(size(n))+1i*randn(size(n)));
x=exp(1i*2*pi*0.3*n)+exp(1i*2*pi*0.32*n)+noise;
[p,k]=periodogram(x,rectwin(size(n,2)),1000,1,'twosided');
plot(k*1000,pow2db(p),'linewidth',f);
legend('N=32','N=64','N=128', 'N=512 (Full Peak)');
xlabel('Frequency(mHZ)');
ylabel('Power/frequency (dB/Hz)');
title('Periodogram Power Density Estimate with 1000 frequency bins','fontsize',16);
grid on 
grid minor