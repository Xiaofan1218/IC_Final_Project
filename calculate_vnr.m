
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% This function is to calculate volume to noise ratio(VNR)
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Inputs
% G = Lattice generator matrix
% sigma = Stardand variances of AWGN
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Outputs
% vnr = Corresponding VNRs
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

function vnr = calculate_vnr (G, sigma)

n = length(G);
l_s = length(sigma);

vnr = zeros(1,l_s);

det_G = abs(det(G));
up = det_G ^ (2/n);

for timer = 1:l_s
    
    down = sigma(timer) ^ 2;
    vnr(timer) = up/down;

end

