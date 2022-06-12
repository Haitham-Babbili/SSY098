function [w, w0] = process_epoch(w, w0, lrate, examples_train, labels_train)


tmp_rand= randperm(length(examples_train));


for k= 1: length(tmp_rand)
    
    ii= tmp_rand(k);
    test_data= examples_train{ii};
    test_label= labels_train(ii);
    
    [wgrad, w0grad] = partial_gradient(w,w0,test_data, test_label);
    
    w= w - (lrate.*wgrad);
    w0= w0 - (lrate.* w0grad);
    
end


end 