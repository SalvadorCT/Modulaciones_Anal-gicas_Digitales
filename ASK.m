clear
clc
close all hidden
format short

fs = 10000;
t = 0:1/fs:0.1;

% Señal de mensaje
Am = 1;
fm = 50;
m_t = Am.*(2.*round(cos(2*pi*fm*t).^2)-1);

% Señal portadora
fc = 1000;
Ac = 0.8;
c_t = Ac .* cos(2*pi*fc*t);

% Modulación ASK
s_t = c_t + m_t.*c_t./Ac;

figure('Name','Modulación (ASK)')

subplot(3, 1, 1);
plot(t, m_t, 'b');
title('Señal de Mensaje (m_t)');
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
title('Señal modulada (s_t)');
xlabel('Frecuencia (Hz)');
ylabel('Magnitud (V)');
grid on;

N = length(s_t);      % Número de muestras
Y = fft(s_t)/N;       % Transformada de Fourier
f = fs*(0:(N/2))/N;   % Eje de frecuencias

figure('Name','Espectro de frecuencia (ASK)')
plot(f, 2*abs(Y(1:N/2+1)));
title('Espectro de frecuencia (ASK)');
xlabel('Frecuencia (Hz)');
ylabel('Magnitud (V)');
grid on;