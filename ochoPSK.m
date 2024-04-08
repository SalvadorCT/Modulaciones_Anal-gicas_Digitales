clear
clc
close all hidden
format short

% Parámetros
fs = 10000; % Frecuencia de muestreo
t = 0:1/fs:0.1; % Vector de tiempo

% Señales de mensaje (I, Q y C)
Am = 1;
fm = 50;
m_I = Am .* (round(cos(2*pi*fm*t).^2));
m_Q = Am .* (round(sin(2*pi*fm*t).^2));
m_C = Am .* (round(cos(2*pi*fm*t+pi/4).^2));

% Señales portadoras
fc = 1000;
Ac = 0.8;
c = Ac .* cos(2*pi*fc*t - pi/8);

% Modulación 8-PSK
s_t = t;
for i=1:length(t)
    mBin = [num2str(m_I(i)) num2str(m_Q(i)) num2str(m_C(i))];
    m = bin2dec(mBin);
    s_t(i) = Ac .* cos(2*pi*fc*t(i) - m.*pi/8);
end

% Visualización en el dominio del tiempo
figure('Name', 'Modulación 8-PSK en el dominio del tiempo')
subplot(4, 1, 1);
plot(t, m_I, 'b');
title('Señal de Mensaje (m_I)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;
subplot(4, 1, 2);
plot(t, m_Q, 'b');
title('Señal de Mensaje (m_Q)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;
subplot(4, 1, 3);
plot(t, m_C, 'b');
title('Señal de Mensaje (m_C)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;

subplot(4, 1, 4);
plot(t, s_t, 'm');
title('Señal modulada 8-PSK (s_t)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;

% Espectro de frecuencia
N = length(s_t);      % Número de muestras
Y = fft(s_t) / N;     % Transformada de Fourier
f = fs * (0:(N/2)) / N;   % Eje de frecuencias

figure('Name', 'Espectro de frecuencia 8-PSK')
plot(f, 2 * abs(Y(1:N/2+1)), 'b', 'linewidth', 1.5);
title('Espectro de frecuencia 8-PSK');
xlabel('Frecuencia (Hz)');
ylabel('Magnitud (V)');
grid on;