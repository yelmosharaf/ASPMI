function [y, k]=correl(x,bias)
if iscolumn(x)
    x=x';
end
N=length(x);
tmp=zeros(1,N);
for k=1:1:2*N-1
    if k<=N
        if strcmp(bias,'biased')
                tmp(k)=(x(1:k)*x(N-k+1:end)')./N;
        elseif strcmp(bias,'unbiased')
                tmp(k)=(x(1:k)*x(N-k+1:end)')./k;
        else
                tmp(k)=(x(1:k)*x(N-k+1:end)');
        end
    end 
end
y=[tmp fliplr(tmp(1:end-1))]';
k=(-(N-1) :1: (N-1));
