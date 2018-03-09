load('low-wind.mat')
figure(01)
subplot(131)
signal_low=v_east+1i*v_north;
pl=mean(signal_low.*conj(signal_low)).^(-1)*mean(signal_low.*signal_low);
coefl=abs(pl);
scatter(v_east, v_north);
hold on
plot([0 0], [min(v_north) max(v_north)], '--', 'linewidth',2,'color','k');
plot([min(v_east) max(v_east)], [0 0], '--', 'linewidth',2,'color','k');
plot([mean(v_east) mean(v_east)], [min(v_north) max(v_north)], '--', 'linewidth',2,'color','r');
plot([min(v_east) max(v_east)], [mean(v_north) mean(v_north)], '--', 'linewidth',2,'color','r');
axis tight
title('Low Wind','fontsize', 16);
xlabel('Real','fontsize', 16)
ylabel('Imag','fontsize', 16)
legend({['Circularity Quotient= ' num2str(coefl,'%0.3f')]},'fontsize', 16);
load('medium-wind.mat')
subplot(132)
signal_med=v_east+1i*v_north;
pm=mean(signal_med.*conj(signal_med)).^(-1)*mean(signal_med.*signal_med);
coefm=abs(pm);
scatter(v_east, v_north);
hold on
plot([0 0], [min(v_north) max(v_north)], '--', 'linewidth',2,'color','k');
plot([min(v_east) max(v_east)], [0 0], '--', 'linewidth',2,'color','k');
plot([mean(v_east) mean(v_east)], [min(v_north) max(v_north)], '--', 'linewidth',2,'color','r');
plot([min(v_east) max(v_east)], [mean(v_north) mean(v_north)], '--', 'linewidth',2,'color','r');
title('Medium Wind','fontsize', 16);
xlabel('Real','fontsize', 16)
ylabel('Imag','fontsize', 16)
legend({['Circularity Quotient= ' num2str(coefm,'%0.3f')]},'fontsize', 16);
axis tight

load('high-wind.mat')
subplot(133)
signal_high=v_east+1i*v_north;
ph=mean(signal_high.*conj(signal_high)).^(-1)*mean(signal_high.*signal_high);
coefh=abs(ph);
scatter(v_east, v_north);
hold on
plot([0 0], [min(v_north) max(v_north)], '--', 'linewidth',2,'color','k');
plot([min(v_east) max(v_east)], [0 0], '--', 'linewidth',2,'color','k');
plot([mean(v_east) mean(v_east)], [min(v_north) max(v_north)], '--', 'linewidth',2,'color','r');
plot([min(v_east) max(v_east)], [mean(v_north) mean(v_north)], '--', 'linewidth',2,'color','r');title('High Wind','fontsize', 16);
xlabel('Real','fontsize', 16)
ylabel('Imag','fontsize', 16)
legend({['Circularity Quotient= ' num2str(coefh,'%0.3f')]},'fontsize', 16);
axis tight

%% AR Prediction 
noise_power=1;
N=length(signal_low);
CWGN=wgn(N,1, pow2db(noise_power),'complex');
filter_length=2:40;
errorlow_CLMS=complex(zeros(N,length(filter_length)));
errormed_CLMS=complex(zeros(N,length(filter_length)));
errorhigh_CLMS=complex(zeros(N,length(filter_length)));
errorlow_ACLMS=complex(zeros(N,length(filter_length)));
errormed_ACLMS=complex(zeros(N,length(filter_length)));
errorhigh_ACLMS=complex(zeros(N,length(filter_length)));
for i=1:length(filter_length)
    mu=0.01;
    [~, ~, errorlow_CLMS(:,i)] = CLMS_ar(signal_low,filter_length(i),mu);
    mu=0.005;
    [~, ~, errormed_CLMS(:,i)] = CLMS_ar(signal_med,filter_length(i),mu);
    mu=0.001;
    [~, ~, errorhigh_CLMS(:,i)] = CLMS_ar(signal_high,filter_length(i),mu);
    mu=0.01;
    [~, ~, ~, errorlow_ACLMS(:,i)] = ACLMS_ar(signal_low,filter_length(i),mu);
    mu=0.005;
    [~, ~, ~, errormed_ACLMS(:,i)] = ACLMS_ar(signal_med,filter_length(i),mu);
    mu=0.001;
    [~, ~, ~, errorhigh_ACLMS(:,i)] = ACLMS_ar(signal_high,filter_length(i),mu);
end
MSElow_CLMS=mean(abs(errorlow_CLMS).^2);
MSEmed_CLMS=mean(abs(errormed_CLMS).^2);
MSEhigh_CLMS=mean(abs(errorhigh_CLMS).^2);
MSElow_ACLMS=mean(abs(errorlow_ACLMS).^2);
MSEmed_ACLMS=mean(abs(errormed_ACLMS).^2);
MSEhigh_ACLMS=mean(abs(errorhigh_ACLMS).^2);

figure(02)
subplot(131)
plot(filter_length,10*log10(MSElow_CLMS),'linewidth',2)
hold on
plot(filter_length,10*log10(MSElow_ACLMS),'linewidth',2)
title('Low wind data MSE prediction, \mu=0.01','fontsize', 16);
grid on
xlabel('Filter Length M','fontsize', 16)
ylabel('10log(e^2(n))','fontsize', 16)
legend({'CLMS','ACLMS'},'fontsize', 16);
axis([ 2 20 -22 -19])
subplot(132)
plot(filter_length,10*log10(MSEmed_CLMS),'linewidth',2)
hold on
plot(filter_length,10*log10(MSEmed_ACLMS),'linewidth',2)
title('Medium wind data prediction MSE, \mu=0.005','fontsize', 16);
grid on
xlabel('Filter Length, M','fontsize', 16)
ylabel('10log(e^2(n))','fontsize', 16)
legend({'CLMS','ACLMS'},'fontsize', 16);
axis([ 2 20 -11.9 -11.4])
subplot(133)
plot(filter_length,10*log10(MSEhigh_CLMS),'linewidth',2)
hold on
plot(filter_length,10*log10(MSEhigh_ACLMS),'linewidth',2)
title('High wind data prediction MSE, \mu=0.001','fontsize', 16);
grid on
xlabel('Filter Length, M','fontsize', 16);
ylabel('10log(e^2(n))','fontsize', 16);
legend({'CLMS','ACLMS'},'fontsize', 16);
axis([ 2 20 -5.6 -4.9])

