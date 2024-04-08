clear
clc
close all hidden
format short

% Parámetros
fs = 10000; % Frecuencia de muestreo
t = 0:1/fs:0.1; % Vector de tiempo

% Señales de mensaje (I y Q)
Am = 1;
fm = 50;
m_I = Am .* (2 .* round(cos(2*pi*fm*t).^2) - 1);
m_Q = Am .* (2 .* round(sin(2*pi*fm*t).^2) - 1);

% Señales portadoras (I y Q)
fc = 1000;
Ac = 0.8;
c_I = Ac .* cos(2*pi*fc*t);
c_Q = Ac .* sin(2*pi*fc*t);

% Modulación QAM
s_I = m_I .* c_I;
s_Q = m_Q .* c_Q;
s_t = s_I + s_Q;

% Visualización en el dominio del tiempo
figure('Name', 'Modulación QAM en el dominio del tiempo')
subplot(3, 1, 1);
plot(t, m_I, 'b');
title('Señal de Mensaje I (m_I)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;

subplot(3, 1, 2);
plot(t, m_Q, 'r');
title('Señal de Mensaje Q (m_Q)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;

subplot(3, 1, 3);
plot(t, s_t, 'm');
title('Señal modulada QAM (s_t)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;

% Espectro de frecuencia
N = length(s_t);      % Número de muestras
Y = fft(s_t) / N;     % Transformada de Fourier
f = fs * (0:(N/2)) / N;   % Eje de frecuencias

figure('Name', 'Espectro de frecuencia QAM')
plot(f, 2 * abs(Y(1:N/2+1)), 'b', 'linewidth', 1.5);
title('Espectro de frecuencia QAM');
xlabel('Frecuencia (Hz)');
ylabel('Magnitud (V)');
grid on;