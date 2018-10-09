function [xout,t] = FtFE(t,xin,dxdt,dt)
%Forward time forward Euler (FtFE). Forward difference method used for
%integrating differential equations with error order dt^2.
xout = xin+dt*dxdt;
end
