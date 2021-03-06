function rmse_res = rmse(data, U, S, V, numK)

    indices = data(:, 1:3);
    vals = data(:,4);

    
    error_vals = zeros(numK,1);
    base = zeros(numK, 1);


    for k=1:numK
        k_indices = data{k}(:, 1:3);
        k_vals = data{k}(:,4);

        recon = U{k} * S{k} *V';
        idx = sub2ind(size(recon), k_indices(:,2), k_indices(:,3));
        recon_vals = recon(idx);

        diff = k_vals - recon_vals;
        diff = sum(diff .*diff);

        base(k) = sum(k_vals .* k_vals);
        error_vals(k) = diff;

    end


    rmse_res = sum(error_vals) / sum(base) ;

end
