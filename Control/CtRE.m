function [dP] = CtRE(P,A,B,Q,R) 
%The continuous time Riccatti equation (CTRE). The CTRE is an ODE, an
%integrator is required to solve the equation.
dP = -(A'*P+P*A-P*B*inv(R)*B'*P+Q);
end

