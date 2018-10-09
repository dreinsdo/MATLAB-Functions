function [k1,k2,b2,m2] = tfcoeffs_spspdmp(tfnum,tfden)
% PURPOSE 
% Find transfer function (TF) coefficients for mass + parallel spring damper in series with spring.
%                                ___
%                           _____| | ___ b2___
%                  ____     |     |_|_
% ---/\/\k1/\/\---| m2 |----|
%                 |____|    |---/\/\k2/\/\-----


tfnum = tfnum/tfden(1);
tfden = tfden/tfden(1);
k1 = tfnum(1);
syms k2 b2 m2
eqn1 = b2*k1/m2 == tfnum(2);
eqn2 = (k2*k1)/m2 == tfnum(3);
eqn3 = (k2+k1)/b2 == tfden(3);
sol = solve([eqn1,eqn2,eqn3],[k2,b2,m2]);
k2 = double(sol.k2);
b2 = double(sol.b2);
m2 = double(sol.m2);
end

