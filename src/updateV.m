function V_update = updateV(X, missing_ind_mat,  U, W, reg,  iter)
    K = size(W,1);
    R = size(W, 2);
    J = size(X{1}, 2);

    V_store = zeros(J, R, R);

    V_update = zeros(J,R);




    XUS = zeros(J, R);
    parfor k=1:K
        XUS = XUS +  (X{k}' * U{k} * diag(W(k,:)));
    end


    for j=1:J
        utmp = zeros(K, R, R);
        parfor k=1:K
            Ik = size(U{k}, 1);

            nonzero_ind = find(missing_ind_mat{k}(:,j) == 0);
            utmp(k,:,:)  = (diag(W(k,:)) * (U{k}(nonzero_ind,:)' * U{k}(nonzero_ind,:)) * diag(W(k,:))); 
        end
        V_update(j,:) =  XUS(j,:) * inv(reg * eye(R,R) + squeeze(sum(utmp, 1)));
    end



end

