function [xhat, h, error] = CLMS_ar(x,filt_length,mu)
N=length(x);
order=filt_length-1;
tmp=complex(zeros(N+1,order));
error=complex(zeros(N,1));
xhat=complex(zeros(N,1));
for i=1:N
   if i==1
        x_vec=zeros(1,order);
    elseif (i>1 && i<order+1)
        x_vec=[x(i-1:-1:1).' zeros(1,order+1-i)];
    else
        x_vec=x(i-1:-1:i-order).';
    end 
    xhat(i)=x_vec*(tmp(i,:))';
    error(i)=x(i)-xhat(i);
    tmp(i+1,:)=tmp(i,:)+mu*conj(error(i))*x_vec;
end
h=tmp(1:end-1,:);
end
