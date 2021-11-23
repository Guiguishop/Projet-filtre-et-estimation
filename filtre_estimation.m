clc 
clear all
close all

%% Projet filtre et estimations : 

Nombre_point=100;
fech=10000;
fo=1000;
Te=1/fech;
abscisse=0:1:Nombre_point-1;
signal=cos(2*pi*(fo/fech)*abscisse);
figure;
plot(abscisse,signal);
xlabel("echantillon");
ylabel("signal sinusoidale");


%Fft : 
Nfft = Nombre_point;
% permet d'ajouter le padding nécessaire pour avoir une puissance de 2 
while ((log2(Nfft)-floor(log2(Nfft))) ~= 0)
    Nfft=Nfft+1;
    signal=[signal 0];
    
end
% signal_padding = zeros(1,Nfft);
% for i=1:length(signal)
%     signal_padding(i) = signal(i);
% end

% fft : 
signal_f=abs(fftshift(fft(signal,Nfft)));
abscissef=-1/2:1/Nfft:(1/2-1/Nfft);
figure;
plot(abscissef,signal_f);
xlabel("Frequence (Hz)");
ylabel("Fft");

% DSP : 
Dsp= signal_f.*signal_f/Nombre_point;
figure;
plot(abscissef,Dsp);
ylabel("DSP");
xlabel("Frequence reduite");

% Puissance : 
signal_f=abs(fftshift(fft(signal,Nfft)).^2);
abscissef=-1/2:1/Nfft:(1/2-1/Nfft);
figure;
plot(abscissef,signal_f);
xlabel("Frequence (Hz)");
ylabel("Puissance");

%% périodogramme :









