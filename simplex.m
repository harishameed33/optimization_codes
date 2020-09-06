%simplex method
%developed by Haris Hameed Mian
%PhD student
%NPU Xian China 
%dated : 20th Aug 2020

clc;
clear all;

%% Objective function, number of constraints and min or max types
objf=[4 2 3]; %objective function coeffieients
nc=3 ; %number of constraints
type=2; % 2 for minimization and 1 for maximization

%% specify the constraints
str1(1,1).Type='<=';
str1(1,2).Type='=';
str1(1,3).Type='>=';

%% enter the matrix for the constraints
sc=[1 -2 1
    2 3 -1
    1 -5 6];
%% b matrix for the constraints 
bm=[5 2 3];


M=100*max(max(sc)); % could be any larger number
sc1=[];
%initialisation 
v_a=zeros(1,length(objf));
%initialisation 
v_e=[];
v_b=[];
v_ari=[];
sc2=[];
j=1;
for i=1:nc
    n=str1(1,i).Type;
    if n(1)~= '<' && isempty(sc2)
        sc2=zeros(nc,1);
    end
    switch str1(1,i).Type
        case '<=' 
            v_e=[v_e bm(i)];
            sc1(j,length(v_e))=1;
            v_b=[v_b,bm(i)];
            
        case '>='
            v_e=[v_e 0];
              sc1(j,length(v_e))=-1;
              v_ari=[v_ari bm(i)];
              sc2(j,length(v_ari))=1;
              v_b=[v_b,bm(i)];
              
        case'=' 
            v_ari=[v_ari bm(i)];
              sc2(j,length(v_ari))=1;
              v_b=[v_b,bm(i)];
              
    end
    j=j+1;
end

sc=[sc,sc1,sc2];
vari=[];
vari_a=[];
vari_e=[];
vari_ar=[];
for i=1:size(sc,2)
    str1(1,i).vari=['x',num2str(i)];
    vari=[vari,str1(1,i).vari,' '];
    if i<length(v_a)
        vari_a=[vari_a,str1(1,i).vari,' '];
    elseif i<=length(v_a)+length(v_e)
        vari_e=[vari_e,str1(1,i).vari,' '];
    else
        vari_ar=[vari_ar,str1(1,i).vari,' '];
    end
end
%Tableau 0
x=[v_a,v_e,v_ari];

if length(v_ari~=0)
    v_ar=ones(1,length(v_ari));
    if type==1
        v_ar=-M*length(v_ari).*v_ar;
    else
       v_ar=M*length(v_ari).*v_ar;
    end
else  v_ar=[];
end
Cj=[objf,0.*v_e,v_ar];
Vb=[];
Q=v_b;
Ci=[];
tabl=[];
for i=1:length(Q)
    tabl=[tabl; ' | '];
    str2(1,i).valeur=Q(i);
    ind=find(x==Q(i));
    str2(1,i).var_base=str1(1,ind).vari;
    Vb=[Vb,str2(1,i).var_base,' '];
    Ci=[Ci,Cj(ind)];
end
Z=sum(Ci.*Q);
for i=1:length(Cj)
    Zj(i)=sum(Ci'.*sc(:,i));
end
Cj_Zj=Cj-Zj;
l=[];
for i=1:nc
    if length(str2(1,i).var_base)==2
        l=[l;str2(1,i).var_base,' '];
    else
         l=[l;str2(1,i).var_base];
    end
end
fprintf('\n');
disp('============================Tableau 0==================================');
disp(['initialization of variables : ',vari]);
disp(['                   -activity         : ',num2str(v_a)]);
disp(['                   -slack            : ',num2str(v_e)]);
disp(['                   -artificial       : ',num2str(v_ar)]);
disp(['Cj               : ',num2str(Cj)]);
disp('_______________________________________________________________________');
disp([tabl,num2str(Ci'),tabl,l,tabl,num2str(Q'),tabl,num2str(sc),tabl]);
disp('_______________________________________________________________________');
disp(['Zj               : ',num2str(Zj)]); 
disp(['Cj-Zj            : ',num2str(Cj-Zj)]);        
disp(['Z                : ',num2str(Z)]);  
t=1;
arret=1;
while arret==1
    %tableau t
    if type==1
        num=max(Cj_Zj);num=num(1);
        num1=find(Cj_Zj==num);num1=num1(1);
        V_ent=str1(1,num1).vari;
    else
      g=min(Cj_Zj);g=g(1);
        num1=find(Cj_Zj==g);num1=num1(1);
        V_ent=str1(1,num1).vari;                ['x',num2str(num1)];
    end
    b=sc(:,num1);
    k=0;d=10000;
    for i=1:length(Q)
        if b(i)>0
            div=Q(i)/b(i);
            if d>div
                d=div;
                k=i;
            end
        end
    end
    if k~=0
        num2=k;
    else
        disp('cant find V.S: the solution is infinite ');
        break;
    end
    V_sort=str2(1,num2).var_base;
    str2(1,num2).var_base=str1(1,num1).vari;
    pivot=sc(num2,num1);
    Ci(num2)=Cj(num1);
    sc(num2,:)=sc(num2,:)./pivot;
    Q(num2)=Q(num2)/pivot;
    h=size(sc,1);
    for i=1:h
        if i~=num2
            Q(i)=Q(i)-sc(i,num1)*Q(num2);
            sc(i,:)=sc(i,:)-sc(i,num1).*sc(num2,:);
            
        end
    end
    Z=sum(Ci.*Q);
    for i=1:size(sc,2)
        Zj(i)=sum(Ci'.*sc(:,i));
    end
    Cj_Zj=Cj-Zj;
    l=[];V=[];
    for i=1:nc
        if length(str2(1,i).var_base)==2
            l=[l;str2(1,i).var_base,' '];
            V=[V,l(i,:),' '];
        else
          l=[l;str2(1,i).var_base];
          V=[V,l(i,:),' '];
        end
    end
    Vb=V;
disp(['===========================Tableau ',num2str(t),'===========================']);
disp(['V.E           : ',num2str(V_ent)]);
disp(['V.S           : ',num2str(V_sort)]);
disp(['Pivot         : ',num2str(pivot)]);
disp(['Var base      : ',num2str(Vb)]);
disp(['Cj            : ',num2str(Cj)]);
disp('_______________________________________________________________________');
disp([tabl,num2str(Ci'),tabl,l,tabl,num2str(Q'),tabl,num2str(sc),tabl]);
disp('_______________________________________________________________________');
disp(['Zj            : ',num2str(Zj)]); 
disp(['Cj-Zj         : ',num2str(Cj-Zj)]);        
disp(['Z             : ',num2str(Z)]);  
t=t+1;
if type==1
    a=max(Cj_Zj);a=a(1);
    if a<=0
        break;
    end
else
a=min(Cj_Zj);a=a(1); 
if a>=0 break;
end
end
end
p=num2str(Z);
