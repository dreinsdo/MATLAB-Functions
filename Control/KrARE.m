function [P,K] = KrARE(A,B,K,Q,R) 
%The K recursion Algebraic Riccatti equation (KrARE). The is function solves the ARE
%for P recursively. The equation is of Lyapunov form and solved as a system of linear
%equations. An initial state feedback matrix K is required for input.
    %Inputs:
        %sys = A+BK, the state feedback system in state space form
        %Q = cost matrix for states
        %K = state feedback matrix

%declare variables
P = sym('p_%d%d',length(A)); %initialize matrix of unknowns, find to solve ARE eqn
    
lhs = (A+B*K)'*P+P*(A+B*K)+Q+K'*R*K; %Equation left hands side
lhs = lhs(:); %Vectorize - matrix to column vector
eqn = lhs==0; %Build equations by equating terms per vector position
[lhs,rhs] = equationsToMatrix(eqn,P(:)); %Organize equations to matrix form
P = double(linsolve(lhs,rhs)); %Solve system of equations, yields vector form
P = reshape(P,size(A)); %Reshape vector into square matrix of original shape
K = -inv(R)*B'*P; %Calculate K
end

