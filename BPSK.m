clc
close all
clear all

t = 0:0.001:1;
fc = 50;
fm = 5;
amp = 0.4;
c = amp * sin(2 * pi * fc * t);
subplot(4, 1, 1)
plot(t, c)
xlabel('Tiempo')
ylabel('Amplitud')
title('Portadora')

m = square(2 * pi * fm * t);
subplot(4, 1, 2)
plot(t, m)
xlabel('Tiempo')
ylabel('Amplitud')
title('Señal de Mensaje')

x = c .* m;
subplot(4, 1, 3)
plot(t, x)
xlabel('Tiempo')
ylabel('Amplitud')
title('PSK')

L = length(x);
NFFT = 2^nextpow2(L);
X = fft(x, NFFT) / L;
f = 1 / (2 * 0.001) * linspace(0, 1, NFFT / 2 + 1);


plot(f, 2 * abs(X(1:NFFT / 2 + 1)))
xlabel('Frecuencia (Hz)')
ylabel('Amplitud')
title('Espectro de Frecuencia de la Señal Modulada')