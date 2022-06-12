function [best_A,best_t, inliers] = ransac_fit_affine(pts, pts_tilde, threshold)

iterations = 5000;
K = 3;
bestnum = 0;
for j = 1:iterations
   index = randperm(size(pts,2), K);
   
   subset = pts(:,index(:));
   subset_tilde = pts_tilde(:,index(:));
   
   [A, t] = estimate_affine(subset, subset_tilde);
   
   res = residual_lgths(A, t, pts, pts_tilde);
   
   inlierIdx = find(res<=threshold);
   num = length(inlierIdx);

    if num >= bestnum
         bestnum = num;
         best_A = A;
         best_t = t;
         inliers = inlierIdx;
     end

end
%plot(pts_tilde(1,:),pts_tilde(2,:),'*')
%hold on
%plot(subset_tilde(1,:),subset_tilde(2,:));
end