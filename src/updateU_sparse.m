function U_update = updateU_sparse(X, train_ind_mat, U_old, Q, H, V, W, mu, smooth_reg, iter)
    

    K = size(W,1);
    R = size(H, 2);
    J = size(V,1);
    

    parfor k=1:K
        Ik = size(X{k}, 1);
        Vspecific = zeros(Ik, R, R);
        tmpU = mu*Q{k}*H +  X{k} * V * diag(W(k,:));
        Uk = zeros(size(tmpU));
        for i=1:size(X{k}, 1)
            nonzero_ind = find(train_ind_mat{k}(i,:) ~= 0);
            if i == 1
                Uk(i,:) = (tmpU(i,:) + smooth_reg * U_old{k}(i+1,:))*inv((mu+smooth_reg)*eye(R) + diag(W(k,:)) * (V(nonzero_ind,:)' * V(nonzero_ind,:)) * diag(W(k,:))); 
            elseif i == size(X{k}, 1);
                Uk(i,:) = (tmpU(i,:) + smooth_reg * U_old{k}(i-1,:))*inv((mu+smooth_reg)*eye(R) + diag(W(k,:)) * (V(nonzero_ind,:)' * V(nonzero_ind,:)) * diag(W(k,:)));
            else
                Uk(i,:) = (tmpU(i,:) +  smooth_reg * (U_old{k}(i-1,:) + U_old{k}(i+1,:)))*inv((mu+2*smooth_reg)*eye(R) + diag(W(k,:)) * (V(nonzero_ind,:)' * V(nonzero_ind,:)) * diag(W(k,:)));
            end
        end
        U_update{k} = Uk;

    end

end

