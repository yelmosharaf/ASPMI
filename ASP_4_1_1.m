N=1000;
n=1:N;
mu=0.1;
order=1;
length=order+1;
realisation=100;
Aerror=complex(zeros(N,realisation));
error=complex(zeros(N,realisation));
yvals=complex(zeros(N,realisation));
coeflwgn=zeros(realisation,1);
coefwlma=zeros(realisation,1);
b1=1.5+1i;
b2=2.5-0.5i;
b=[b1 b2];
a=1;
noise_power=1;
CWGN=wgn(N,realisation, pow2db(noise_power),'complex');
for i=1:realisation
    y=filt_yousif(b,a,CWGN(:,i));
    yvals(:,i)=y;
    [yhat, h, error(:,i)] = CLMS(y,CWGN(:,i),length,mu);
    [Ayhat, Ah, Ag, Aerror(:,i)] = ACLMS(y,CWGN(:,i),length,mu);
     
end 
MSE_CLMS_average=mean(abs(error).^2,2);
MSE_ACLMS_average=mean(abs(Aerror).^2,2);
MSE_CLMS_dB=10*log10(MSE_CLMS_average);
MSE_ACLMS_dB=10*log10(MSE_ACLMS_average);
CLMS_SSE=mean(MSE_CLMS_dB(500:1000));
ACLMS_SSE=mean(MSE_ACLMS_dB(500:1000));
figure(01)
subplot(121)
plot(MSE_CLMS_dB,'linewidth',2);
hold on
plot(MSE_ACLMS_dB,'linewidth',2);
title('Learning Curves CLMS vs ACLMS, Order=2, \mu=0.1','fontsize', 16);
grid on
xlabel('n','fontsize', 16)
ylabel('10log(e^2(n))','fontsize', 16)
legend({['CLMS, Steady state error = ' num2str(CLMS_SSE,'%0.2f')], ['ACLMS, Steady state error = ' num2str(ACLMS_SSE,'%0.2f')]},'fontsize', 16);
axis([ 1 1000 -350 100])
subplot(122)

for i=1:realisation
k=scatter(real(yvals(:,i)),imag(yvals(:,i)),'r');
pwmla=mean(yvals(:,i).*conj(yvals(:,i))).^(-1)*mean(yvals(:,i).*yvals(:,i));
coefwlma(i)=abs(pwmla);
end
hold on
for i=1:realisation
l=scatter(real(CWGN(:,i)),imag(CWGN(:,i)),'b');
pwgn=mean(CWGN(:,i).*conj(CWGN(:,i))).^(-1)*mean(CWGN(:,i).*CWGN(:,i));
coeflwgn(i)=abs(pwgn);
end
legend([ k, l], {['WLMA, Circularity quotient=' num2str(mean(coefwlma),'%0.3f')],['Circular WGN, Circularity quotient=' num2str(mean(coeflwgn),'%0.3f')]},'fontsize', 16);
title('Circularity of Data','fontsize', 16);
xlabel('Real','fontsize', 16)
ylabel('Imag','fontsize', 16)
