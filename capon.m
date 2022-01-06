function [P] = capon(signal, f, fech,mode)
N=length(signal);
if (length(signal)~= length(f))
    disp("probleme de dimension");
end
a= zeros(N,length(f));
for j=1:length(f )
    for k=1:N
        a(j,k)=exp(-i*2*pi*(k-1)*(f(j)/fech));
    end
end
Rx=signal'*signal;

invRx=1\Rx;



P=1./(conj(a)'*invRx*a);

end


