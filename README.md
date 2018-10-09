# MATLAB-Functions
PURPOSE 
  Organize useful MATLAB functions for data analysis, simulation, control, and signal processing.

BACKGROUND
  See each function file for a detailed description.

DATA ANALYSIS FUNCTIONS
- 'dtrnd.m': detrend data by removing an offset from zero (equilibirum) and a fit to the difference in positive and negative peaks of the data. Function was designed and tested for oscillitory input data.
- 'CSVin.m': import and organize data from CSV files.
- 'mgphs.m': computes the magnitude and phase of input time series data using the 1 sided FFT of the input data.
- 'BtFE.m': Backward time forward Euler (BtFE), 2nd order. Forward difference method used for integrating differential equations with error order dt^2 backward in time.
- 'FtFE.m': Forward time forward Euler (FtFE), 2nd order. Forward difference method used for integrating differential equations with error order dt^2

CONTROL FUNCTIONS
- 'KrARE.m': solves the K recursion Algebraic Riccatti equation (KrARE). The is function solves the ARE for P recursively. The equation is of Lyapunov form and solved as a system of linear equations. An initial state feedback matrix K is required for input.
- 'CtRE.m': solves the continuous time Riccatti equation (CTRE). The CTRE is an ODE, an integrator is required to solve the equation.
- 'expbode.m': creates an experimental bode plot from input/output gain and phase data at discrete frequencies and plots a smooth cubic spline between points.

SIGNAL PROCESSING FUNCTIONS
- 'NormLPFilterDiff.m': normalizes, low pass filters, and differentiates input data. It was originally written for processing ground reaction force (GRF) data, although any data can be used.
- 'ButterLPFn2.m': Butterworth filters input data. A low pass 2nd order Butterworth filter is used with backward time method for real time filtering.
- 'BandPassLPFn2.m': low pass 2nd order Band Pass filter with backward time method for real time filtering.

MECHANICAL SYSTEMS FUNCTIONS
- 'tfcoeffs_spspdmp.m': finds transfer function (TF) coefficients for mass + parallel spring damper in series with spring given a transfer function with 2nd order numerator and 2nd order denominator.
- 'tfcoeffs_spspdmp.m': finds transfer function (TF) coefficients for parallel spring damper in series with spring given a transfer function with 1st order numerator and 1st order denominator.
- 'srsSprngStff.m': Finds stiffness of one spring of two in series spring config given effective stiffness of the system and 1 spring stiffness.


