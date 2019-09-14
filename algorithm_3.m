
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% This function is algorithm 3 based on NN.
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Inputs
% dim = dimension of the system
% G = Lattice generator matrix. Dimension of G is dim*dim.
% y = Noisy lattice point
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Outputs
% ouput_z1 = Estimated coordinate z1 based on noisy point y
% ouput_z2 = Estimated coordinate z2 based on noisy point y
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

function [output_z1, output_z2] = algorithm_3 (dim, G, y)

%% Generate four corners of a fundamental parallelope
coef = [0 0;0 1;1 0;1 1];
x = coef * G;

y1 = y(1);
y2 = y(2);

%% Calculate packing radius
d = zeros(dim+1,1);
for timer = 1:dim+1
    d(timer) = norm(x(timer,:) - x(timer+1,:));    
end

% rho is the packing radius. For A2 latice, rho = 1/2
rho = min(d)/2;

%% Estimate for z1
% stone is for disjusting which side of desicion boundary the target lattice point is
stone = 0;
z_pos = 1;

% Find Boolean equation for z1
[stone, grads, grads_all, points, points_all] = find_boolean_eq (z_pos, coef, x, rho, stone);

% Construct the pereptron with three layers
layers = generate_layers (grads);

% Update weights in pereptron
layers = update_layers(y1, y2, stone, layers, grads, grads_all, points_all);

output_z1 = layers{3};

%% Estimate for z2

stone = 0;
z_pos = 2;

% Find Boolean equation for z2
[stone, grads, grads_all, points, points_all] = find_boolean_eq (z_pos, coef, x, rho, stone);

% Construct the pereptron with three layers
layers2 = generate_layers (grads);

% Update weights in pereptron
layers2 = update_layers(y1, y2, stone, layers2, grads, grads_all, points_all);

output_z2 = layers2{3};

end