function integrale=method_trapeze(y,fmin,fmax,fech) 
    integrale = 0;
    a= fmin/fech;
    b=fmax/fech;
    n=length(y);
    pas = (b-a)/n;
    debut = floor(length(y)/2);
    for i=0:n-1
       integrale = integrale + (y(debut+round(a+i*pas))*pas + y(debut+round(a+(i+1)*pas))*pas)/2;
    end
       
    
    
    