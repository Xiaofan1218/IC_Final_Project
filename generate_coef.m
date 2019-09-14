
function coef_tr = generate_coef(range, sample_num, dim)

coef_tr = zeros(sample_num,dim);
for timer = 1:dim
    coef_tr(:,timer) = randi([range(timer,1) range(timer,end)],sample_num,1);
end

end


