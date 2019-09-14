
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% This function is to update all the weights in perceptron
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Inputs
% y1 = Coordinate x value of noisy lattice point.
% y2 = Coordinate y value of noisy lattice point.
% stone = 0 or 1, to disjust which side of desicion boundary the target lattice point is
% layers = A new pereptron with three layers
% gards = All gradients of decision boundaries. (in cell form)
% gards_all = All gradients of decision boundaries. (in matrix form)
% points_all = The center point of two lattice points. (in matrix form)
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Outputs
% layers = Updated perceptron that is ready to classify test samples
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

function [layers] = update_layers(y1, y2, stone, layers, grads, grads_all, points_all)

%% Update coefficients in the 1st layer 
for timer = 1:length(grads_all)
    
    if grads_all(timer) == -inf
        layer_values = y1 - points_all(timer,1);
        if layer_values > 0
            layers{1}(timer) = 1;
        else
            layers{1}(timer) = 0;
        end
        
    else
        fake_c = points_all(timer,2) - (grads_all(timer) * points_all(timer,1));
        if fake_c < 1e-5
            fake_c = 0;
        end
        
        fake_y = grads_all(timer) * y1 + fake_c;
        
        if stone == 0
            if fake_y >= y2
                layers{1}(timer) = 1;
            else
                layers{1}(timer) = 0;
            end       
        else % stone = 1;
            if fake_y > y2
                layers{1}(timer) = 0;
            else
                layers{1}(timer) = 1;
            end  
        end
        
    end
    
end

%% Update coefficients in the 2nd layer (AND)

flag = 0;
for timer = 1:length(grads)
    if length(grads{timer}) > 1
        layer_values_2 = layers{1}(timer) + layers{1}(timer + 1);
        
        flag = timer;
        
        if layer_values_2 < 2
            layers{2} = 0;
        else
            layers{2} = 1;
        end
    end
end

%% Update coefficients in the 3rd layer (OR)

if flag == 0
    layer_values_3 = sum(layers{1});

elseif flag == 1
    layer_values_3 = layers{2} + layers{1}(end);

else
    layer_values_3 = layers{2} + layers{1}(1);
end


if layer_values_3 < 1
    layers{3} = 0;
else
    layers{3} = 1;
end

end