
function v = ld_nearestplane(G,c)

dim = length(G);

arr = flipud(1:dim);

c = c;
v = 0;

% G_GSO = gram_schmidt (G);
% G_GSO = G;
G_GSO = gram_schmidt_fun (G');
G_GSO = G_GSO';

for timer = 1:dim
    
    flag = arr(timer);

    d = (dot(c,G_GSO(flag,:)))/(norm(G_GSO(flag,:)));
    z = round(d);
    c = c - z * G(flag,:);
    v = v + z * G(flag,:);
end



end


