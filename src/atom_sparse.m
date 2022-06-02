function [U, S, V, fit_each] = atom_sparse(X, R, maxiter, conv, mu, lambda_reg, smooth_reg)



    ConvCrit = conv;
    flag = 0;
    fit_each = zeros(maxiter, 1);
    it_time = zeros(maxiter, 1);

    J = size(X{1}, 2);
    K = length(X);
    
    U = cell(K,1);
    H = rand(R,R);
    V = rand(J,R);
    W = rand(K,R);
    lambda = zeros(R,1);
    S = cell(K, 1);
    Q = cell(K, 1);


    fit = 0;
    oldfit = fit*2;
    fit0   = fit;
    it     = 0;

    parfor i = 1:K
       S{i} = diag(rand(R,1)); 
       Q{i} = randn(size(X{i}, 1), R);
       U{i} = randn(size(X{i}, 1), R);
    end

    train_ind_mat = cell(K,1);
    parfor k=1:K
        Ik = size(X{k}, 1);
        J = size(X{k}, 2);
        train_ind_mat{k} = sparse(X{k});
    end

    normX = 0;
    for k=1:length(X)
        normX = normX + norm(X{k}(find(train_ind_mat{k} ~= 0)))^2;
    end

    
    oldfit1 = 0;
    oldfit2 = 0;
    
    mu = mu;
    reg = lambda_reg;
    smooth_reg  = smooth_reg;
    for it = 1:maxiter
        oldfit = fit;

        fprintf('start iteration\n')
        U = updateU_sparse(X, train_ind_mat,  U, Q, H, V, W, mu, smooth_reg,  it);
        fprintf('updateUdone\n')
        W = updateW_sparse(X, train_ind_mat, U, V, reg, it);
        fprintf('updateWdone\n')
        V = updateV_sparse(X, train_ind_mat, U,W, reg, it);
        fprintf('updateVdone\n')

        [Q, H] = updateQH(Q, H, U);
        fprintf('updateQHdone\n')

        fit = 0;
        parfor k=1:K
            diff = X{k} - U{k} * diag(W(k,:)) * V';
            diff = diff(find(train_ind_mat{k} ~= 0));
            fit = fit + norm(diff)^2;
        end
         fit_each(it) = fit/normX;

		if ((it > 1) &&  (abs(fit-oldfit)<oldfit*ConvCrit))
            flag = 1;
        else
            flag = 0;
        end

        fprintf(' Iter %2d: fitchange = %7.1e\n', it, oldfit-fit);
        if flag == 1
            break
        end

    end

    for k=1:K
        S{k} = diag(W(k,:));
    end
    
end

