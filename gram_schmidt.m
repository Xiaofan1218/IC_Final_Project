
function G_GSO = gram_schmidt (G)

dim = length(G);
% G_GSO = G;

for timer = 1:dim
    G_GSO(timer,:) = G(timer,:);

    for timer2 = 1:dim - 1
        Lij_up = dot(G(timer,:),G_GSO(timer2,:));
        Lij_down = norm(G_GSO(timer2,:));
        Lij = Lij_up/Lij_down;
        
         G_GSO(timer,:) =  G_GSO(timer,:) - Lij * G_GSO(timer2,:);
    end
end


end



