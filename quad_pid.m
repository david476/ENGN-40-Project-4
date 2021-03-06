% Takes current error, derivative, and integral as [x, y, z] with
% units of m (/s or *s respectively), and psi error as rad, returns desired linear
% acceleration and yaw velocity
% ([a_x, a_y, a_z, omega_psi] in m/s^2 and rad/s^2)
function [a_x, a_y, a_z, omega_psi] = quad_pid(error, error_derivative, error_integral, error_psi)

error_x = error(1);
error_y = error(2);
error_z = error(3);

error_dx = error_derivative(1);
error_dy = error_derivative(2);
error_dz = error_derivative(3);

error_ix = error_integral(1);
error_iy = error_integral(2);
error_iz = error_integral(3);

a_x = constants.Kpx*(error_x) + constants.Kdx*error_dx + constants.Kix*error_ix;
a_y = constants.Kpy*(error_y) + constants.Kdy*error_dy + constants.Kiy*error_iy;
a_z = constants.Kpz*(error_z) + constants.Kdz*error_dz + constants.Kiz*error_iz;

omega_psi = constants.Kpyaw*(error_psi);

end
