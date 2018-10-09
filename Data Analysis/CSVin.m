function [out1, out2, out3, out4, out5, csvnames] = CSVin(xlspath, csvnames, csvfolderpath, R1, Rf, col2out)

% PURPOSE
% To import and organize data from CSV files.

% DESCRIPTION
% This function is intended to operate on multiple files within a
% directory, where filenames are read from an xls file of size nx1, n = qty
% of csv file names. 

% INPUTS
% - xlspath: path to xls file containing file names.
% - csvnames: name of xls file containing file names. Do not include .xls
% in filename (.xls automatically appended by this function file).The xls
% file should be organized as a single column of filen names. The order of
% column data in each output variable is determined by the order listed in
% csvnames.xls, e.g. for filenames listed in descending row order in
% csvnames.xls 'B, C, A', will result in three columns if data in each
% output variable with:
%       - column 1 data from B.csv
%       - column 2 data from C.csv
%       - column 3 data from A.csv
% - csvfolderpath: can be relative to current directory or absolute. Note: for 
% relative, path should begin with '\'  
% - R1: first row of *.csv to store, note that all csv data is to be
% numerical per MATLAB csvread function requirement/constraint. NOTE: R1 =
% 0 is first row of *.csv.
% - Rf: last row of *.csv to store. 
% - col2out: columns of each *.csv to assign to function outputs [out1,
% out2, out3, out4, out5]. Must contain 5 elements to match qty of output
% variables.

% OUTPUTS
% out: contains data read from the column number of 'col2out' of each
% *.csv.

% Import file names
csvnamespath = strcat(xlspath,'\',csvnames, '.xls'); % create path to csvnames file
[~,csvnames,~] = xlsread(csvnamespath); % write contents of csvnames.xls to 'csvnames'

% Import .csv data
for i1 = 1:length(csvnames) % loop operates on each *.csv
    csvpath = strcat(csvfolderpath,'\',csvnames{i1}, ' .csv'); 
    csvdata = csvread(csvpath,R1);
    out1{:,i1} = csvdata(1:Rf-R1+1, col2out(1));
    out2{:,i1} = csvdata(1:Rf-R1+1, col2out(2));
    out3{:,i1} = csvdata(1:Rf-R1+1, col2out(3));
    out4{:,i1} = csvdata(1:Rf-R1+1, col2out(4));
    out5{:,i1} = csvdata(1:Rf-R1+1, col2out(5));
end
end

