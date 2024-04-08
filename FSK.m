clear
clear
clc
close all hidden
format short

fs = 100000;
t = 0:1/fs:0.08;

% Señal de mensaje
Am = 1;
fm = 20;
m_t = Am.*(2.*round(cos(2*pi*fm*t).^2)-1);

% Señal portadora
fc = 500;
Ac = 1;
c_t = Ac .* cos(2*pi*fc*t);

% Modulación FSK
k = 200; % índice de modulación (Hz/V)
s_t = Ac.*cos(2.*pi.*t.*(fc + k*m_t));

figure('Name','Modulación (FSK)')

subplot(3, 1, 1);
plot(t, m_t, 'b');
title('Señal de mensaje (m_t)');
xlabel('Frecuencia (Hz)');
ylabel('Magnitud (V)');
grid on;

subplot(3, 1, 2);
plot(t, c_t, 'r');
title('Señal Portadora (c_t)');
xlabel('Frecuencia (Hz)');
ylabel('Magnitud (V)');
grid on;

subplot(3, 1, 3);
plot(t, s_t, 'm');
title('Señal Modulada (s_t)');
xlabel('Frecuencia (Hz)');
ylabel('Magnitud (V)');
grid on;


N = length(s_t);    % Número de muestras
Y = fft(s_t);       % Transformada de Fourier
f = linspace(fc-k,fc+k,N);   % Eje de frecuencias

figure('Name','Espectro de frecuencia (FSK)')
plot(f, abs(Y));
title('Espectro de frecuencia (FSK)');
xlabel('Frecuencia (Hz)');
ylabel('Magnitud (V)');
grid on;