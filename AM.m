clc
close all;
clear;

fs = 10000;
t = 0:1/fs:0.1;

% Señal de mensaje
Am = 1;
fm = 50;
m_t = Am .* cos(2 * pi * fm * t);

% Señal portadora
fc = 1000;
Ac = 1;
c_t = Ac .* cos(2 * pi * fc * t);

% Modulación AM
s_t = c_t + m_t .* c_t ./ Ac;

% Representación en el dominio del tiempo
figure('Name', 'Señales en el Dominio del Tiempo');

subplot(3,1,1);
plot(t, m_t);
title('Señal de Mensaje');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on;

subplot(3,1,2);
plot(t, c_t);
title('Señal Portadora');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on;

subplot(3,1,3);
plot(t, s_t);
title('Señal Modulada');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on;

% Representación en el dominio de la frecuencia de la señal modulada
N = length(s_t);      % Número de muestras
Y = fft(s_t) / N;     % Transformada de Fourier
f = fs * (0:(N / 2)) / N;   % Eje de frecuencias

figure('Name', 'Espectro de Frecuencia de la Señal Modulada');
plot(f, 2 * abs(Y(1:N/2+1)));
title('Espectro de Frecuencia de la Señal Modulada');
xlabel('Frecuencia (Hz)');
ylabel('Magnitud (V)');
grid on;