clc
close all;
clear;

fs = 10000;
t = 0:1/fs:0.1;

% Señal de mensaje
Am = 1;
fm = 20; % 50
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
fc = 200;
Ac = 0.5;
c_t = Ac .* cos(2 * pi * fc * t);

subplot(6,2,[9,11]);
plot(t, c_t,'r');
title('Señal Portadora');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on;

% Modulación QPSK
m_I = Am .* (2 .* round(cos(2*pi*fm*t).^2) - 1);
m_Q = Am .* (2 .* round(sin(2*pi*fm*t).^2) - 1);

s_t = m_I .* cos(2*pi*fc*t) - m_Q .* sin(2*pi*fc*t);

subplot(6,2,[2,4,6]);
plot(t, s_t);
title('Señal Modulada QPSK Sin Ruido');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on;

% Modulación QPSK con ruido
SNR = 1;
n_t = max(s_t)/SNR.*rand(size(s_t));
sr_t = s_t + n_t;

subplot(6,2,[8,10,12]);
plot(t, sr_t);
title('Señal Modulada QPSK Con Ruido');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on;

% Representación en el dominio de la frecuencia de la señal modulada QPSK
N = length(s_t);                % Número de muestras
Y = fft(s_t);                   % Transformada de Fourier
f = linspace(-fs/2, fs/2, N);   % Eje de frecuencias

figure('Name', 'Espectro de Frecuencia de la Señal Modulada QPSK', 'Position', [100, 100, 1000, 400]);
plot(f, abs(fftshift(Y)));
title('Espectro de Frecuencia de la Señal Modulada QPSK sin ruido');
xlabel('Frecuencia (Hz)');
ylabel('Magnitud (V)');
grid on;

% Representación en el dominio de la frecuencia de la señal modulada QPSK con ruido
N = length(sr_t);               % Número de muestras
Y = fft(sr_t);                  % Transformada de Fourier
f = linspace(-fs/2, fs/2, N);   % Eje de frecuencias

figure('Name', 'Espectro de Frecuencia de la Señal Modulada QPSK', 'Position', [100, 100, 1000, 400]);
plot(f, abs(fftshift(Y)));
title('Espectro de Frecuencia de la Señal Modulada QPSK con ruido');
xlabel('Frecuencia (Hz)');
ylabel('Magnitud (V)');
grid on;