delete(gcp('nocreate'))
numW = 20;
N = maxNumCompThreads(numW);
p = parpool('threads');

load(sprintf('./data/ml-100k/movie_train.mat'), 'data');
N = maxNumCompThreads(numW);
delete(gcp('nocreate'));
parpool('threads');

X = data;

load(sprintf('./data/ml-100k/movie_test.mat'), 'data');
X_test = data;
for k=1:length(X_test)
cast(X_test{k}(:,1:3), 'int32');
X_test{k}(:,1:3) = X_test{k}(:,1:3) + 1;
end

fprintf('Done!\n\n');


R = 10;
maxiter = 32;

K = length(X);


mu = 0.01
lambda_reg = 1
smooth_reg = 0.1

conv = 0.005
conv_tol = 0.005;
[U, S, V, fit] = atom_sparse(X, R, maxiter, conv, mu, lambda_reg, smooth_reg); 
fit = fit(fit~=0);

rmse_atom = rmse(X_test, U, S, V, K);

 
fprintf('Fitness is  %4f\n', fit(end));
fprintf('Fitness is  %4f\n', rmse_atom);



