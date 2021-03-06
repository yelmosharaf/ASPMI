load PCAPCR.mat;
rank=3;
[U_x, svd_x, V_x]=svd(X);
[U_xn, svd_xn, V_xn]=svd(Xnoise);
[U_test, svd_test, V_test]=svd(Xtest);
X_testestimate=U_test(1:end,1:rank)*svd_test(1:rank,1:rank)*V_test(1:end,1:rank)';
X_estimate=U_xn(1:end,1:rank)*svd_xn(1:rank,1:rank)*V_xn(1:end,1:rank)';
Bols=(Xnoise.'*Xnoise)\(Xnoise.'*Y);
Bpcr=V_xn(1:end,1:rank)*(svd_xn(1:rank,1:rank)\(U_xn(1:end,1:rank).'*Y));
Yols=Xnoise*Bols;
Ypcr=X_estimate*Bpcr;
Ytestols=Xtest*Bols;
Ytestpcr=X_testestimate*Bpcr;
eypcr=sum(sum((Y-Ypcr).^2));
eyols=sum(sum((Y-Yols).^2));
eytestpcr=sum(sum((Ytest-Ytestpcr).^2));
eytestols=sum(sum((Ytest-Ytestols).^2));
