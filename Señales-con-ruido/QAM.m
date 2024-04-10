
clear
clc
close all hidden
format short

% Parámetros de la señal
fs = 1000;  % Frecuencia de muestreo
T = 1;      % Duración de la señal en segundos
fc = 100;   % Frecuencia de la portadora
N = fs * T; % Número de muestras
t = (0:N-1) * (1/fs); % Vector de tiempo

% Señal de mensaje (datos)
datos = randi([0 3], 1, N); % Se generan números aleatorios entre 0 y 3

% Codificación de los datos en símbolos QAM
M = 4; % Número de símbolos en la constelación QAM
mapping = qammod(datos, M);

% Señales portadoras en fase y en cuadratura
c_I = cos(2*pi*fc*t);
c_Q = sin(2*pi*fc*t);

% Señal QAM modulada
s_t = real(mapping) .* c_I - imag(mapping) .* c_Q;

% Visualización en el dominio del tiempo
figure('Name', 'Modulación QAM en el dominio del tiempo');
subplot(3,1,1);
plot(t, real(mapping), 'b');
title('Parte en fase (I)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;

subplot(3,1,2);
plot(t, imag(mapping), 'r');
title('Parte en cuadratura (Q)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;

subplot(3,1,3);
plot(t, s_t, 'm');
title('Señal modulada QAM (s_t)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;

% Espectro de frecuencia
Y = fft(s_t)/N;            % Transformada de Fourier
f = fs * (0:(N/2))/N;      % Eje de frecuencias

figure('Name', 'Espectro de frecuencia QAM');
plot(f, 2*abs(Y(1:N/2+1)));
title('Espectro de frecuencia QAM');
xlabel('Frecuencia (Hz)');
ylabel('Magnitud');
grid on;

