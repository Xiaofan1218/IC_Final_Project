
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
% co = [1 0];
y_or = co * G;

n = sqrt(sigma) * randn(size(y_or));
y = y_or + n;

% Plot x
scatter(y(:,1),y(:,2),20,'filled');
% axis([-0.5 3 -0.5 3]);

%% nld_roundoff

v = ld_roundoff (y, G);
accuracy_2 = accuracy_cal (y_or, v);


%% nld_nearestplane
vnp_output = zeros(sample_num,dim);

for timer = 1:sample_num
    v_np = ld_nearestplane(G,y(timer,:));
    vnp_output(timer,:) = v_np;
end
accuracy_3 = accuracy_cal (y_or, vnp_output);


%%

shpere_output = zeros(sample_num,dim);

for timer = 1:sample_num
    u_closest = ld_spheredecodor(y(timer,:), G);
    shpere_output(timer,:) = u_closest;
end
accuracy_4 = accuracy_cal (y_or, shpere_output);


%% nld_3
if isequal(fundamental_range, range)
else
    [y, t] = compact_reg (y, G);
    figure;
    scatter(y(:,1),y(:,2),20,'filled');
end


output_y = zeros(sample_num,dim);

for timer = 1:sample_num
    
    [output_z1, output_z2] = algorithm_3 (dim, G, y(timer,:));
    output_y(timer,1) = output_z1;
    output_y(timer,2) = output_z2;
end

if isequal(fundamental_range, range)
    output_y = output_y*G;
else
    output_y_1 = output_y * G;
    output_y = compact_reg_rev (output_y_1,t,G);
  
end

accuracy = accuracy_cal (y_or, output_y);

figure;
scatter(output_y(:,1),output_y(:,2),20,'filled');



