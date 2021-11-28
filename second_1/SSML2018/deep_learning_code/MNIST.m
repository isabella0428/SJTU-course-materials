%% Load raw images
fileID = fopen('train-images-idx3-ubyte', 'rb');
magic = fread(fileID, 1, 'int32', 0, 'ieee-be');
numImages = fread(fileID, 1, 'int32', 0, 'ieee-be');
numRows = fread(fileID, 1, 'int32', 0, 'ieee-be');
numCols = fread(fileID, 1, 'int32', 0, 'ieee-be');
images = fread(fileID, inf, 'unsigned char');
images = reshape(images, numRows, numCols, numImages);
for i = 1 : numImages
    images(:, :, i) = images(:, :, i)';
end
train_images(:, :, 1, :) = images(:, :, :);
fclose(fileID);
%% Load raw labels
fileID = fopen('train-labels-idx1-ubyte', 'rb');
magic = fread(fileID, 1, 'int32', 0, 'ieee-be');
numImages = fread(fileID, 1, 'int32', 0, 'ieee-be');
train_labels = fread(fileID, inf, 'unsigned char');
%% Build CNN
Layers = [imageInputLayer([28, 28, 1])
          convolution2dLayer(5, 20)
          reluLayer
          maxPooling2dLayer(2, 'Stride', 2)
          fullyConnectedLayer(10)
          softmaxLayer
          classificationLayer()
          ];
miniBatchSize = 8192;
options = trainingOptions('sgdm', 'MiniBatchSize', miniBatchSize, 'Plots', 'training-progress', 'InitialLearnRate', 0.0001);
net = trainNetwork(train_images, categorical(train_labels), Layers, options);

      