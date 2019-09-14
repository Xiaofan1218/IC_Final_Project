clc; close all; clear;

%% Parameter Setting
sigma = 0.2;
train_num = 2000;
test_num = 2000;

dim = 3;
G = [2 0 0;0 2 0;0 0 2]; % Lattice Generator Matrix

lr = 100:100:1000;
results = zeros(1,length(lr));
results2 = zeros(1,length(lr));

%% Algorithm 1

range = [0 2;0 2;0 2]; % Range = N * 2, where N is dimension

compare_ber = zeros(3,length(sigma));
time_1 = zeros(1,length(sigma));
for timer = 1:length(sigma)
    for timer2 = 1:length(lr)
    t1 = clock;
    [snr_test, accuracy_nn, accuracy_nor] = algorithm_1 (dim, G, range, sigma(timer), train_num, test_num ,lr(timer2));
    t2 = clock;
    time_1(timer) = etime(t2,t1);

%     compare_ber(1,timer) = snr_test;

%     compare_ber(2,timer) = accuracy_nn;
%     compare_ber(3,timer) = accuracy_nor;
results (timer2) = time_1;
results2(timer2) = accuracy_nn;
    end
end
% compare_ber(1,:) = sigma;

