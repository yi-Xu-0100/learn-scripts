clc;
clear;
sample = fix(rand(10, 3) * 50);
%% Built-in function to calculate matrix covariance and then to calculate Mahalanobis distance and Euclidean distance
scov = cov(sample);
[m, n] = size(sample);
D = zeros(m, n);
K = D;

for i = 1:m

    for j = 1:m
        % Calculate Mahalanobis distance
        D(i, j) = ((sample(i, :) - sample(j, :)) * (scov \ (sample(i, :) - sample(j, :))'))^0.5;
        % Calculate Euclidean distance
        K(i, j) = norm(sample(i, :) - sample(j, :));
    end

end

%% Use sparse matrix storage for Mahalanobis distance and Euclidean distance matrix
D = sparse(D);
K = sparse(K);
% Calculate the sparse matrix of Mahalanobis distance and Euclidean distance directly
Y = pdist(sample, 'mahal');
Y = sparse(squareform(Y));
L = pdist(sample);
L = sparse(squareform(L));
% Validation results
tol = 0.0000001;
max(abs(Y(:) - D(:))) < tol
max(abs(K(:) - L(:))) < tol
