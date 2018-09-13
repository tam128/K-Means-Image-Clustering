function [ ids, means, ssd ] = my_kmeans(A, K, iters)
    N = size(A,1); % Number of rows (sample size)
    D = size(A,2); % Number of columns (dimensionality of features)
    
    min_d = min(A,[],1); 
    max_d = max(A,[],1);
        
    centers = min_d + (max_d-min_d).*rand(K,1); % Generate random centers from sample range
    
    iter_count = 1;
    while iter_count <= iters
        dist = pdist2(A, centers); 

        [min_dist, ids] = min(dist,[],2); % Find the closest center (center with min distance) for each sample

        [counts, val] = hist(ids,unique(ids)); % Count of points in each cluster and the cluster center that the points belong to


        % Get the total sum of the sample values in each cluster
        means = zeros(K,D);
        for num_A = 1:N
            means(ids(num_A,1),:) =  means(ids(num_A,1),:) + A(num_A, :);
        end

        % Divide sum by the number of samples in the cluster to get the new
        % centers
        for i = 1:size(val,1)
            means(val(i,1), :) = means(val(i,1), :) ./ counts(1,i);
        end

        centers = means;
        
        %% Compute SSD

        for num_A = 1:N
            diff(num_A,1) = pdist2(A(num_A,:), means(ids(num_A,1),:));      
        end

        ssd = sum(diff.^2);
        
        iter_count = iter_count+1;
    end
end