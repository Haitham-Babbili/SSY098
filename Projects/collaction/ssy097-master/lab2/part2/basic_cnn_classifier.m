function layers = basic_cnn_classifier()

    
    layers = [
        imageInputLayer([29 29 3]);
        convolution2dLayer(5,20,'Stride',2);
        reluLayer();
        maxPooling2dLayer(2,'Stride',2);
        fullyConnectedLayer(2);
        softmaxLayer();
        classificationLayer();
    ];

end