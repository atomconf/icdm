delete(gcp('nocreate'))
numW = 20;
N = maxNumCompThreads(numW);
p = parpool('threads');


load(sprintf('./data/stock/jpn_stock_train.mat'), 'data');

X = data;

load(sprintf('./data/stock/jpn_stock_test.mat'), 'data');
X_test = data;
for k=1:length(X_test)
cast(X_test{k}(:,1:3), 'int32');
X_test{k}(:,1:3) = X_test{k}(:,1:3) + 1;
end

fprintf('Done!\n\n');


R = 10;
maxiter = 32;


K = length(X);

missing_ind = cell(1,K);
parfor k=1:K
    missing_ind{k} = X_test{k}(:, 1:3);  
end

mu = 0.01
lambda_reg = 0
smooth_reg = 10

conv = 0.005
conv_tol = 0.005;
[U, S, V, fit] = atom(X, missing_ind, R, maxiter, conv, mu, lambda_reg, smooth_reg); 
fit = fit(fit~=0);

rmse_atom = rmse(X_test, U, S, V, K);

 
fprintf('Fitness is  %4f\n', fit(end));
fprintf('Fitness is  %4f\n', rmse_atom);



