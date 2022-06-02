function W_update = updateW_sparse(X, train_ind_mat, U, V, reg, iter)
    K = length(X);
    J = size(V, 1);
    R = size(V, 2);
    

    parfor k=1:K
        Ik = size(U{k}, 1);
        [nnz_ind_row, nnz_ind_col] = find(train_ind_mat{k} ~=0);

        inv_mat2 = (V(nnz_ind_col,:) .* U{k}(nnz_ind_row,:));
        inv_mat = inv(reg*eye(R,R) + inv_mat2' * inv_mat2); 
        vecVU = zeros(1,R);
        for r =1:R
            vecVU(1,r) = U{k}(:,r)' * X{k} * V(:,r);
        end
        W_update(k,:) = vecVU * inv_mat;
    end

end

