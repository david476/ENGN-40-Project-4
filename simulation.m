function simulation
% function to calculate position (x,y,z), veloctiy
m=38*10^-3; %kilograms
%Beta=7.923*10^-6; %Newtons
g=9.81; %Newtons
initial_w=[0,0,0,0,0,0,0,0,0,0,0,0]; %[x,y,z,yaw,vx,vy,vz,omega_psi,ex,ey,ez,e_omega_psi]

time_range=[0,50];

[t_values,sol_values] = ode45(@(t,w) diff_eq(t,w,m,g),time_range,initial_w);
plot(t_values,sol_values);
legend;
end

function dwdt=diff_eq(t,w,m,g)

[xstar,ystar,zstar,yawstar]=path(t);

%terms from w
x=w(1);
y=w(2);
z=w(3);
vx=w(4);
vy=w(5);
vz=w(6);
yaw=w(7);

if t>1
    [xstarold,ystarold,zstarold,yawstarold]=path(t-1);
dxerror=(xstar-x)-(xstarold-x);
dyerror=(ystar-y)-(ystarold-y);
dzerror=(zstar-z)-(zstarold-z);
dyawerror=(yawstar-yaw)-(yawstarold-yaw);
else
    dxerror=(xstar-x);
    dyerror=(ystar-y);
    dzerror=(zstar-z);
    dyawerror=(yawstar-yaw);
end

xint=int(xstar-x,t,0,t);
yint=int(ystar-y,t,0,t);
zint=int(zstar-y,t,0,t);
yawint=int(yawstar-yaw,t,0,t);

[tau,phi,theta,new_lambda]=controller_core(yaw, [xstar,ystar,zstar,yawstar],...
    [dxerror,dyerror,dzerror,dyawerror],[xint,yint,zint,yawint]);

%equations
dxdt=vx;
dydt=vy;
dzdt=vz;
dyawdt=omega_psi;
dvxdt=(sin(theta)*sin(yaw)+cos(theta)*sin(phi)*cos(yaw))*tau/m;
dvydt=(cos(theta)*sin(phi)*sin(yaw)-sin(theta)*cos(yaw))*tau/m;
dvzdt=cos(theta)*cos(phi)*tau/m-g;
domega_psidt=new_lambda;
dexdt=xstar-x;
deydt=ystar-y;
dezdt=zstar-z;
de_omega_psidt=yawstar-yaw;

dwdt=[dxdt;dydt;dzdt;dyawdt;dvxdt;dvydt;dvzdt;domega_psidt;dexdt;deydt;dezdt;de_omega_psidt];
end