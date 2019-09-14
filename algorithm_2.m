
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% This function is algorithm 2 based on NN.
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Inputs
% dim = dimension of the system
% G = Lattice generator matrix. Dimension of G is dim*dim.
% test_input_range = Arbitrary constellation of transmitter
% sigma = Standard variance of AWGN
% train_num = The number of training samples
% test_num = The number of testing samples
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Outputs
% snr_test = Signal to noise ratio of testing lattice signal
% accuracy_nn = Accuracy of reconstuction based on NN algorithm 2
% accuracy_nor = Accuracy of reconstuction based on finding the closest
% lattice point in Euclidean space
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

function [snr_test, accuracy_nn, accuracy_nor] = algorithm_2 (dim, G, test_input_range, sigma, train_num, test_num)

train_input_range = zeros(dim,2);
train_input_range(:,2) = 1;

%% Categories

range_1 = zeros(dim,1);
for timer = 1:dim
    range_1(timer) = abs(train_input_range(timer,end) - train_input_range(timer,1)) + 1;
end
category_num = prod(range_1);

%% Multi-dimention training set generation

coef_tr = zeros(train_num,dim);
for timer = 1:dim
    coef_tr(:,timer) = randi([train_input_range(timer,1) train_input_range(timer,end)],train_num,1);
end

% Checking if training set meets condition
uni = unique(coef_tr,'row');
while length(uni) < category_num
    for timer = 1:dim
        coef_tr(:,timer) = randi([train_input_range(timer,1) train_input_range(timer,end)],train_num,1);
    end
    uni = unique(coef_tr,'row');
end

[~,index] = ismember(coef_tr,uni,'rows');

f1 = coef_tr * G;

% Noisy signal generation
n1 = sqrt(sigma) * randn(size(f1));
f1_tr = f1 + n1;

% Normalisation
[input, minI, maxI] = premnmx(f1_tr');

%% Target output generation
s = length(f1);

output = zeros(s,category_num);

for  timer = 1:s
    output(timer,index(timer)) = 1;
end

%% Nerual Network Implemention

net = newff(input, output',100, {'tansig' 'purelin'}); % Best solution for 1-D problem; lr = 0.005
% net = newff(input, output', [20 20],{'tansig','tansig','purelin'});

% Parameters
net.trainparam.goal = 1e-5;
net.trainparam.epochs = 1000;
net.trainparam.lr = 0.005;
net.trainparam.show = 5;
net.trainparam.max_fail = 10;

% Training
net = train(net, input, output');

%% Multi-dimention testing set generation

coef_test = zeros(test_num,dim);
for timer = 1:dim
    coef_test(:,timer) = randi([test_input_range(timer,1) test_input_range(timer,end)],test_num,1);
end

t1 = coef_test * G;

n2 = sqrt(sigma) * randn(size(t1));
t1_n2 = t1 + n2;

[t1_test, round_num] = compact_reg(t1_n2,G);

testinput = tramnmx(t1_test', minI, maxI);

% Simulation
Y = sim(net, testinput);

%% Mapped points reconstruction
[~, s2] = size(Y);
sim_point = zeros(dim,s2);
for timer = 1:s2
    [~,big_pro] = max(Y(:,timer));
    
    sim_point(:,timer) = uni(big_pro,:);

end

recon_po = compact_reg_rev(sim_point',round_num,G);
%% Accuracy Comparation

t1_nor = round(t1_n2);

accuracy_nn = accuracy_cal(t1,recon_po);
accuracy_nor = accuracy_cal(t1,t1_nor);

ber_nn = 1 - accuracy_nn;
ber_nor = 1 - accuracy_nor;

snr_test = snr(t1_n2,t1);

end