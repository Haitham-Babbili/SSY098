function [pts,pts_tilde,A_true,t_true]=affine_test_case(outlier_rate)


K=randi([3 100]);
pts=(rand(2,K)-1/2)*1000; % arbitrary upper limit of 500
pts_tilde=zeros(2,K);
A_true=(rand(2)-1/2)*100;
t_true=(rand(2,1)-1/2)*100;
for i=1:K
    if(outlier_rate>rand(1)) % if this is an outlier
        pts_tilde(:,i)=[rand(1)*max(pts(1,:)); rand(1)*max(pts(2,:))]; % random point in bounds of pts
    else
        pts_tilde(:,i)=A_true*pts(:,i)+t_true;
    end
end
end