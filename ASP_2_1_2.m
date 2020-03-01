N=256;
Realisations=100;
noise=wgn(N,Realisations,1);
Fs=100;
PSD_length=2*N-1;
f=[20 30];
sinusoids=sin(2*pi*(0:N-1)'*(f./Fs));
sinusoid=sinusoids(:,1)+sinusoids(:,2);
signal=noise+sinusoid;
% signal=sinusoid+zeros(N,Realisations);
% signal=sinusoid;
x=(-Fs/2:(Fs/PSD_length):Fs/2-(Fs/PSD_length));
store=zeros(PSD_length,Realisations);
subplot(121)
for i=1:Realisations
r=correl(signal(:,i),'biased');
store(:,i)=real(correlogram(r,N));
temp_1=plot(x,real(correlogram(r,N)),'color','b','linewidth',0.5);
hold on
end
temp_2=plot(x,mean(store,2),'color','r','linewidth',4);
title('PSD estimates of two noise corrupted sinewaves of frequency 20 and 30Hz', 'fontsize', 16);
xlabel('Frequency/Hz');
ylabel('P(f)')
legend([temp_1 temp_2],{'Random Realisation','Mean of All Realisations'});
grid on
grid minor 
axis tight
subplot(122)
plot(x,std(store,0,2),'linewidth',2);
title('Standard deviation of PSD estimate', 'fontsize', 16);
xlabel('Frequency/Hz');
ylabel('P(f)')
grid on
grid minor 
axis tight