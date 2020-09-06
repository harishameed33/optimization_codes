function [g] = constraint(x)
%h(1) = x(1)-2*x(2)+1;
g(1)=x(1)-2*x(2)+1;
g(2)=0.25*x(1)^2+x(2)^2-1;