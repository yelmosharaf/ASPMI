load PCAPCR.mat;
rank=3;
[U_x, svd_x, V_x]=svd(X);
[U_xn, svd_xn, V_xn]=svd(Xnoise);
X_estimate=U_xn(1:end,1:rank)*svd_xn(1:rank,1:rank)*V_xn(1:end,1:rank)';
diff1=sum((X-X_estimate).^2,1);
diff2=sum((X-Xnoise).^2,1);
diff3=sum((X_estimate-Xnoise).^2,1);
diff1_f=sum(diff1);
diff2_f=sum(diff2);
diff3_f=sum(diff3);
stem(diff1, 'filled');
hold on
stem(diff2,'filled');
xlabel('column number');
ylabel('Sqaured error');
title('Squared error of X_{noise} and X_{estimate}','fontsize',16)
legend('|X-X_{estimate}|^2','|X-X_{noise}|^2');
grid on;
grid minor;