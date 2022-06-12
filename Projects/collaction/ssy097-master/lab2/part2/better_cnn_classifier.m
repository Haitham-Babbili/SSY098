function layers = better_cnn_classifier()

    layers = [
        imageInputLayer([28 28 1]);
        convolution2dLayer(5,20);
        reluLayer();
        convolution2dLayer(5,20);       % Difference from basic classifier: 
        reluLayer();                    % Another convolutional layer
                                        % and rectifying unit
        maxPooling2dLayer(2,'Stride',2);
        fullyConnectedLayer(10);
        softmaxLayer();
        classificationLayer();
    ];

end