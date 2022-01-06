<<<<<<< HEAD
function [P] = capon(signal, f, fech,mode)
N=length(signal);
if (length(signal)~= length(f))
    disp("probleme de dimension");
end
a= zeros(N,length(f));
for j=1:length(f )
    for k=1:N
        a(j,k)=exp(-i*2*pi*(k-1)*(f(j)/fech));
=======
function [P] = capon(signal, f, fech)
    N=length(signal);
    if (length(signal)~= length(f))
        disp("probleme de dimension");
>>>>>>> cfb6731ceda9fac7974196ae6886b9f8c365e670
    end
    
    a=zeros(1,N);
    P=zeros(1,length(f));
    Rx=signal'*signal;
    invRx = 1\Rx;
    for j=1:length(f)
        for k=1:N
            a(k)= exp(-1i*2*pi*(k-1)*(f(j)/fech)); %Steering vecteur
        end
        P(j) = 1./ a*invRx*a';
    end     
end
<<<<<<< HEAD
Rx=signal'*signal;

invRx=1\Rx;



P=1./(conj(a)'*invRx*a);

end


=======
 
>>>>>>> cfb6731ceda9fac7974196ae6886b9f8c365e670
