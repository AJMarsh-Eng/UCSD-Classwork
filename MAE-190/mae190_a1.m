%mae190_a1

a=6378137;
%semi major axis in m
phi_a=deg2rad(32.867);
phi_b=deg2rad(21.430);
delt_a=deg2rad(117.257);
delt_b=deg2rad(157.630);

dgc=a*acos(sin(phi_a)*sin(phi_b)+cos(phi_a)*cos(phi_b)*cos(delt_b-delt_a))

tau_a=log(sec(phi_a)+tan(phi_a));
tau_b=log(sec(phi_b)+tan(phi_b));
gree=atan((delt_b-delt_a)/(tau_b-tau_a));

drh=a*abs(phi_b-phi_a)*abs(sec(gree))

abs(drh-dgc)/1000
