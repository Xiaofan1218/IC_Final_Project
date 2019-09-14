
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% This function is algorithm 1 based on NN.
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Inputs
% dim = dimension of the system
% G = Lattice generator matrix. Dimension of G is dim*dim.
% range = Arbitrary constellation of transmitter
% sigma = Standard variance of AWGN
% train_num = The number of training samples
% test_num = The number of testing samples
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Outputs
% snr_test = Signal to noise ratio of testing lattice signal
% accuracy_nn = Accuracy of reconstuction based on NN algorithm 1
% accuracy_nor = Accuracy of reconstuction based on finding the closest
% lattice point in Euclidean space
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

function [snr_test, accuracy_nn, accuracy_nor] = algorithm_1_2 (dim, G, range, sigma, train_num, test_num)

%% Categories

range_1 = zeros(dim,1);
for timer = 1:dim
    range_1(timer) = abs(range(timer,end) - range(timer,1)) + 1;
end
category_num = prod(range_1);

%% Multi-dimention training set generation

coef_tr = generate_coef(range, train_num, dim);

% Checking if training set meets condition
uni = unique(coef_tr,'row');
while length(uni) < category_num
    for timer = 1:dim
        coef_tr(:,timer) = randi([range(timer,1) range(timer,end)],train_num,1);
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

% net = newff(input, output',20, {'tansig' 'purelin'}); % Best solution for 1-D problem; lr = 0.005
net = newff(input, output', [20 50],{'tansig','tansig','purelin'});

% Parameters
net.trainparam.goal = 1e-5;
net.trainparam.epochs = 1000;
net.trainparam.lr = 0.05;
net.trainparam.show = 1;
net.trainparam.max_fail = 20;

% Training
net = train(net, input, output');

%% Multi-dimention testing set generation

% coef_test = zeros(test_num,dim);
% for timer = 1:dim
%     coef_test(:,timer) = randi([range(timer,1) range(timer,end)],test_num,1);
% end

coef_test = generate_coef(range, test_num, dim);


[~,index_2] = ismember(coef_test,uni,'rows');

t1 = coef_test * G;

n2 = sqrt(sigma) * randn(size(t1));
t1_test = t1 + n2;

testinput = tramnmx(t1_test', minI, maxI);

% Simulation
Y = sim(net, testinput);

%% Accuracy Calculation
[~, s2] = size(Y);
hitnum = 0;
for timer = 1:s2
    [~,big_pro] = max(Y(:,timer));

    if big_pro == index_2(timer)
        hitnum = hitnum + 1;
    end
end

% Accuracy Comparation
t1_nor = round(t1_test);

flag = 0;
for timer = 1:s2
    if t1_nor(timer) == t1(timer)
        flag = flag + 1;
    end
end

accuracy_nn = hitnum/s2;
accuracy_nor = flag/s2;

ber_nn = 1 - accuracy_nn;
ber_nor = 1 - accuracy_nor;

snr_test = snr(t1_test,n2);
end