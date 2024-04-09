clc
close all;
clear;

fs = 10000;
t = 0:1/fs:0.1;

% Señal de mensaje
Am = 1;
fm = 100; % 50
m_t = Am.*(2.*round(cos(2*pi*fm*t).^2)-1);

% Representación en el dominio del tiempo
figure('Name', 'Señales en el Dominio del Tiempo');

subplot(6,2,[1,3]);
plot(t, m_t,'m');
title('Señal de Mensaje sin Ruido');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on;

%Para añadir ruido al mensaje
SNR = 1;
n_t = max(m_t)/SNR.*rand(size(m_t));
r_t = m_t + n_t;

subplot(6,2,[5,7]);
plot(t, r_t,'m');
title('Señal de Mensaje con Ruido');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on;

% Señal portadora
fc = 2000;
Ac = 0.8;
c_t = Ac .* cos(2 * pi * fc * t);

subplot(6,2,[9,11]);
plot(t, c_t,'r');
title('Señal Portadora');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on;

% Modulación ASK
s_t = c_t + m_t.*c_t./Ac;

subplot(6,2,[2,4,6]);
plot(t, s_t);
title('Señal Modulada Sin Ruido');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on;

% Modulación ASK Con Ruido
sr_t = c_t + r_t .* c_t ./ Ac;

subplot(6,2,[8,10,12]);
plot(t, sr_t);
title('Señal Modulada Con Ruido');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on;

% Representación en el dominio de la frecuencia de la señal modulada
N = length(s_t);      % Número de muestras
Y = fft(s_t) / N;     % Transformada de Fourier
f = fs * (0:(N / 2)) / N;   % Eje de frecuencias

figure('Name', 'Espectro de Frecuencia de la Señal Modulada');
plot(f, 2 * abs(Y(1:N/2+1)));
title('Espectro de Frecuencia de la Señal Modulada sin ruido');
xlabel('Frecuencia (Hz)');
ylabel('Magnitud (V)');
grid on;

% Representación en el dominio de la frecuencia de la señal modulada
N = length(sr_t);      % Número de muestras
Y = fft(sr_t) / N;     % Transformada de Fourier
f = fs * (0:(N / 2)) / N;   % Eje de frecuencias

figure('Name', 'Espectro de Frecuencia de la Señal Modulada');
plot(f, 2 * abs(Y(1:N/2+1)));
title('Espectro de Frecuencia de la Señal Modulada con ruido');
xlabel('Frecuencia (Hz)');
ylabel('Magnitud (V)');
grid on;