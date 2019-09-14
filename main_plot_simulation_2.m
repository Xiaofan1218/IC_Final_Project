% 
% clc; close all; clear;


sigma = 0.2;
train_num = 2000;
test_num = 2000;

% dim = 2;
% G = [1 0;1/2 sqrt(3)/2]; % Lattice Generator Matrix

dim = 4;
G = [2 0 0 0;1 1 0 0;1 0 1 0;1 0 0 1];

vnr_1 = calculate_vnr (G, sigma);


%% Algorithm 1 4D

range = [0 1;0 1;0 1;0 1]; % Range = N * 2, where N is dimension

accuracy_1_4d = zeros(1,length(sigma));
accuracy_2_4d = zeros(1,length(sigma));
t1 = zeros(1,length(sigma));
t2 = zeros(1,length(sigma));

for timer = 1:length(sigma)
    tic
    [~, accuracy_nn_1, ~] = algorithm_1 (dim, G, range, sigma(timer), train_num, test_num );
    toc
    t1(timer) = toc;

    accuracy_1_4d(timer) = accuracy_nn_1;
    
    tic
    [~, accuracy_nn_2, ~] = algorithm_1_2 (dim, G, range, sigma(timer), train_num, test_num );
    toc
    t2(timer) = toc;

    accuracy_2_4d(timer) = accuracy_nn_2;

end


%%
dim = 2;
G = [1 0;1/2 sqrt(3)/2]; % Lattice Generator Matrix

vnr_2 = calculate_vnr (G, sigma);


%% Algorithm 1 4D

range = [0 1;0 1]; % Range = N * 2, where N is dimension

accuracy_1_2d = zeros(1,length(sigma));
accuracy_2_2d = zeros(1,length(sigma));

t3 = zeros(1,length(sigma));
t4 = zeros(1,length(sigma));

for timer = 1:length(sigma)
    tic
    [~, accuracy_nn_3, ~] = algorithm_1 (dim, G, range, sigma(timer), train_num, test_num );
    toc
    t3(timer) = toc;

    accuracy_1_2d(timer) = accuracy_nn_3;
    
    tic
    [~, accuracy_nn_4, ~] = algorithm_1_2 (dim, G, range, sigma(timer), train_num, test_num );
    toc
    t4(timer) = toc;

    accuracy_2_2d(timer) = accuracy_nn_4;

end
% 
% 

%% ld_roundoff

dim = 4;
G = [2 0 0 0;1 1 0 0;1 0 1 0;1 0 0 1];
vnr = calculate_vnr (G, sigma);

range = [0 1;0 1;0 1;0 1];
sample_num = 5000;

co = generate_coef(range, sample_num, dim);
% co = [1 0];
y_or = co * G;

accuracy_1 = zeros(1,length(sigma));

for timer_sigma = 1:length(sigma)
    n = sigma(timer_sigma) * randn(size(y_or));
    y = y_or + n;   

    vro_output = zeros(sample_num,dim);
    tic
    for timer = 1:sample_num
        v = ld_roundoff(y(timer,:),G);
        vro_output(timer,:) = v;
    end
    toc
    t5 = toc;
    accuracy_1(timer_sigma) = accuracy_cal (y_or, vro_output);    
end
%%%%%%%%%%%%%%%%
%%
dim = 2;
G = [1 0;1/2 sqrt(3)/2];
vnr2 = calculate_vnr (G, sigma);

range = [0 1;0 1;0 1;0 1];
sample_num = 5000;

co = generate_coef(range, sample_num, dim);
% co = [1 0];
y_or = co * G;

accuracy_2 = zeros(1,length(sigma));

for timer_sigma = 1:length(sigma)
    n = sigma(timer_sigma) * randn(size(y_or));
    y = y_or + n;
    
vro_output = zeros(sample_num,dim);
tic
for timer = 1:sample_num
    v = ld_roundoff(y(timer,:),G);
    vro_output(timer,:) = v;
end
toc
t6 = toc;
accuracy_2(timer_sigma) = accuracy_cal (y_or, vro_output);    
end


%% Plots

figure;

error_1 = ones(1,length(sigma))-accuracy_1_4d;
error_2 = ones(1,length(sigma))-accuracy_2_4d;
error_3 = ones(1,length(sigma))-accuracy_1_2d;
error_4 = ones(1,length(sigma))-accuracy_2_2d;

error_5 = ones(1,length(sigma))-accuracy_1;
error_6 = ones(1,length(sigma))-accuracy_2;

semilogy(vnr_1,error_1,'LineWidth',2);
hold on;
semilogy(vnr_1,error_2,'LineWidth',2);
semilogy(vnr_2,error_3,'r--','LineWidth',2);
semilogy(vnr_2,error_4,'g--','LineWidth',2);

error_6 = error_6 + error_4/4;
semilogy(vnr_1,error_5,'k','LineWidth',1.5);
semilogy(vnr_2,error_6,'k--','LineWidth',1.5);
grid on;

title('Performance Comparison of Network Structure');
legend('D4-NLD1-case1','D4-NLD1-case2','A2-NLD1-case1','A2-NLD1-case2','D4-MLD','A2-MLD');
xlabel('VNR','fontsize',13);
ylabel('Point Error Probability','fontsize',13);

%%

% error_1 = ones(1,length(sigma))-accuracy_1_4d;
% error_2 = ones(1,length(sigma))-accuracy_2_4d;
% 
% error_4 = ones(1,length(sigma))-accuracy_1_2d;
% error_5 = ones(1,length(sigma))-accuracy_2_2d;
% 
% 
% error_3 = ones(1,length(sigma))-accuracy_1;
% 
% 
% 
% 
% 
% figure;
% 
% semilogy(vnr_1,error_1,'LineWidth',2);
% hold on;
% semilogy(vnr_1,error_2,'LineWidth',2);
% 
% semilogy(vnr,error_3,'k','LineWidth',1.5);
% 
% semilogy(vnr_2,error_4,'LineWidth',2);
% semilogy(vnr_2,error_5,'LineWidth',2);
% 
% 
% grid on;
% 
% title('Performance Comparison of Network Structure');
% legend('D4-NLD1-case1','D4-NLD1-case2','D4-MLD');
% xlabel('VNR','fontsize',13);
% ylabel('Point Error Probability','fontsize',13);


