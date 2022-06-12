function [ mean_FA, mean_AE ] = multiple_estimate( iter_num, D, PDD, g, b, S0, var )
%%MULTIPLE_ESTIMATE Do estimation of diffusion tensor multiple time and
%comput mean FA and mean AE (angular error) from the estimatd result.

% Obtain FA and AE of each estimation
FAs = zeros(iter_num, 1);
AEs = zeros(iter_num, 1);
for i = 1 : iter_num
    [~, FAs(i), PDD_hat] = estimate_D_hat(D, g, b, S0, var);
    AEs(i) = acos(PDD' * PDD_hat);
end

% Calculate mean of FA and AE
mean_FA = mean(FAs);
mean_AE = mean(AEs);

end

