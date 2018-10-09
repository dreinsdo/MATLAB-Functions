function [expbodeplot, mag, phs] = expbode(magu,phsu,magy,phsy,freq,fn, magylim,phsylim)
% PURPOSE
% Creates an experimental bode plot from input/output gain and phase data
% at discrete frequencies and plots a smooth cubic spline between points.

% INPUTS
% magu: magnitude of input [mag]
% phsu: phase of input [deg]
% magy: magnitude of output [mag]
% phsy: phase of output [deg]
% freq: vector of frequencies corresponding to the phases and magnitudes of
% 'magu, phsu, magy, phsy'
% fn: figure number
% magylim: y axis limits for magnitude subplot
% phsylim: y axis limits for phase subplot

% Compute magnitude and phase
mag = 20*log10(magy./magu); % out/in magnitude [dB]
phs = phsu-phsy; % phase [deg]
csmag = csapi(freq, mag); % cubic spline of magnitude [dB]
csphs = csapi(freq,phs); % cubic spline of phase [deg]

expbodeplot = figure(fn)
subplot(2,1,1)
title('Experimental Bode plot')
scatter(freq, mag, 15, 'filled');
set(gca,'xscale','log')
hold on
fnplt(csmag,0.5) % plot cubic spline
ylim(magylim)
xlabel('Frequency [rad/sec]')
ylabel('Magnitude [dB]')

subplot(2,1,2)
scatter(freq, phs, 15, 'filled')
set(gca,'xscale','log')
hold on 
fnplt(csphs,0.5) % plot cubic spline
ylim(phsylim)
xlabel('Frequency [rad/sec]')
ylabel('Phase [deg]')
end

