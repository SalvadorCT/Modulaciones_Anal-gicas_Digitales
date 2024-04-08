clear
clc
close all hidden
format short

% Parámetros de la señal
fc = 100; % Frecuencia de la portadora en Hz
f1 = 50;   % Frecuencia de la primera señal de mensaje en Hz
f2 = 75;  % Frecuencia de la segunda señal de mensaje en Hz
Am1 = 0.5; % Amplitud de la primera señal de mensaje
Am2 = 0.3; % Amplitud de la segunda señal de mensaje
Ac = 1;    % Amplitud de la señal portadora
Kp = pi/4; % Índice de modulación de fase en radianes

% Tiempo de muestreo
fs = 10 * fc;
t = 0:1/fs:0.07;

m1_t = Am1 * cos(2*pi*f1*t);
m2_t = Am2 * cos(2*pi*f2*t);
m_t = m1_t + m2_t;
% Señal portadora
c_t = Ac * cos(2*pi*fc*t);

% Modulación en fase (PM)
s_t = Ac * cos(2*pi*fc*t + Kp*m_t);

figure;
subplot(3,1,1);
plot(t, m_t, 'b');
title('Señal de mensaje (Suma de dos señales senoidales)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;

subplot(3,1,2);
plot(t, c_t, 'r');
title('Señal portadora');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;

subplot(3,1,3);
plot(t, s_t, 'm');
title('Señal modulada en fase (PM)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;

N = length(s_t);      % Número de muestras
Y = fft(s_t)/N;       % Transformada de Fourier
f = fs*(0:(N/2))/N;   % Eje de frecuencias

figure('Name','Espectro de frecuencia (PM)')
plot(f, 2*abs(Y(1:N/2+1)));
title('Espectro de frecuencia (PM)');
xlabel('Frecuencia (Hz)');
ylabel('Magnitud (V)');
grid on;