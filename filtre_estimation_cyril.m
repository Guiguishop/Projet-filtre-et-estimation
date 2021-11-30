clc 
clear all
close all

%% Projet filtre et estimations : 

Nombre_point=100;
var_bruit=0;
fech=10000;
fo=1000;
Te=1/fech;
abscisse=0:1:Nombre_point-1;
bruit = randn(1,Nombre_point)*var_bruit;
signal=cos(2*pi*(fo/fech)*abscisse)+bruit;
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
% calcul de 10 periodogramme pour faire un periodogramme moyenne (daniel)
signals=zeros(Nombre_point,10);
for k=1:10
    bruit = randn(Nombre_point,1)*var_bruit;
    signals(:,k)=cos(2*pi*(fo/fech).*abscisse(1,:)')+bruit;
end


figure;
plot(abscisse,signals(:,1));
title("exemple signals 1")
[periodogrammedaniel,tabperio]=periodogramme_moyenne(signals);

% affichage : 

figure;
plot(abscissef,periodogrammedaniel);
ylabel("periodogramme Daniel");

% deux approches : periodogramme lissé et périodogramme moyenné 

periodogrammewelch= Mon_Welch(signal,Nfft,fech);
figure;
plot(abscissef,periodogrammewelch);
title("periodogramme Welch");

% Mon new_welch :
recouvrement=1;
windows=ones(1,10);
[periodogrammewelch2, tabperio2]= Monnew_Welch(signal,Nfft,fech,windows,recouvrement);

figure;
semilogy(abscissef,periodogrammewelch2);
title("periodogramme Welch new version");

%% spectrogramme : 

windows = ones(1,10);
spectro = Spectrogramme(Nfft, signal,fech,windows);
Ts=1/fech;
temps=0:0.5*Ts:Ts*length(signal);
frequence=linspace(-fech/2,fech/2,Nfft);
figure;
imagesc(temps,frequence,spectro);









