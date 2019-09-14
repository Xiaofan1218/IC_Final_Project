
clc; close all; clear;

sigma = 0.01;

dim = 2;
% G = [1 0;1/2 sqrt(3)/2];
% G = [1 0;0 1];
G = [1 1;1 -1];

fundamental_range = [0 1;0 1];
range = [0 1;0 1];
sample_num = 1000;


co = generate_coef(range, sample_num, dim);

y_or = co * G;

n = sqrt(sigma) * randn(size(y_or));
y = y_or + n;

% Plot x
scatter(y(:,1),y(:,2),20,'filled');
% axis([-0.5 3 -0.5 3]);






