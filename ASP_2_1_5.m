subplot(131)
N=32;
f=2;
n=0:N-1;
realisations=100;
temp=zeros(256,realisations);
for i=1:realisations
noise=0.2/sqrt(2)*(randn(size(n))+1i*randn(size(n)));
x=exp(1i*2*pi*0.3*n)+exp(1i*2*pi*0.33*n)+exp(1i*2*pi*0.36*n)+noise;
[X,R]=corrmtx(x,8,'mod');
[S,F]=pmusic(R,3,[],1,'corr');
temp(:,i)=S;
temp_1=plot(F,S,'color','b','linewidth',1);
hold on
end
temp_2=plot(F,mean(temp,2),'color','r','linewidth',3);
set(gca,'xlim',[0.25,0.4]);
grid on; xlabel('Hz'); ylabel('Pseudospectrum');
legend([temp_1 temp_2],{'100 realisations','Mean of All Realisations'});
title('MUSIC Pseudospectrum f1=0.3, f2=0.33, f3=0.36, N=32, lag=8', 'fontsize',12);

subplot(132)
N=128;
f=2;
n=0:N-1;
temp=zeros(256,realisations);
for i=1:realisations
noise=0.2/sqrt(2)*(randn(size(n))+1i*randn(size(n)));
x=exp(1i*2*pi*0.3*n)+exp(1i*2*pi*0.33*n)+exp(1i*2*pi*0.36*n)+noise;
[X,R]=corrmtx(x,8,'mod');
[S,F]=pmusic(R,3,[],1,'corr');
temp(:,i)=S;
temp_1=plot(F,S,'color','b','linewidth',1);
hold on
end
temp_2=plot(F,mean(temp,2),'color','r','linewidth',3);
set(gca,'xlim',[0.25,0.4]);
grid on; xlabel('Hz'); ylabel('Pseudospectrum');
legend([temp_1 temp_2],{'100 realisations','Mean of All Realisations'});
title('MUSIC Pseudospectrum f1=0.3, f2=0.33, f2=0.36, N=128, lag=8', 'fontsize',12)
subplot(133)
N=128;
f=2;
n=0:N-1;
temp=zeros(256,realisations);
for i=1:realisations
noise=0.2/sqrt(2)*(randn(size(n))+1i*randn(size(n)));
x=exp(1i*2*pi*0.3*n)+exp(1i*2*pi*0.33*n)+exp(1i*2*pi*0.36*n)+noise;
[X,R]=corrmtx(x,64,'mod');
[S,F]=pmusic(R,3,[],1,'corr');
temp(:,i)=S;
temp_1=plot(F,S,'color','b','linewidth',1);
hold on
end
temp_2=plot(F,mean(temp,2),'color','r','linewidth',3);
set(gca,'xlim',[0.25,0.4]);
grid on; xlabel('Hz'); ylabel('Pseudospectrum');
legend([temp_1 temp_2],{'100 realisations','Mean of All Realisations'});
title('MUSIC Pseudospectrum f1=0.3, f2=0.33, f3=0.36, N=512, lag=128', 'fontsize',12);


