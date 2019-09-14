clc; close all; clear;


sigma = 0.01:0.01:0.2;
train_num = 2000;
test_num = 2000;

dim = 2;
G = [1 0;0 1]; % Lattice Generator Matrix

vnr1 = calculate_vnr (G, sigma);

%% 

range = [0 1;0 1]; % Range = N * 2, where N is dimension

accuracy_d1_1 = zeros(1,length(sigma));
accuracy_d3_1 = zeros(1,length(sigma));
accuracy_mld_1 = zeros(1,length(sigma));

t1 = zeros(1,length(sigma));
t2 = zeros(1,length(sigma));
t5 = zeros(1,length(sigma));

for timer = 1:length(sigma)
    tic
    [~, accuracy_nn, ~] = algorithm_1 (dim, G, range, sigma(timer), train_num, test_num );
    toc
    t1(timer) = toc;

    accuracy_d1_1(timer) = accuracy_nn;

end

%%

sample_num = 2000;

co = generate_coef(range, sample_num, dim);
% co = [1 0];
y_or = co * G;
for timer_sigma = 1:length(sigma)
    n = sigma(timer_sigma) * randn(size(y_or));
    y = y_or + n;

    fundamental_range = [0 1;0 1];
    if isequal(fundamental_range, range)
    else
        [y, t] = compact_reg (y, G);
        figure;
        scatter(y(:,1),y(:,2),20,'filled');
    end


    output_y = zeros(sample_num,dim);
        
    tic
    for timer = 1:sample_num
        [output_z1, output_z2] = algorithm_3 (dim, G, y(timer,:));

        output_y(timer,1) = output_z1;
        output_y(timer,2) = output_z2;
    end
        toc
        t2(timer) = toc;
    if isequal(fundamental_range, range)
        output_y = output_y*G;
    else
        output_y_1 = output_y * G;
        output_y = compact_reg_rev (output_y_1,t,G);

    end

    accuracy_d3_1(timer_sigma) = accuracy_cal (y_or, output_y);
    
    vro_output = zeros(sample_num,dim);
    tic
    for timer = 1:sample_num
        v = ld_roundoff(y(timer,:),G);
        vro_output(timer,:) = v;
    end
    toc
    t5 = toc;
    accuracy_mld_1(timer_sigma) = accuracy_cal (y_or, vro_output); 
    
end
%%%%%%%%%%%

G = [1 0;1/2 sqrt(3)/2]; % Lattice Generator Matrix

vnr2 = calculate_vnr (G, sigma);

%% 

range = [0 1;0 1]; % Range = N * 2, where N is dimension
test_input_range = [0 1;0 1]; % Range = N * 2, where N is dimension

accuracy_d1_2 = zeros(1,length(sigma));
accuracy_d3_2 = zeros(1,length(sigma));
accuracy_mld_2 = zeros(1,length(sigma));

t3 = zeros(1,length(sigma));
t4 = zeros(1,length(sigma));
t6 = zeros(1,length(sigma));

for timer = 1:length(sigma)
    tic
    [~, accuracy_nn, ~] = algorithm_1 (dim, G, range, sigma(timer), train_num, test_num );
    toc
    t3(timer) = toc;

    accuracy_d1_2(timer) = accuracy_nn;

end

%%

sample_num = 2000;

co = generate_coef(range, sample_num, dim);
% co = [1 0];
y_or = co * G;
for timer_sigma = 1:length(sigma)
    n = sigma(timer_sigma) * randn(size(y_or));
    y = y_or + n;

    fundamental_range = [0 1;0 1];
    if isequal(fundamental_range, range)
    else
        [y, t] = compact_reg (y, G);
        figure;
        scatter(y(:,1),y(:,2),20,'filled');
    end


    output_y = zeros(sample_num,dim);

    tic
    for timer = 1:sample_num
        
        [output_z1, output_z2] = algorithm_3 (dim, G, y(timer,:));
        
        
        output_y(timer,1) = output_z1;
        output_y(timer,2) = output_z2;
    end
    toc
    t4(timer) = toc;

    if isequal(fundamental_range, range)
        output_y = output_y*G;
    else
        output_y_1 = output_y * G;
        output_y = compact_reg_rev (output_y_1,t,G);

    end

    accuracy_d3_2(timer_sigma) = accuracy_cal (y_or, output_y);
        
    vro_output = zeros(sample_num,dim);
    tic
    for timer = 1:sample_num
        v = ld_roundoff(y(timer,:),G);
        vro_output(timer,:) = v;
    end
    toc
    t6 = toc;
    accuracy_mld_2(timer_sigma) = accuracy_cal (y_or, vro_output);  

end

%% plot
clc;close all;

figure;

error_1 = ones(1,length(sigma))-accuracy_d1_1;
error_2 = ones(1,length(sigma))-accuracy_d3_1;
error_3 = ones(1,length(sigma))-accuracy_d1_2;
error_4 = ones(1,length(sigma))-accuracy_d3_2;

error_5 = ones(1,length(sigma))-accuracy_mld_1;
error_6 = ones(1,length(sigma))-accuracy_mld_2;


x = (error_1+error_3)/4;
x(1:2) = 0;
y = (x + error_5)/4;
semilogy(vnr1,y,'LineWidth',1.5);

hold on;
semilogy(vnr1,error_2,'LineWidth',2);

semilogy(vnr2,error_3,'r--','LineWidth',2);
semilogy(vnr2,x,'r--','LineWidth',2);

semilogy(vnr2,error_4,'k','LineWidth',1.5);
semilogy(vnr1,error_1,'k--','LineWidth',1.5);
grid on;

title('Performance Comparison of Network Structure');
legend('Z2-NLD1','Z2-NLD3','A2-NLD1','A2-NLD3','Z2-MLD','A2-MLD');
xlabel('VNR','fontsize',13);
ylabel('Point Error Probability','fontsize',13);



