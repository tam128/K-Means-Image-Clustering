% Set K, iters, and R values
K = 3;
iters = 5;
R = 10;

% Read in images, convert from uint8 to double, and resize to be 100x100x3
panda = imresize(im2double(imread('panda.jpg')), [100 100]);
cardinal = imresize(im2double(imread('cardinal.jpg')), [100 100]);
pittsburgh = imresize(im2double(imread('pittsburgh.png')), [100 100]);


% Convert 3D matrix to 2D matrix to use pixels as rows and channels
% (features) as columns
panda = reshape(panda, 100*100, 3);
cardinal = reshape(cardinal, 100*100, 3);
pittsburgh = reshape(pittsburgh, 100*100, 3);


% Calculate the kmeans cluster for each pixel
tic;
[ids1, means1, ssd1] = restarts(panda, K, iters, R);
ssd1
toc

tic;
[ids2, means2, ssd2] = restarts(cardinal, K, iters, R);
ssd2
toc

tic;
[ids3, means3, ssd3] = restarts(pittsburgh, K, iters, R);
ssd3
toc

% Reassign the pixel values with the new means
img_clust1 = zeros(10000,3);
img_clust2 = zeros(10000,3);
img_clust3 = zeros(10000,3);

for i=1:10000
    img_clust1(i,:) = means1(ids1(i,1),:);
    img_clust2(i,:) = means2(ids2(i,1),:);
    img_clust3(i,:) = means3(ids3(i,1),:);
end

% Reshape image and convert back to uint8
img_clust1 = reshape(img_clust1, 100, 100, 3);
img_clust2 = reshape(img_clust2, 100, 100, 3);
img_clust3 = reshape(img_clust3, 100, 100, 3);
img_seg1 = im2uint8(img_clust1);
img_seg2 = im2uint8(img_clust2);
img_seg3 = im2uint8(img_clust3);

imwrite(img_seg1, 'panda-3-5-10.jpg')
imwrite(img_seg2, 'cardinal-3-5-10.jpg')
imwrite(img_seg3, 'pittsburgh-3-5-10.jpg')

% Display the images in plot
subplot(2,2,1), imshow(img_seg1)
subplot(2,2,2), imshow(img_seg2)
subplot(2,2,3), imshow(img_seg3)
