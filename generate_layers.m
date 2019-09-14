
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% This function is to generate a pereptron with three layers
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Inputs
% gards = All gradients of decision boundaries. (in cell form) 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Outputs
% layers = A new pereptron with three layers
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 


function [layers] = generate_layers (grads)

%% Construct the pereptron with three layers

con1 = length(grads{1});
con2 = length(grads{2});

% The 1st layer is to get the relative position under Boolean equation
% The number of neurons in 1st layer is the number of all decision boundaries
layer1_num = con1 + con2;
layer1 = zeros(layer1_num,1);

% The 2nd layer is to implement the logical AND
% The number of neurons in 2nd layer is the number of decision boundaries
% found at the same corner
layer2_num = (con1 - 1) + (con2 - 1);
layer2 = zeros(layer2_num,1);

% The 3rd layer is to implement the logical OR
% The number of neurons in 3rd layer is the number of half terms coming
% from all selected corners (2^(n-1))
layer3_num = length(grads) - 1;
layer3 = zeros(layer3_num,1);

layers = {layer1;layer2;layer3};

end