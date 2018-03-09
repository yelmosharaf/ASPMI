function P=correlogram(x,N)
W=computedftmatrix(N);
P=(W*x);