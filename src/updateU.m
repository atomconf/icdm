function U_update = updateU(X, missing_ind_mat, U_old, Q, H, V, W, mu, smooth_reg, iter)
    

    K = size(W,1);
    R = size(H, 2);
    J = size(V,1);

    parfor k=1:K
        Ik = size(X{k}, 1);
        Vspecific = zeros(Ik, R, R);
        smoothness = zeros(Ik, R);
        Uk = mu*Q{k}*H +  X{k} * V * diag(W(k,:));
        for i=1:size(X{k}, 1)
            if i == 1
                Uk(1,:) = Uk(1,:) + smooth_reg * U_old{k}(2,:); 
            elseif i == size(X{k}, 1);
                Uk(i,:) = Uk(i,:) + smooth_reg * U_old{k}(i-1,:);
            else
                Uk(i,:) = Uk(i,:) +  smooth_reg * (U_old{k}(i-1,:) + U_old{k}(i+1,:));
            end
        end
        for i=1:size(X{k}, 1)
            nonzero_ind = find(missing_ind_mat{k}(i,:) == 0);
           if (i == 1) || (i==size(X{k}, 1))
               Vspecific(i, :, :) = inv((mu+smooth_reg)*eye(R) + diag(W(k,:)) * (V(nonzero_ind,:)' * V(nonzero_ind,:)) * diag(W(k,:))); 
           else
               Vspecific(i, :, :) = inv((mu+2*smooth_reg)*eye(R) + diag(W(k,:)) * (V(nonzero_ind,:)' * V(nonzero_ind,:)) * diag(W(k,:))); 
           end
            Uk(i, :) = Uk(i,:)*squeeze(Vspecific(i,:,:)); 
        end
        U_update{k} = Uk;



    end

end

