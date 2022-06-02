delete(gcp('nocreate'))
numW = 20;
N = maxNumCompThreads(numW);
p = parpool('threads');

mat_size = [100, 100, 300];

I = mat_size(1);
J = mat_size(2);
K = mat_size(3);

X = cell(1, K);
X_test = cell(1,K);
missing_ind = cell(1,K);

fprintf('Generating dense tensor... ');

X1 = tenrand(I,J,K);

for k=1:K
	X{k} = double(X1(:,:,k));
end


parfor k=1:K
    nelements = numel(X{k});
    SampleSize = round(nelements/10);
    randices = randsample(1:nelements,SampleSize,false);
    X_tmp = zeros(size(X{k}));
    X_tmp(randices) = X{k}(randices); 
    X_tmp = sparse(X_tmp);
    X{k}(randices) = 0;
    [x,y,v] = find(X_tmp);
    X_test{k} = [k*ones(size(x)), x, y, v];
    missing_ind{k} = [k*ones(size(x)), x, y];
end


fprintf('Done!\n\n');


R = 10;
maxiter = 32;


K = length(X);


mu = 0.01
lambda_reg = 0.1
smooth_reg = 0.1

conv = 0.005
conv_tol = 0.005;
[U, S, V, fit] = atom(X, missing_ind, R, maxiter, conv, mu, lambda_reg, smooth_reg); 
fit = fit(fit~=0);

rmse_atom = rmse(X_test, U, S, V, K);

 
fprintf('Fitness is  %4f\n', fit(end));
fprintf('Fitness is  %4f\n', rmse_atom);



