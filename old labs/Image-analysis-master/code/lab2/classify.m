function predicted_labels=classify(examples_val,w,w0)
N=size(examples_val,2);
predicted_labels=zeros(N,1);
for i=1:N
    % calculate p
    K=dot(examples_val{i},w);
    y=sum(K(:))+w0;
    p=1/(exp(-y)+1);
    
    % round to nearest integer to see what the classified label is
    predicted_labels(i)=round(p);

end
end
