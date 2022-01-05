function [P,returned] = capon(signal, f, fech,mode)
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
P=zeros(N,length(f ));
invRx=1\Rx;
if (mode ==1)
 returned=invRx
end
if (mode==0)
for k=1:length(f)

P(:,k)=1/(a*invRx*a');
end
end

end 
