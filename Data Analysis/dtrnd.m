function ydtrnd = dtrnd(y,iyoffst,dipk,MinPeakDistance,fitType,itrnc)
% PURPOSE 
% To detrend data 'u' by removing an offset from zero (equilibirum)
% and a fit to the difference in positive and negative peaks of the data.

% BACKGROUND 
% This function was designed and tested for an oscillitory input
% (specifically a chirp). The data is detrended in two ways:
% (1) Offset from zero is subtracted from all elements
% (2) A trend, or slope, is subtracted from all elements. This trend (pos
% or neg) is computed by taking the difference between mean pos and neg
% peak values, means are computed across an interval of size = 'dipk'
% elements. The type of fit used to compute this trend is dictated by input
% 'fitType'. 
% Data can be truncated after detrending. The behavior of fit 'fittyp' to
% the data can result in inaccurate behavior at end of output data after
% detrending.

% INPUTS
% y: input data, tested for nx1 vectors only.
% iyoffst: index of element in u used to remove offset, i.e. the
% corresponding value in u will be subtracted from all elements in u.
% dipk: the size of the range of of peak data to be averaged, the range is
% length 'dipk', e.g. for 'dipk' = 4, peaks 1-4, 5-8, etc. will be
% averaged.
% MinPeakDistance: the minimum distance between peaks, used to reject peaks
% resulting in local, undesired, high frequency behavior. This is an input
% to MATLAB 'findpeaks' function, see function doc for further details.
% fitType: Type of fit used to compute data trend. This is an input to
% MATLAB 'fit' function, see function doc for further details.
% itrnc: Amount of data points to remove (truncate) after detrending. See
% Background section for additional details.

% OUTPUTS
% y: detrended input data 'y'.

% CODE

y = y-y(iyoffst); % remove equilibrium offset

% Positive peak operations
    % Find positive peaks
    [ypks,lypks] = findpeaks(y, 'MinPeakDistance',MinPeakDistance); % peaks with min peak distance = based on highest input freq and sampling freq
        % Verify all positive peaks are 'global'(could be negative if there is an oscillation in the lower half plane) 
        iypks = ypks > 0; % find indices of positive peaks only
        ypks = ypks(iypks); % store positive peaks only
        lypks = lypks(iypks); % store locations of pos peaks only
    % Average positive peaks
        % Create vector 'ipks' to store the range of indices of peak
        % data to be averaged, the range is length 'dipk', e.g. for
        % 'dipk' = 4, peaks 1-4, 5-8, etc. will be averaged. Row 1 of
        % 'ipks' contains index of first index in each range, row 2 is
        % index of last element in each range. Each column defines the
        % range of peak values to be mean averaged.
        ipks = (1:dipk:length(ypks)-dipk); % vector of indices of first element in each range
        ipks(2,:) = ipks(1,:)+dipk-1; % vector of indices of last element in each range
     for i1 = 1:length(ipks) % operates on time (dim 1)
        yppksmn(i1,1) = mean(ypks(ipks(1,i1):ipks(2,i1),1)); % compute pos peak means across ranges of 'ipks'
        lyppksmn(i1,1) = mean(lypks(ipks(1,i1):ipks(2,i1),1));
     end

% Negative peak operations
    % Find positive peaks
    [ypks,lypks] = findpeaks(-y, 'MinPeakDistance',MinPeakDistance); % peaks with min peak distance = based on highest input freq and sampling freq
    % Verify all neg peaks are 'global'(could be negative if there is an oscillation in the upper half plane) 
    iypks = ypks > 0; % find indices of neg peaks only
    ypks = -ypks(iypks); % store neg peaks only, invert to make peak values neg
    lypks = lypks(iypks); % store locations of neg peaks only
    % Average positive peaks - see explanation in corresponding section above
        ipks = (1:dipk:length(ypks)-dipk); % vector of indices of first element in each range
        ipks(2,:) = ipks(1,:)+dipk-1; % vector of indices of last element in each range
    for i1 = 1:length(ipks) % operates on time (dim 1)
        ynpksmn(i1,1) = mean(ypks(ipks(1,i1):ipks(2,i1),1)); % compute neg peak means across ranges of 'ipks'
        lynpksmn(i1,1) = mean(lypks(ipks(1,i1):ipks(2,i1),1));
    end

% Find average of pos and neg peaks: (pos + neg)/2,this results in equal
% spacing between pos and neg peaks across zero line
for i1 = 1:min(length(yppksmn),length(ynpksmn)) % operates on pos and neg peak means, min is used because pairs of pos+neg peak values are required
  ya(i1,1) = (yppksmn(i1,1)+ynpksmn(i1,1))/2;
  lya(i1,1) = (lyppksmn(i1,1)+lynpksmn(i1,1))/2;
end

% Detrend data
fya = fit(lya,ya,fitType); % fit curve to amplitude differences
ytrnd = fya(1:length(y)); % compute offset in y values from fit for all y values
ydtrnd = y-ytrnd;  % detrend data, subtract offset from all y
ydtrnd = ydtrnd(1:end-itrnc,1); % truncate data
end

