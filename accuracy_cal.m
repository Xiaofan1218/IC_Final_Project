% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% This function is to calculate the accuracy of the reconstructed lattice
% point by finding the same pairs between reconstructed and original signal.
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Inputs
% v1 = Ideal lattice points
% v2 = Reconstructed lattice points
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Outputs
% accu = Accuracy of reconstructed signal
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

function accu = accuracy_cal (v1,v2)

flag = 0;
s = length(v1);
for timer = 1:s
    if v1(timer) == v2(timer)
        flag = flag + 1;
    end
end

accu = flag/s;

end


