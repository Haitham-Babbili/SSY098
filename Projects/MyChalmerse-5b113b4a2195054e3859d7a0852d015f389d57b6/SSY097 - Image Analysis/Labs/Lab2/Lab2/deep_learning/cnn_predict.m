function predictions = cnn_predict(net, imgs)

if regexp(net.layers{end}.type, 'loss')
    net.layers(end) = [];
end

predictions = zeros(1,length(imgs));

for kk = 1:100:length(imgs)-99
    
    predictions(kk:kk+99) = predict_some(net, imgs(kk:kk+99));    
    disp([num2str(kk) ' out of ' num2str(length(imgs))])
    
end

predictions(kk+1:end) = predict_some(net, imgs(kk+1:end));



function preds = predict_some(net, imgs)

patch = zeros(size(imgs{1},1), size(imgs{1},2), 1, length(imgs));

for mm = 1:length(imgs)
    patch(:,:,:,mm) =  imgs{mm};
end

res = vl_simplenn(net, single(patch), [], [], 'mode', 'test') ;
for mm = 1:length(imgs)
    [~, preds(mm)] = max(squeeze(res(end).x(:,:,:,mm)));
end
    