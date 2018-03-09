function [yhat, h, g, error] = ACLMS(y,x,filt_length,mu)
N=length(x);
order=filt_length-1;
tmp1=complex(zeros(N+1,order+1));
tmp2=complex(zeros(N+1,order+1));
error=complex(zeros(N,1));
yhat=complex(zeros(N,1));
for i=1:N
    if i<order+1
        x_vec=[x(i:-1:1).' zeros(1,order+1-i)];
    else
        x_vec=x(i:-1:i-order).';
    end 
    yhat(i)=x_vec*tmp1(i,:)'+conj(x_vec)*tmp2(i,:)';
    error(i)=y(i)-yhat(i);
    tmp1(i+1,:)=tmp1(i,:)+mu*conj(error(i))*x_vec;
    tmp2(i+1,:)=tmp2(i,:)+mu*conj(error(i))*conj(x_vec);
end
h=tmp1(1:end-1,:);
g=tmp2(1:end-1,:);
end
