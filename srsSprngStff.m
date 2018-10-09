function k2 = srsSprngStff(keff,k1)
% PURPOSE 
% Find stiffness of one spring of two in series spring config given
% effective stiffness of the system and 1 spring stiffness.
%
% ---/\/\k1/\/\--------/\/\k2/\/\----- ==> -----/\/\keff/\/\-----
%
%                

syms k2
eqn1 = (1/k1+1/k2)^-1 == keff;
sol = solve(eqn1,k2);
k2 = double(sol);
end

