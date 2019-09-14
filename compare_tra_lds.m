
clc; close all; clear;

sigma = [0.01:0.01:0.2];

dim = 4;

G = [2 0 0 0;1 1 0 0;1 0 1 0;1 0 0 1];

vnr = calculate_vnr (G, sigma);

range = [0 1;0 1;0 1;0 1];
sample_num = 5000;

co = generate_coef(range, sample_num, dim);
% co = [1 0];
y_or = co * G;

accuracy_1 = zeros(1,length(sigma));
accuracy_2 = zeros(1,length(sigma));
accuracy_3 = zeros(1,length(sigma));


for timer_sigma = 1:length(sigma)
    n = sigma(timer_sigma) * randn(size(y_or));
    y = y_or + n;

    %% ld_nearestplane
    
    vnp_output = zeros(sample_num,dim);
    tic
    for timer = 1:sample_num
        v_np = ld_nearestplane(G,y(timer,:));
        vnp_output(timer,:) = v_np;
    end
    toc
    t1 = toc;
    accuracy_1(timer_sigma) = accuracy_cal (y_or, vnp_output);

%     %% ld_roundoff
%     tic
%     v = ld_roundoff (y, G);
%     toc
%     t2 = toc;
%     accuracy_2(timer_sigma) = accuracy_cal (y_or, v);

    %% ld_roundoff
    vro_output = zeros(sample_num,dim);
    tic
    for timer = 1:sample_num
        v = ld_roundoff(y(timer,:),G);
        vro_output(timer,:) = v;
    end
    toc
    t2 = toc;
    accuracy_2(timer_sigma) = accuracy_cal (y_or, vro_output);    
    
    %% ld_MLD

    shpere_output = zeros(sample_num,dim);

    tic
    for timer = 1:sample_num
        u_closest = ld_spheredecodor(y(timer,:), G);
        shpere_output(timer,:) = u_closest;
    end
    toc
    t3 = toc;
    accuracy_3(timer_sigma) = accuracy_cal (y_or, shpere_output);
    
end


%% Plot

clc; close all;

error_1 = ones(size(accuracy_1)) - accuracy_1;
error_2 = ones(size(accuracy_1)) - accuracy_2;
error_3 = ones(size(accuracy_1)) - accuracy_3;



% figure;
% % hold on;
% % plot(accuracy_1);
% % semilogy(vnr,error_1);
% 
% semilogy(vnr,error_2);
% % semilogy(vnr,error_3);
% % plot(accuracy_3);

a1 = importdata ('p1_e1.mat');
a2 = importdata ('p1_e2.mat');
a3 = importdata ('p1_e3.mat');
a4 = importdata ('p1_e4.mat');
a5 = importdata ('p1_e5.mat');

figure;
hold on;
semilogy(vnr,a1);
semilogy(vnr,a2);
semilogy(vnr,a3);
semilogy(vnr,a4);
semilogy(vnr,a5);
