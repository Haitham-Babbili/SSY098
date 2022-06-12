function [ FA, PDD ] = compute_FA_PDD( D )
%%COMPUTE_FA_PDD Compute FA and PDD of the given diffusion tensor D.

% Calculate eigenvalues and eigenvectors of D
[eigVT, eigVL] = eig(D);
eigVL = diag(eigVL);

% Extract the main eigenvector that is
% corresponding to the max eigenvalue
PDD = eigVT(:, eigVL == max(eigVL));

% Calculate mean diffusity
MD = mean(eigVL);

% Compute FA
FAn = sqrt(3 * sum((eigVL - MD).^2));
FAd = sqrt(2 * sum(eigVL.^2));
FA = FAn / FAd;

end