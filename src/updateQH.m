function [Q_update, H_update] = updateQH(Q, H, U)

    K = length(U);
    R = size(H, 1);
    Q_update = cell(K, 1);
    H_tmp = zeros(K, R, R);
    H_update = zeros(R,R);

    parfor k=1:K
        [Z, ~, P] = svd(U{k} * H', 'econ');
        Q_update{k} = Z * P';

        H_update = H_update +  Q_update{k}' * U{k};
    end

    H_update = H_update ./ K;

end

