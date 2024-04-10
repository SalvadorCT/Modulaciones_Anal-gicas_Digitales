clear;
clc;
close all hidden;
format short;

% Parámetros
fs = 10000; % Frecuencia de muestreo
t = 0:1/fs:0.1; % Vector de tiempo

% Señales de mensaje (I, Q, J y K)
Am = 1;
fm = 50;
m_I = Am .* (round(cos(2*pi*fm*t).^2));
m_Q = Am .* (round(sin(2*pi*fm*t).^2));
m_J = Am .* (round(cos(2*pi*fm*t+pi/4).^2));
m_K = Am .* (round(sin(2*pi*fm*t+pi/4).^2));

% Señales portadoras
fc = 1000;
Ac = 0.8;
c = Ac .* cos(2*pi*fc*t - pi/8);

% Modulación 16-PSK
s_t = t;
for i=1:length(t)
    mBin = [num2str(m_I(i)) num2str(m_Q(i)) num2str(m_J(i)) num2str(m_K(i))];
    m = bin2dec(mBin);
    s_t(i) = Ac .* cos(2*pi*fc*t(i) - m.*pi/16);
end

% Visualización en el dominio del tiempo
figure('Name', 'Modulación 16-PSK en el dominio del tiempo');
subplot(5, 1, 1);
plot(t, m_I, 'b');
title('Señal de Mensaje (m_I)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;
subplot(5, 1, 2);
plot(t, m_Q, 'b');
title('Señal de Mensaje (m_Q)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;
subplot(5, 1, 3);
plot(t, m_J, 'b');
title('Señal de Mensaje (m_J)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;
subplot(5, 1, 4);
plot(t, m_K, 'b');
title('Señal de Mensaje (m_K)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;

% Sección de señal modulada 16-PSK con ruido
subplot(5, 1, 5);
%figure('Name', 'Señal modulada 16-PSK con ruido');
plot(t, s_t, 'm');
title('Señal modulada 16-PSK con ruido (r_t)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% m_I m_Q m_K s_t

% Para añadir ruido al mensaje
SNR = 1;
n_t = max(s_t)/SNR .* rand(size(s_t));
m_I = m_I + n_t;

% Visualización en el dominio del tiempo
figure('Name', 'Modulación 16-PSK en el dominio del tiempo');
subplot(5, 1, 1);
plot(t, m_I, 'b');
title('Señal de Mensaje (m_I)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;

% Para añadir ruido al mensaje
SNR = 1;
n_t = max(s_t)/SNR .* rand(size(s_t));
m_Q = m_Q + n_t;

subplot(5, 1, 2);
plot(t, m_Q, 'b');
title('Señal de Mensaje (m_Q)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;

% Para añadir ruido al mensaje
SNR = 1;
n_t = max(s_t)/SNR .* rand(size(s_t));
m_J = m_J + n_t;

subplot(5, 1, 3);
plot(t, m_J, 'b');
title('Señal de Mensaje (m_J)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;

% Para añadir ruido al mensaje
SNR = 1;
n_t = max(s_t)/SNR .* rand(size(s_t));
m_K = m_K + n_t;

subplot(5, 1, 4);
plot(t, m_K, 'b');
title('Señal de Mensaje (m_K)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Espectro de frecuencia
N = length(s_t);      % Número de muestras
Y = fft(s_t) / N;     % Transformada de Fourier
f = fs * (0:(N/2)) / N;   % Eje de frecuencias

% Sección de señal modulada 16-PSK con ruido
subplot(5, 1, 5);
%figure('Name', 'Señal modulada 16-PSK con ruido');
plot(t, s_t, 'm');
title('Señal modulada 16-PSK con ruido (r_t)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;

% Espectro de frecuencia de la señal modulada 16-PSK con ruido
figure('Name', 'Espectro de frecuencia 16-PSK con ruido');
plot(f, 2 * abs(Y(1:N/2+1)), 'b', 'linewidth', 1.5);
title('Espectro de frecuencia 16-PSK con ruido');
xlabel('Frecuencia (Hz)');
ylabel('Magnitud (V)');
grid on