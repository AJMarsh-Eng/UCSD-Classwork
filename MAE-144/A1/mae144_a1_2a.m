%Code for problem 2a of A1. 
%goal is to make D(s) controller [y(s)/x(s)] to place poles of tf at s={-1,-1,-3,-3,-6,-6} 
clear,clc
b=RR_poly([-2 2 -5 5],1), a=RR_poly([-1 1 -3 3 -6 6],1), f1=RR_poly([-1 -1 -3 -3 -6 -6],1)
[x1,y1] = RR_diophantine(a,b,f1), test1=trim(a*x1+b*y1), residual1=norm(f1-test1)