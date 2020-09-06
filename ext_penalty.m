% Penalty Method
%developed by Haris Hameed Mian
%PhD student
%NPU Xian China 
%dated : 20th Aug 2020

clear all
clc
format short
x0  = [2;2]; % initial design
x0_1(1)=x0(1,1);
x0_2(1)=x0(2,1);
p   = 0; % initial value of minimization counter
r_p = 0.001; % initial value of penalty multiplier
f   = func(x0);
f_last = 2 * f;
gamma = 10;
options = optimset( 'LargeScale' , 'off' , 'Display' , 'iter' );
i=1;
while (((abs((f-f_last)) >= 1e-4)|| max(g)<=0) || max(h)==0)
    i=i+1;
    f_last = f;
    [xstar,phistar,exitflag,output] = fminunc(@phi,x0,options,r_p)
    f = func(xstar)
    g = constraint(xstar)
    h = constraint(xstar)
    xstar1_save(p+1) = xstar(1);
    xstar2_save(p+1) = xstar(2);
    f_xstar_save(p+1) = f;
    g1_save(p+1)=g(1);
    h1_save(p+1)=h(1);
%     g2_save(p+1)=g(2);
%     g3_save(p+1)=g(3);
%     g4_save(p+1)=g(4);
%     g5_save(p+1)=g(5);
%     g6_save(p+1)=g(6);
%     g7_save(p+1)=g(7);
%     g8_save(p+1)=g(8);
%     g9_save(p+1)=g(9);
    exitflag_save(p+1)=exitflag;
    iterations(p+1)=output.iterations;
    p = p + 1; % increment minimization counter
    r_p = r_p * gamma; % increase penalty multiplier
    x0 = xstar; % use current xstar as next x0
    x0_1(i)=x0(1,1);
    x0_2(i)=x0(2,1);
    fnc=(x0(1,1)-2)^2+(x0(2,1)-1)^2;
    
    
    %D(p,:)={p,x0(1,1),x0(2,1),f_last,f,phistar,r_p};
    D(p,:)={p,x0(1,1),x0(2,1),phistar,r_p};
    
%     figure(1)
%     plot(p,phistar,'-*')
%     hold on
%     figure(2)
%     plot(p,x0,'*')
%     hold on
end

D

figure(1)
plot(1:i,x0_1,'-*')
hold on
plot(1:i,x0_2,'-o')
legend('x1','x2')
xlabel('iteration')
ylabel('x1 and x2')
