function [k1,k2,b2] = tfcoeffs_spspdmp(tfnum,tfden)
% PURPOSE 
% Find transfer function (TF) coefficients for parallel spring damper in series with spring.
%                         ___
%                   _____| | ___ b2___
%                   |    |_|_
% ---/\/\k1/\/\-----|
%                   |---/\/\k2/\/\-----


tfnum = tfnum/tfden(1);
tfden = tfden/tfden(1);
k1 = tfnum(1);
syms k2 b2
eqn1 = k1*k2/b2 == tfnum(2);
eqn2 = (k2+k1)/b2 == tfden(2);
sol = solve([eqn1,eqn2],[k2,b2])
k2 = double(sol.k2);
b2 = double(sol.b2);
end

