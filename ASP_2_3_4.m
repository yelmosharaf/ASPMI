load PCAPCR.mat;
rank=3;
[U_x, svd_x, V_x]=svd(X);
[U_xn, svd_xn, V_xn]=svd(Xnoise);
[U_test, svd_test, V_test]=svd(Xtest);
eypcr=zeros(1000,1);
eyols=zeros(1000,1);
X_testestimate=U_test(1:end,1:rank)*svd_test(1:rank,1:rank)*V_test(1:end,1:rank)';
X_estimate=U_xn(1:end,1:rank)*svd_xn(1:rank,1:rank)*V_xn(1:end,1:rank)';
Bols=(Xnoise.'*Xnoise)\(Xnoise.'*Y);
Bpcr=V_xn(1:end,1:rank)*(svd_xn(1:rank,1:rank)\(U_xn(1:end,1:rank).'*Y));
for i=1:1000
[Yols, Yestols]=regval(Bols);
[Ypcr, Yestpcr]=regval(Bpcr);
eyols(i)=mean(sum((Yols-Yestols).^2,2));
eypcr(i)=mean(sum((Ypcr-Yestpcr).^2,2));
end
pcr=mean(eypcr);
ols=mean(eyols);