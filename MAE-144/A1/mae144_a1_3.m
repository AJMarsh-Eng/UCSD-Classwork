%Code for problem 3 of A1. 
%clear,clc

ys=20*[1 1]; xs=[1 10]; h=0.01; Ds=RR_tf(ys,xs)
Ds.K
i=3
function [Dz]=AJM_C2D_matched(Ds,h,omega_bar,causalbool)
    % function [Dz]=AJM_C2D_matched(Ds,h,omega_bar,causalbool)
    % Convert Ds(s) to Dz(z) using matched method.  If omega_bar is specified, Gain is applied
    % such that the dynamics of Ds(s) in the vicinity of this critical
    % frequency are mapped correctly. If it is not entered it will deafault
    % to 0.
    % TEST: ys=20*[1 1]; xs=[1 10]; h=0.01; Ds=RR_tf(ys,xs); omegac=sqrt(10); [Dz]=AJM_C2D_matched(Ds,h,omegac)
    %       disp('Corresponding Matlab solution:')
    %       opt = c2dOptions('Method','tustin','PrewarpFrequency',omegac); c2d(tf(ys,xs),h,opt)
        if nargin==2
            omegbar=0; 
        elseif nargin==3
            omegbar=omega_bar
            causalboo=true
        else 
            omegbar=omega_bar
            causalboo=causalbool
        end
        c=2/(f*h); m=Ds.num.n; n=Ds.den.n; b=RR_poly(0); a=b;
        fac1=RR_poly([1 1]); fac2=RR_poly([1 -1]);
        for j=0:m; b=b+Ds.num.poly(m+1-j)*c^j*fac1^(n-j)*fac2^j; end
        for j=0:n; a=a+Ds.den.poly(n+1-j)*c^j*fac1^(n-j)*fac2^j; end 
        Dz=RR_tf(b,a); Dz.h=h;Dz.K=
end % function AJM_C2D_matched
% function [Gz]=RR_C2D_zoh(Gs,h)
%     % function [Gz]=RR_C2D_zoh(Gs,h)
%     % Compute (exactly) the Gz(z) corresponding to a D/A-Gs(s)-A/D cascade with timestep h.
%     % TEST: bs=[1]; as=[1 2 1]; h=0.01; Gs=RR_tf(bs,as), [Gz]=RR_C2D_zoh(Gs,h)
%     %       disp('Corresponding Matlab solution:'), c2d(tf(bs,as),h,'zoh')
%     % Renaissance Robotics codebase, Chapter 9, https://github.com/tbewley/RR
%     % Copyright 2023 by Thomas Bewley, distributed under BSD 3-Clause License.
%         HATz=RR_tf([1 -1],[1 0]); HATz.h=h;
%         STEPs=RR_tf(1,[1 0]);
%         Gz=HATz * RR_Z(Gs*STEPs,h);
% end % function RR_C2D_zoh
% 
% function [Dz]=RR_C2D_tustin(Ds,h,omegac)
%     % function [Dz]=RR_C2D_tustin(Ds,h,omegac)
%     % Convert Ds(s) to Dz(z) using Tustin's method.  If omegac is specified, prewarping is applied
%     % such that the dynamics of Ds(s) in the vicinity of this critical frequency are mapped correctly.
%     % TEST: ys=20*[1 1]; xs=[1 10]; h=0.01; Ds=RR_tf(ys,xs); omegac=sqrt(10); [Dz]=RR_C2D_tustin(Ds,h,omegac)
%     %       disp('Corresponding Matlab solution:')
%     %       opt = c2dOptions('Method','tustin','PrewarpFrequency',omegac); c2d(tf(ys,xs),h,opt)
%     % Renaissance Robotics codebase, Chapter 9, https://github.com/tbewley/RR
%     % Copyright 2023 by Thomas Bewley, distributed under BSD 3-Clause License. 
%         if nargin==2, f=1; else, f=2*(1-cos(omegac*h))/(omegac*h*sin(omegac*h)); end
%         c=2/(f*h); m=Ds.num.n; n=Ds.den.n; b=RR_poly(0); a=b;
%         fac1=RR_poly([1 1]); fac2=RR_poly([1 -1]);
%         for j=0:m; b=b+Ds.num.poly(m+1-j)*c^j*fac1^(n-j)*fac2^j; end
%         for j=0:n; a=a+Ds.den.poly(n+1-j)*c^j*fac1^(n-j)*fac2^j; end, Dz=RR_tf(b,a); Dz.h=h;
% end % function RR_C2D_tustin