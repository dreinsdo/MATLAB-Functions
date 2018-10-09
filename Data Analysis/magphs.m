function [mag,phs,freq,f1u] = magphs(u,Ts)
% PURPOSE 
% This function computes the magnitude and phase of input time series data
% using the 1 sided FFT of the input data. Returns magnitude and phase data
% for all frequencies in 'freq' as nx1 vector where n=length(freq).

% BACKGROUND
% The 'fft' function computes the two sided FFT. The two sided FFT has half
% the peak amplitude at each at non-DC frequencies. DC frequencies are the
% first, middle, and last value.

% INPUTS 
% u: input data, code is tested for a vector only .
% Ts: sampling period, output 'freq' unit of measure is the inverse of the
% unit of Ts.

% OUTPUTS
% mag: magnitude of 1 sided FFT of input data for frequencies in 'freq' [mag].
% phs: phase of 1 sided FFT of input data for frequencies in 'freq' [deg].
% freq:  frequencies of FFT, refer to Ts for units.
% f1u: 1 sided fft of input data.

L = length(u); % number of samples in input data
freq = (1/Ts*(0:(L/2))/L)'; % frequency range of 1 sided FFT

f2u = fft(u); % two sided FFT
f1u = f2u(1:L/2+1); % drop second half of data to get values corresponding to 1 sided FFT
f1u(2:end-1) = 2*f1u(2:end-1); % multiply non DC values by two to yield 1 sided FFT

% Compute magnitude and phase, convert
mag = abs(f1u)/L; % amplitude of FFT = magnitude/(# of samples) [mag]
phs = angle(f1u)*180/pi; % phase of FFT, convert to deg [deg]
end

