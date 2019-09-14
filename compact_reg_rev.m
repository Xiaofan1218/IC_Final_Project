
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% This function is to recover the mapped points to original region
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Inputs
% x_ = Closest lattice points
% t = Coefficients of floor function
% G = Lattice generator matrix
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Output
% y = Mapped noisy point in fundamental parallelotope
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

function x0 = compact_reg_rev (x_,t,G)

x0 = x_ + (t * G);

end