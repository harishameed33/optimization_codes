% Cubic Fit for minimizing a function 
% Written by Haris Hameed Mian
% PhD Student (2019180102)
% School of Aeronautics, NPU Xian China

clear all
clc

A=-1.033;
t0=0;
eps=1e-05;
f_A=fobj(A);
diff_A=dif_obj(A);
B=0;
f_B=fobj(B);
diff_B=dif_obj(B);
while (diff_B<=0)
    f_A=f_B;
    diff_A=diff_B;
    A=t0;
    t0=2*t0;
    f_B=fobj(t0);
    diff_B=fun(t0);
end
iter=0;
B=t0;
%Z=3*(f_A-f_B)/(B-A)+dif_obj(A)+dif_obj(B);
Z=3*(f_A-f_B)/(B-A)+diff_A+diff_B;
Q=sqrt(Z^2-diff_A*diff_B);
lamda_tstar=A+(diff_A+Z+Q*(B-A))/(diff_A+diff_B+2*Z);
iter=iter+1;

b=1/(A-B)^2*(B^2*diff_A+A^2*diff_B+2*A*B*Z);
c=-1/(A-B)^2*((A+B)*Z+B*diff_A+A*diff_B);
d=1/(3*(A-B)^2)*(2*Z+diff_A+diff_B);
a=f_A-b*A-c*A^2-d*A^3;
condition1=abs((cubic_fun(lamda_tstar,a,b,c,d)-fobj(lamda_tstar))/fobj(lamda_tstar));
%condition2=abs(dif_obj(lamda_tstar)/(dif_obj2(lamda_tstar)));
n=0;
k=0;
iter_max=30;
while (n==0)
         iter=iter+1;
         k=k+1;
         pre=lamda_tstar;
        %if ((condition1>eps) || (condition2>eps))
         if ((condition1>eps))
            if (iter>iter_max)
                lamda_star=lamda_tstar;
              n=n+1;
            else
                if (dif_obj(lamda_tstar)<0)
                    A=lamda_tstar;
                    f_A=fobj(lamda_tstar);
                    diff_A=dif_obj(lamda_tstar);
                else
                    B=lamda_tstar;
                    f_B=fobj(lamda_tstar);
                    diff_B=dif_obj(lamda_tstar);
                end
                Z=3*(f_A-f_B)/(B-A)+diff_A+diff_B
                if ((Z^2-diff_A*diff_B)<0)
                    continue
                end
                Q=sqrt(Z^2-diff_A*diff_B)
                lamda_tstar=A+(diff_A+Z+Q*(B-A))/(diff_A+diff_B+2*Z);
                %if((lamda_tstar<5) || (lamda_tstar>9.1))
                    lamda_tstar=pre;
                %end

                b=1/(A-B)^2*(B^2*diff_A+A^2*diff_B+2*A*B*Z)
                c=-1/(A-B)^2*((A+B)*Z+B*diff_A+A*diff_B)
                d=1/(3*(A-B)^2)*(2*Z+diff_A+diff_B)
                a=f_A-b*A-c*A^2-d*A^3
                condition1=abs((cubic_fun(lamda_tstar,a,b,c,d)-fobj(lamda_tstar))/fobj(lamda_tstar));
                %condition2=abs(dif_obj(lamda_tstar)/(dif_obj2(lamda_tstar)));
                chk=cubic_fun(lamda_tstar,a,b,c,d);
            end
        end
        if ((condition1<eps) )%&& (condition2<eps))
            lamda_star=lamda_tstar;
           n=n+1;
        end
end
sprintf('x_min=%f', lamda_star)
sprintf('f(x_min)=%f ', fobj(lamda_star))
plot(lamda_star,fobj(lamda_star),'ro')
grid on


