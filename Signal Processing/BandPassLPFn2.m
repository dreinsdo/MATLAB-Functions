function [y2] = BandPassLPFn2(wc,Ts,u2,y0,y1)
%PURPOSE
%This function filters input data. A low pass 2nd order Band Pass filter
%is used with backward difference method for real time filtering.

%DESCRIPTION: 
% The filter employs a backward time method that can be used for real time
% filtering. As such, only individual data points, as opposed to vectors,
% are passed into this function, i.e. data points are streamed as they are
% collected.

% The filter time domain response is discretized using a first order
% backward time method for the first derivative, meaning both the first
% derivative continuous time term arising from the second order filter is
% approximated as first order (linear) difference, e.g. for f'(x),
% f'(x)~=(f(x2)-f(x1))/deltax.

%INPUTS
% wc: filter cutoff freq [rad] Ts: sampling time [sec]; Rule of thumb for
% good performance (behavior like CT filter) Ts?1/(wc*5) u2: raw
% (unfiltered) data point at current sampling instance, where the current
% sampling instance is k=2; 
% y0: filtered data point from previous sampling instance k=0 (relative to
% current k=2).
% y1: filtered data point from previous sampling instance k=1 (relative to
% current k=2).

%OUTPUTS
% y2: filtered data point for current sampling instance k=2.

%% Declare filter coefficients 
% Coefficients simplifiy algebraic expression of filter 
a = (1+2/(wc*Ts)+1/(wc^2*Ts^2))^-1;
b = a*(2/(wc*Ts)+2/(wc^2*Ts^2));
c = a*1/(wc^2*Ts^2);

%% Filter input data
y2 = a*u2+b*y1-c*y0; 
end

