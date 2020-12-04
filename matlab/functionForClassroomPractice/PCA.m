function [DS, PV, result_report] = PCA(A, T)
    % A is the input data, T is the expected retention rate
    % DS is the characteristic value and its contribution rate, cumulative contribution rate
    % The column vector of PV is the extracted principal component component
    % The first 3 columns of result_report are the scores of each principal component
    % the fifth column is the sample number, sorted by the total score of the fourth column in descending order
    %% Data standardization
    [m, n] = size(A);

    for i = 1:n
        SA(:, i) = (A(:, i) - mean(A(:, i))) / std(A(:, i));
    end

    % Calculate the eigenvalues and eigenvectors of the correlation coefficient matrix
    CM = cov(SA); % Calculate the correlation coefficient matrix
    [V, D] = eig(CM); % Find the eigenvector V and eigenvalue D of the covariance matrix

    for j = 1:n
        DS(j, 1) = D(n + 1 - j, n + 1 - j); % Sort eigenvalues in descending order
    end

    for i = 1:n
        DS(i, 2) = DS(i, 1) / sum(DS(:, 1)); % Contribution rate
        DS(i, 3) = sum(DS(1:i, 1)) / sum(DS(:, 1)); % Cumulative contribution rate
    end

    %% Select the principal component and the corresponding feature vector
    for K = 1:n

        if DS(K, 3) >= T
            Com_num = K;
            break
        end

    end

    %% Extract the feature vector corresponding to the principal component
    for j = 1:Com_num
        PV(:, j) = V(:, n + 1 - j);
    end

    %% Calculate the score of the principal component of the evaluation object
    new_score = SA * PV;

    for i = 1:m
        total_score(i, 1) = sum(new_score(i, :));
        total_score(i, 2) = i;
    end

    result_report = [new_score, total_score]; % Put the score of each principal component and the total score in the same matrix
    result_report = sortrows(result_report, -4); % Sort the total score in descending order
end
