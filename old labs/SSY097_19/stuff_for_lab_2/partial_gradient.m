function [wgrad, w0grad] = partial_gradient(w, w0, example_train, label_train);

% Man skall bara skicka in en, inte flera bilder
% for i = 1:length(example_train)
%     example_train_mat(:,:,i) = cell2mat(example_train(i));
% 
%     scaldot(i) = sum(dot(example_train_mat(:,:,i),w));  % returns a scalar value
%     
%     y = scaldot(i) + w0;
%     p(i) = exp(y) / (1+exp(y));
% endclso

x = cell2mat(example_train);
scaldot = sum(dot(x, w));

y = scaldot + w0;
p = exp(y) / (1+exp(y));

% Li = -ln(p)
% label = cell2mat(label_train);

w0grad = (p - label_train);
wgrad = x .* w0grad;

% switch label_train
%     case 0
%         wgrad = x.*(p-1);    
%         w0grad = p-1;
%     case 1
%         wgrad = x.*p;    
%         w0grad = p;
% end



% L = 0;
% for i = 1:length(label_train)
%     label = label_train(i);
%     switch label
%         case 0
%             s = - log(1-p(i));    % this should be derived by hand
%         case 1
%             s = - log(p(i));      % this should be derived by hand
%     end
%     L = L + s;
% end
