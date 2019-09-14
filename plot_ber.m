
clc; close all; clear;

%% Parameter Setting
sigma = 0.05;
train_num = 2000;
test_num = 2000;

dim = 2;
G = [1 0;1/2 sqrt(3)/2]; % Lattice Generator Matrix

%% Algorithm 1

range = [0 1;0 1]; % Range = N * 2, where N is dimension

compare_ber = zeros(3,length(sigma));
time_1 = zeros(1,length(sigma));
for timer = 1:length(sigma)
    t1 = clock;
    [snr_test, accuracy_nn, accuracy_nor] = algorithm_1 (dim, G, range, sigma(timer), train_num, test_num );
    t2 = clock;
    time_1(timer) = etime(t2,t1);

%     compare_ber(1,timer) = snr_test;

    compare_ber(2,timer) = accuracy_nn;
    compare_ber(3,timer) = accuracy_nor;

end
compare_ber(1,:) = sigma;

%% Algorithm 2

test_input_range = [0 1;0 1;0 1;0 1]; % Range = N * 2, where N is dimension

compare_ber_2 = zeros(3,length(sigma));
time_2 = zeros(1,length(sigma));
for timer = 1:length(sigma)
    t1 = clock;
    [snr_test_2, accuracy_nn_2, accuracy_nor_2] = algorithm_2 (dim, G, test_input_range, sigma(timer), train_num, test_num );
    t2 = clock;
    time_2(timer) = etime(t2,t1);

%     compare_ber_2(1,timer) = snr_test_2;

    compare_ber_2(2,timer) = accuracy_nn_2;
    compare_ber_2(3,timer) = accuracy_nor_2;
end
compare_ber_2(1,:) = sigma;

%% Plots

hold;
yyaxis left
semilogy(compare_ber(1,:),compare_ber(2,:),'r-','lineWidth',1.5); 
semilogy(compare_ber_2(1,:),compare_ber_2(2,:),'b-','lineWidth',1.5);

c = polyfit(compare_ber_2(1,:),compare_ber_2(3,:),2);
d = polyval(c,compare_ber_2(1,:));
semilogy(compare_ber_2(1,:),d,'k-','lineWidth',1.5);
ylabel('Accuracy');

yyaxis right
% plot(compare_ber(1,:),time_1,'g--');
% plot(compare_ber_2(1,:),time_2,'y--');
ylabel('Computational time');

hold off; grid on;
xlabel('SNR');
legend('Algorithm 1','Algorithm 2','Expected','time_1','time_2');
title('Accuracy VS SNR under two algorithms');


% values = spcrv([[compare_ber_2(1,1) compare_ber_2(1,:) compare_ber_2(1,end)];[compare_ber_2(3,1) compare_ber_2(3,:) compare_ber_2(3,end)]],3);
% plot(values(1,:),values(2,:),'r');
