function xout = BtFE(dxdt,dt,xin)
%Backward time forward Euler (BtFE). Forward difference method used for
%integrating differential equations with error order dt^2 backward in time.
xout = xin-dt*dxdt;
end
