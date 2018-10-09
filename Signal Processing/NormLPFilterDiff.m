function [procout, dprocout] = NormLPFilterDiff(rawin,normalizefactor,wc,Ts)
% PURPOSE
% This function normalizes, low pass filters, and differentiates input
% data. It was originally written for processing ground reaction force
% (GRF) data, although any data can be used.

% DESCRIPTION:  
% The function performs the following tasks:
% 1. Normalizes input data by scalar factor. Set normalizefactor = 1 to
% mathematically skip this step (normalization input = normalization
% output).
% 2. Filters input data using a 2nd order low pass Butterworth filter
% 3. Takes the first derivative of the data employing a backward difference
% method

% Filtering and differentiation are performed on columns of data. As such,
% input data should be organized as follows:
% - Columns represent a single variable, rows represent equally spaced (in
% time, space, etc.) instances/measurements of that variable. 
    % e.g.,  for an array of multiple columns, columnn 1 is a single DOF
    % force % measruement from a load cell and rows are sampling points in
    % time.
    
 
% Filter description:
% A low pass 2nd order Butterworth filter is used with a backward time
% difference method. The filter employs a backward time method that can be
% used for real time filtering. As such, only individual data points, as
% opposed to vectors, are passed into the filter portion of this function,
% i.e. data points are streamed as they are collected.

% The filter time domain response is discretized using a first order
% backward time method for the first derivative, meaning both the first
% derivative continuous time term arising from the second order filter is
% approximated as first order (linear) difference, e.g. for f'(x),
% f'(x)~=(f(x2)-f(x1))/deltax.

% The filter is of the following form:
% y2 = a*u2+b*y1-c*y0; 
% where:
% u2: raw (unfiltered) data point at current sampling instance, where the current
% sampling instance is k=2; 
% y0: filtered data point from previous sampling instance k=0 (relative to
% current k=2).
% y1: filtered data point from previous sampling instance k=1 (relative to
% current k=2).
% y2: filtered data point for current sampling instance k=2.
    % NOTE: as the filter is second order and a backward time method is
    % employed, two prev. time steps are used.

%INPUTS
% rawin: input data, see §Description for data form.
% noramlizefactor: scalar factor by which data is normalized. 
% wc: filter cutoff freq [rad] 
% Ts: sampling time [sec]; Rule of thumb for good filter performance (behavior
% like CT filter) Ts?1/(wc*5)

%OUTPUTS
% procout: array of normalized, filtered, and differentiated data point.
% dprocout: array of differences of procout data point. First order
% (linear) backward time difference is used. Note that as a first order
% method is used, 'dprocout' will contain one less row than 'procout'.
%% Normalize input data
dummy = rawin/normalizefactor; % use dummy variable
%% Filter input data
% Declare filter coefficients. Coefficients simplifiy algebraic expression
% of filter
a = (1+sqrt(2)/(wc*Ts)+1/(wc^2*Ts^2))^-1;
b = a*(sqrt(2)/(wc*Ts)+2/(wc^2*Ts^2));
c = a*1/(wc^2*Ts^2);
% Filter
procout(1:2,:) = dummy(1:2,:); % copy initial values from rawin, required for filter function (2nd order backward time requires two prev. time steps)
for i1 = 1:size(dummy,2) % outer loop selects column, operates on columns (variables) so all columns of input data are filtered
        for i2 = 3:size(dummy,1) % inner loop filters, operates on rows (instances) to Butterworth filter data
            procout(i2,i1) = a*dummy(i2,i1)+b*procout(i2-1,i1)-c*procout(i2-2,i1); 
        end
end
%% Differentiate filtered data
for i1 = 1:size(procout,2) % compute differences for each input variable 
    dprocout(:,i1) = (procout(2:end,i1)-procout(1:(end-1),i1))./Ts; % store differences in next empty column of procout
end
end