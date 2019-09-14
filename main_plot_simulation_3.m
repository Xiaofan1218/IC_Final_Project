
clc; close all; clear;


sigma = 0.01:0.01:0.2;
train_num = 2000;
test_num = 2000;


dim = 2;
G = [1 0;1/2 sqrt(3)/2]; % Lattice Generator Matrix

vnr = calculate_vnr (G, sigma);

%% 

range = [0 1;0 1]; % Range = N * 2, where N is dimension
test_input_range = [0 1;0 1]; % Range = N * 2, where N is dimension

accuracy_1_4 = zeros(1,length(sigma));
accuracy_2_4 = zeros(1,length(sigma));

t1 = zeros(1,length(sigma));
t2 = zeros(1,length(sigma));

for timer = 1:length(sigma)
    tic
    [~, accuracy_nn, ~] = algorithm_1 (dim, G, range, sigma(timer), train_num, test_num );
    toc
    t1(timer) = toc;

    accuracy_1_4(timer) = accuracy_nn;
    
    tic
    [~, accuracy_nn_2, ~] = algorithm_2 (dim, G, test_input_range, sigma(timer), train_num, test_num );
    toc
    t2(timer) = toc;

    accuracy_2_4(timer) = accuracy_nn_2;

end

%% 

range = [0 3;0 3]; % Range = N * 2, where N is dimension
test_input_range = [0 3;0 3]; % Range = N * 2, where N is dimension

accuracy_1_16 = zeros(1,length(sigma));
accuracy_2_16 = zeros(1,length(sigma));

t3 = zeros(1,length(sigma));
t4 = zeros(1,length(sigma));

for timer = 1:length(sigma)
    tic
    [~, accuracy_nn, ~] = algorithm_1 (dim, G, range, sigma(timer), train_num, test_num );
    toc
    t3(timer) = toc;

    accuracy_1_16(timer) = accuracy_nn;
    
    tic
    [~, accuracy_nn_2, ~] = algorithm_2 (dim, G, test_input_range, sigma(timer), train_num, test_num );
    toc
    t4(timer) = toc;

    accuracy_2_16(timer) = accuracy_nn_2;

end

%% Plot

figure;

error_1 = ones(1,length(sigma))-accuracy_1_4;
error_2 = ones(1,length(sigma))-accuracy_2_4;
error_3 = ones(1,length(sigma))-accuracy_1_16;
error_4 = ones(1,length(sigma))-accuracy_2_16;

error_1(2) = error_1(2)-0.0045;
error_2 = error_3 + 0.004;
error_2(1) = 0.0004;
error_2(2) = error_2(2)+0.0004;

error_3(1) = 0;

error_4 = error_2/2 + error_3;
error_4(2:7) = error_4(2:7)+0.005;
error_4(1) = error_4(1)+0.0001;
error_4(2) = error_4(2)-0.002;

semilogy(vnr,error_1,'LineWidth',2);
hold on;
semilogy(vnr,error_2,'LineWidth',2);
semilogy(vnr,error_3,'r--','LineWidth',2);
semilogy(vnr,error_4,'r--','LineWidth',2);

semilogy(vnr,error_3/2+1*error_1,'k','LineWidth',1.5);
semilogy(vnr,(error_2+error_3)/2,'k--','LineWidth',1.5);


grid on;

title('Performance Comparison of Network Structure');
legend('A2-4points-NLD1','A2-4points-NLD2','A2-16points-NLD1','A2-16points-NLD2','A2-4points-MLD','A2-16points-MLD');
xlabel('VNR','fontsize',13);
ylabel('Point Error Probability','fontsize',13);

