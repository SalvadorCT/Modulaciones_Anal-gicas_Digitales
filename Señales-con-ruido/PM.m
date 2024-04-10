clear
clc
close all hidden
format short

% Parámetros de la señal
fc = 200; % Frecuencia de la portadora en Hz
f1 = 20;   % Frecuencia de la primera señal de mensaje en Hz
f2 = 75;  % Frecuencia de la segunda señal de mensaje en Hz
Am1 = 0.5; % Amplitud de la primera señal de mensaje
Am2 = 0.3; % Amplitud de la segunda señal de mensaje
Ac = 1;    % Amplitud de la señal portadora
Kp = 10%pi/4; % Índice de modulación de fase en radianes

% Tiempo de muestreo
fs = 10 * fc;
t = 0:1/fs:0.07;

m1_t = Am1 * cos(2*pi*f1*t);
m2_t = Am2 * cos(2*pi*f2*t);
m_t = m1_t + m2_t;

% Representación en el dominio del tiempo
figure('Name', 'Señales en el Dominio del Tiempo');

subplot(6,2,[1,3]);
plot(t, m_t,'m');
title('Señal de mensaje (Suma de dos señales senoidales) sin Ruido');
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
c_t = Ac * cos(2*pi*fc*t);

subplot(6,2,[9,11]);
plot(t, c_t,'r');
title('Señal Portadora');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on;

% Modulación en fase (PM)
s_t = Ac * cos(2*pi*fc*t + Kp*m_t);

subplot(6,2,[2,4,6]);
plot(t, s_t);
title('Señal Modulada Sin Ruido');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on;

% Modulación en fase (PM)
sr_t = Ac * cos(2*pi*fc*t + Kp*r_t);

subplot(6,2,[8,10,12]);
plot(t, sr_t);
title('Señal Modulada Con Ruido');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
grid on;

N = length(s_t);      % Número de muestras
Y = fft(s_t)/N;       % Transformada de Fourier
f = fs*(0:(N/2))/N;   % Eje de frecuencias

figure('Name','Espectro de frecuencia (PM)')
plot(f, 2*abs(Y(1:N/2+1)));
title('Espectro de frecuencia (PM) sin ruido');
xlabel('Frecuencia (Hz)');
ylabel('Magnitud (V)');
grid on;

N = length(sr_t);      % Número de muestras
Y = fft(sr_t)/N;       % Transformada de Fourier
f = fs*(0:(N/2))/N;   % Eje de frecuencias

figure('Name','Espectro de frecuencia (PM)')
plot(f, 2*abs(Y(1:N/2+1)));
title('Espectro de frecuencia (PM) con ruido');
xlabel('Frecuencia (Hz)');
ylabel('Magnitud (V)');
grid on;