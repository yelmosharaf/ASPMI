function [yhat, h, error] = CLMS(y,x,filt_length,mu)
N=length(x);
order=filt_length-1;
tmp=complex(zeros(N+1,order+1));
error=complex(zeros(N,1));
yhat=complex(zeros(N,1));
for i=1:N
    if i<order+1
        x_vec=[x(i:-1:1).' zeros(1,order+1-i)];
    else
        x_vec=x(i:-1:i-order).';
    end 
    yhat(i)=x_vec*tmp(i,:)';
    error(i)=y(i)-yhat(i);
    tmp(i+1,:)=tmp(i,:)+mu*conj(error(i))*x_vec;
end
h=tmp(1:end-1,:);
end

