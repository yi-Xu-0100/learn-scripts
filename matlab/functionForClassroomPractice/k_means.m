function [data, center] = k_means(sample, k)
    sample = fix(rand(10, 3) * 50);
    k = 5;
    % count=1;
    % sample represents the input sample matrix, k represents the expected number of clusters
    % data(i) represents the cluster label to which the i-th sample belongs
    %% center represents the location of the cluster center
    [m, n] = size(sample);

    if k > m
        disp('The number of clusters you need is greater than the number of data, it cannot be clustered!');
        return;
    end

    %% Select initial centroid
    for i = 1:k
        % The method of selecting the initial centroid is: starting from the first data
        % selecting a data point every m/k interval until k category centers are obtained
        c(i, :) = sample(1 + (i - 1) * fix(m / k), :);
    end

    while true
        % Calculate the distance between each data point and the center of the category
        % put the data point into the category closest to it
        for i = 1:m
            % dis saves the distance from each data point to the center of k categories
            for j = 1:k
                dis(j) = sqrt(sum((c(j, :) - sample(i, :)).^2));
            end

            % Find the data point with the smallest distance from the center of k categories
            % the data point is classified into this category
            [~, index] = sort(dis);
            data(i) = index(1);
        end

        % Recalculate the center, taking the average of the divided classes as the center point
        for i = 1:k
            center(i, :) = mean([sample(find(data == i), :); zeros(1, n)]);
        end

        % If the Euclidean distance in the center is small, exit
        if norm(center - c) <= 0.0001%||count==100
            break
        else
            c = center;
        end

        %count=count+1;
    end

end
