
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% This function is to find Boolean equation of a coordinate z1 or z2
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Inputs
% z_pos = coordinate z. For 2D space, z_pos = 1 or 2.
% coef = Coefficients of corners of a fundamental parallelope
% x = Corners of a fundamental parallelope
% rho = Packing radius
% stone = Initialised 0 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Outputs
% stone = 0 or 1, to disjust which side of desicion boundary the target lattice point is
% gards = All gradients of decision boundaries. (in cell form)
% gards_all = All gradients of decision boundaries. (in matrix form)
% points = The center point of two lattice points. (in cell form)
% points_all = The center point of two lattice points. (in matrix form)
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

function [stone, grads, grads_all, points, points_all] = find_boolean_eq (z_pos, coef, x, rho, stone)
%% Find Boolean equation for z2

% z2 = 1 (the 1st element in coef)
% coef = (z1,z2). Select the half of corners where z2 = 1
inx_1 = find(coef(:,z_pos));

dis_compare = zeros(2,1);
grads = cell(2,1);
points = cell(2,1);

grads_all = [];
points_all = [];

% timer2 loop is for two points that z1 = 1
for timer2 = 1:length(inx_1)
    
    % timer loop is for comparing target point with other three points
    for timer = 1:length(coef)
    
        dis_compare(timer2) = norm(x(inx_1(timer2),:) - x(timer,:));
        
        % two conditions for disjusting if there exists decision boundary
        if ((dis_compare(timer2) < 2.1*rho) && (coef(inx_1(timer2),z_pos) ~= coef(timer,z_pos)))
            
            % Calculate gradient of decision boundary
            edge_grad = (x(inx_1(timer2),2) - x(timer,2))/(x(inx_1(timer2),1) - x(timer,1));
            grad = -1/edge_grad;
            
            % Calculate the point on decision boundary
            point = [0.5*(x(inx_1(timer2),1) + x(timer,1)),0.5*(x(inx_1(timer2),2) + x(timer,2))];
            
            grads{timer2} = [grads{timer2};grad];
            grads_all = [grads_all;grad];
            points{timer2} = [points{timer2};point];
            points_all = [points_all;point];
            
            % Check if the Boolean complement is used.
            if grad ~= -inf
                if point(2) < x(inx_1(timer2),2)
                    stone = 1;
                end
            end
          
        end
    
    end
    
end

end
