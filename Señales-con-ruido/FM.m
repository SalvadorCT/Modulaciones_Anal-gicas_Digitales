clear
clc
close all hidden
format short

Am = 1;     % Amplitud del mensaje
Ac = 1;     % Amplitud de la portadora
fm = 10;    % Frecuencia de mensaje
fc = 100;   % Frecuencia de portadora
b = 50;      % Indice de modulacion
Fs = 5000;  % Frecuencia de muestreo
t = 0:1/Fs:0.8; %1000 muestras

% Mensaje
msg = Am*sin(2*pi*fm*t);
subplot(6,2,[1,3]); 
plot(t, msg);
xlabel('Tiempo');
ylabel('Amplitud');
title('Mensaje sin Ruido');

%Para añadir ruido al mensaje
SNR = 3;
n_t = max(msg)/SNR.*rand(size(msg));
rmsg = msg + n_t;

subplot(6,2,[5,7]); 
plot(t, rmsg);
xlabel('Tiempo');
ylabel('Amplitud');
title('Mensaje con Ruido');

% Portadora
carrier = Ac*sin(2*pi*fc*t);

subplot(6,2,[9,11]);
plot(t, carrier);
xlabel('Tiempo');
ylabel('Amplitud');
title('Señal Portadora');

% Señal Modulada
y = Ac*sin(2*pi*fc*t + b*cos(2*pi*fm*t));

subplot(6,2,[2,4,6]);
plot(t, y);
xlabel('Tiempo');
ylabel('Amplitud');
title('Señal Modulada sin Ruido');

%Para añadir ruido a la señal modulada
SNR = 3;
n_t = max(y)/SNR.*rand(size(y));
yr_t = y + n_t;

% Señal Modulada con ruido
subplot(6,2,[8,10,12]);
plot(t, yr_t);
xlabel('Tiempo');
ylabel('Amplitud');
title('Señal Modulada con Ruido');

% Espectro de frecuencia de la señal modulada
figure('Name', 'Espectro de Frecuencia de la Señal Modulada');
N = length(y);           % Número de muestras
Y = fft(y)/N;            % Transformada de Fourier
f = Fs*(0:(N/2))/N;      % Eje de frecuencias
subplot(2,1,1);
plot(f, 2*abs(Y(1:N/2+1)));
xlabel('Frecuencia (Hz)');
ylabel('Amplitud');
title('Espectro de Frecuencia de la Señal Modulada sin Ruido');
grid on;

% Espectro de frecuencia de la señal modulada con ruido
N = length(yr_t);      % Número de muestras
Y = fft(yr_t)/N;       % Transformada de Fourier
f = Fs*(0:(N/2))/N;    % Eje de frecuencias
subplot(2,1,2);
plot(f, 2*abs(Y(1:N/2+1)));
xlabel('Frecuencia (Hz)');
ylabel('Amplitud');
title('Espectro de Frecuencia de la Señal Modulada con Ruido');
grid on;

