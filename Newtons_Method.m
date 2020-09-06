% Newton's Method 
% Written by Haris Hameed Mian
% PhD Student (2019180102)
% School of Aeronautics, NPU Xian China

clc
clear
%format short

% Function Definition (Enter your Function here):
syms X Y;
f=2*X^4+Y^2-4*X*Y+5*Y;

% Initial Guess (Choose Initial Guesses):
x(1) = 0;
y(1) = 0;
e = 10^(-12); % Convergence Criteria
i = 1; % Iteration Counter

% Gradient and Hessian Computation:
df_dx = diff(f, X);
df_dy = diff(f, Y);
J = vpa(([subs(df_dx,[X,Y], [x(1),y(1)]) subs(df_dy, [X,Y], [x(1),y(1)])]),4);% Gradient
ddf_ddx = diff(df_dx,X);
ddf_ddy = diff(df_dy,Y);
ddf_dxdy = diff(df_dx,Y);
ddf_ddx_1 = subs(ddf_ddx, [X,Y], [x(1),y(1)]);
ddf_ddy_1 = subs(ddf_ddy, [X,Y], [x(1),y(1)]);
ddf_dxdy_1 = subs(ddf_dxdy, [X,Y], [x(1),y(1)]);
H = vpa(([ddf_ddx_1, ddf_dxdy_1; ddf_dxdy_1, ddf_ddy_1]),4); % Hessian
S = inv(H); % Search Direction

% Optimization Condition:
while norm(J) > e
    I = [x(i),y(i)]';
    x(i+1) = I(1)-S(1,:)*J';
    y(i+1) = I(2)-S(2,:)*J';
    errorX(i+1)=x(i)-x(i+1);
    errorY(i+1)=y(i)-y(i+1);
    normC=sqrt(errorX.^2+errorY.^2);
    nJ(i+1)=double(norm(J));
    i = i+1;
    J = vpa([subs(df_dx,[X,Y], [x(i),y(i)]) subs(df_dy, [X,Y], [x(i),y(i)])]); % Updated Jacobian
    ddf_ddx_1 = subs(ddf_ddx, [X,Y], [x(i),y(i)]);
    ddf_ddy_1 = subs(ddf_ddy, [X,Y], [x(i),y(i)]);
    ddf_dxdy_1 = subs(ddf_dxdy, [X,Y], [x(i),y(i)]);
    H = vpa([ddf_ddx_1, ddf_dxdy_1; ddf_dxdy_1, ddf_ddy_1]);  %Updated Hessian
    S = inv(H); % New Search Direction
end

% Result Table:`
Iter = 1:i;
X_coordinate = x';
Y_coordinate = y';
Iterations = Iter';
ErrX=errorX';
ErrY=errorY';
NormM=nJ';
NormC=normC';
T = table(Iterations,X_coordinate,Y_coordinate,ErrX,ErrY);

% Plots:
fcontour(f, 'Fill', 'On');
hold on;
plot(x,y,'*-r');
grid on;

% Output:
fprintf('Initial Objective Function Value: %d\n\n',subs(f,[X,Y], [x(1),y(1)]));
if (norm(J) < e)
    fprintf('Minimum succesfully obtained...\n\n');
end
fprintf('Number of Iterations for Convergence: %d\n\n', i);
fprintf('Point of Minima: [%d,%d]\n\n', x(i), y(i));
fprintf('Objective Function Minimum Value after Optimization: %f\n\n', subs(f,[X,Y], [x(i),y(i)]));
disp(T)
