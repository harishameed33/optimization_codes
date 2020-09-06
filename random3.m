% Random search method
%developed by Haris Hameed Mian
%PhD student
%NPU Xian China 

clc
clear all

f =@(x1,x2) x1^2+x2;
g1 =@(x1,x2) x1^2+x2^2-9;
g2 =@(x1,x2) x1+x2-1;
% a(1)=-2;
% a(2)=2;
nVar = 2;
n = 1e5;
epsilon = 1e-5;
% pre allocate the vectors
for i=1:nVar
    a=zeros(1,nVar);
    b=zeros(1,nVar);
end
% set up the search limits
for i=1:nVar
    a(i)=-2;
    b(i)=2;
end
fMin = 1e6;
fPrecedent = fMin;
j=0;
% search procedure
for i=1:n
    %x1=rand
     %nn = 20;     
     xmin=-1;
     xmax=1;
%      
     x1=xmin+rand(1,1)*(xmax-xmin);
%      R = [-1 1];
%      x1 = rand(1,1)*range(R)+min(R);
    
    
    x1=a(1)+x1*(b(1)-a(1));
    x2=xmin+rand(1,1)*(xmax-xmin);
   % x2 = rand(1,1)*range(R)+min(R);
    %x2=rand;
    x2=a(2)+x2*(b(2)-a(2));
    if i==1
        x1=-2;
        x2=2;
    end
    func = f(x1,x2);
    if (func-fMin<epsilon && g1(x1,x2)<=0 && g2(x1,x2)<=0)
        fMin = func;
        x1Min = x1;
        x2Min = x2;
        j=j+1;
        fprintf('i=%d x1=%f x2=%f fmin=%f\n',...
            j,x1Min,x2Min,fMin);
        if abs(fMin - fPrecedent)<=epsilon
            break;
        else
            fPrecedent = fMin;
        end
    end
end

 
 %
 % the graphical display range setup
%  [ x1 , x2 ] = meshgrid ( - 3 : 0.1 : 3 , - 3 : 0.1 : 3 ) ;
%  
%  f =x1.^2+x2;
%  g1 =x1.^2+x2.^2-9;
%  g2 =x1+x2-1;
%  %
%  % the objective function
%  %f = 2*x1+x2+ ( x1.A2 - x2.A2 ) + (x1-x2.A 2 ) . A2j0 %
%  % the constraint
%  %g = 8*xl-6*x2+21j
%  %
%  % the 3D display of f ( x 1 , x 2 ) and g ( x 1 , x 2 )
%  subplot ( 2 , 1, 1 ) ;
%  surf ( x1, x2 , f ) ;
%  hold on ;
%  %
%  surf ( x1, x2 , g1 ) ;
%  hold on ;
%  surf ( x1, x2 , g2 ) ;
%  hold off ;
%  
%  title( 'The 3D display of f ( x1 , x2 ) and g1 ( x 1 , x2 ) ' ) ;
%  xlabel( ' - 3 < xl < 3 ' ) ;
%  ylabel( ' - 3 < xl < 3 ' ) ;
%  % the contours of f ( x 1 , x 2 ) and g ( x 1 , x 2 )
%  subplot ( 2 , 1, 2 ) ;
%  [ c ] = contour (x1,x2,f,'-','color','k') ;
%  clabel ( c ) ;
%  hold on;
%  [ c ] = contour (x1,x2,g1,':','color','k') ;
%  clabel ( c ) ;
%  hold on;
%  [ c ] = contour (x1,x2,g2,'*','color','k') ;
%  clabel ( c ) ;
%  hold off ;
%  title( ' The contours of f ( x 1 , x 2 ) and g ( x 1 , x 2 ) ' ) ;
%  xlabel( ' - 3 < xl < 3 ' ) ;
%  ylabel ( ' - 3 < xl < 3 ' ) ;
% 
%     

