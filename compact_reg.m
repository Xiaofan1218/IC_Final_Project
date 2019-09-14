
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% This function is to map the points ouside into fundamental parallelotope
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Inputs
% y0 = Recieved noisy lattice points
% G = Lattice generator matrix
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Output
% y = Mapped noisy point in fundamental parallelotope
% t = Coefficients of floor function
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

function [y, t] = compact_reg (y0, G)

t = floor(y0/G);
% t = t - 1;
y = y0 - (t * G);

end

