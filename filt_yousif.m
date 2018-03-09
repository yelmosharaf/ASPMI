function y= filt_yousif (b,a,CWGN)
data_len=length(CWGN);
y=complex(zeros(data_len,1));
for i=1:data_len
    if i==1
        y(i)=a*CWGN(i);
    else
        y(i)=a*CWGN(i)+b(1)*CWGN(i-1)+b(2)*conj(CWGN(i-1));
    end
end
