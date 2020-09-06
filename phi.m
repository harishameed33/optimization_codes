function phi = phi(x,r_p)
f = func(x)
g = constraint(x)
%h = constraint(x)
ncon = length(g);
P = 0; 
for j = 1:ncon
    P = P +(max(0,g(j)))^2;%+(h(j))^2
end
phi = f + r_p * P;
end