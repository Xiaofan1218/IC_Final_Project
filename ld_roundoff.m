
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% This function is to implement RoundOff algorithm mentioned in reference
% "Gaussian sampling in lattice-based cryptography" worte by Thomas Prest
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Inputs
% c = Recieved noisy lattice points
% G = Lattice generator matrix
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Output
% v = The closest lattice point found via this NLD
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

function  v = ld_roundoff (c, G)

v = round(c/G);
v = v * G;

end