function [ ids, means, ssd ] = restarts(A, K, iters, R)

% run my_kmeans calculation R times with different initial random centers
i=1;
clusters = cell(R,3); 
while i<=R
    [ ids, means, ssd ] = my_kmeans(A, K, iters);
    
    % Store clusters from each restart 
    clusters{i,1} = ids;
    clusters{i,2} = means;
    clusters{i,3} = ssd;
    i = i+1;
end

% Return the cluster with the smallest ssd value
[min_ssd, ind] = min([clusters{:,3}]);
ids = clusters{ind,1};
means = clusters{ind,2};
ssd = clusters{ind,3};
end