clear
clc
close all hidden
format short

Am = input('Amplitud del mensaje: ');
Ac = input('Amplitud de la portadora: ');
fm = input('Valor de la frecuencia del mensaje: ');
fc = input('Valor de la frecuencia de la portadora: ');
b = input('Valor del indice de modulacion: ');
Fs = input('Ingrese la frecuencia de muestreo: ');
t = 0:1/Fs:1; %1000 muestras

% Mensaje
msg = Am*sin(2*pi*fm*t);
subplot(3,4,[1,2]); 
plot(t, msg);
xlabel('Tiempo');
ylabel('Amplitud');
title('Mensaje');

% Portadora
carrier = Ac*sin(2*pi*fc*t);
subplot(3,4,[5,6]);
plot(t, carrier);
xlabel('Tiempo');
ylabel('Amplitud');
title('Señal Portadora');

% Señal Modulada
y = Ac*sin(2*pi*fc*t + b*cos(2*pi*fm*t));
subplot(3,4,[9,10]);
plot(t, y);
xlabel('Tiempo');
ylabel('Amplitud');
title('Señal Modulada');

% Espectro de frecuencia
N = length(y);           % Número de muestras
Y = fft(y)/N;            % Transformada de Fourier
f = Fs*(0:(N/2))/N;      % Eje de frecuencias

subplot(3,4,[3,4,7,8,11,12]);
plot(f, 2*abs(Y(1:N/2+1)));
xlabel('Frecuencia (Hz)');
ylabel('Amplitud');
title('Espectro de Frecuencia de la Señal Modulada');
grid on;