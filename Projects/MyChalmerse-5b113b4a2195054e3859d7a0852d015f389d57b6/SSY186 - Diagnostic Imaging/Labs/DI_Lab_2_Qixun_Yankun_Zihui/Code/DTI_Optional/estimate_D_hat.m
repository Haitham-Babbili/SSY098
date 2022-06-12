function [ D_hat, FA_hat, PDD_hat ] = estimate_D_hat( D, g, b, S0, var )
%%ESTIMATE_D_HAT Estimate the diffusion tensor while the measured signal is
%inferenced by noise.

% Obtain the number of directions
dir_num = size(g, 2);

% Compute measured signal without noise
S = zeros(dir_num, 1);
for i = 1 : dir_num
    S(i) = S0 * exp(-b * (g(:, i)' * D * g(:, i)));
end

% Add noise to the signal
% Noise is zero-mean Gaussian noise with variance var
n1 = normrnd(0, sqrt(var), [dir_num, 1]);
n2 = normrnd(0, sqrt(var), [dir_num, 1]);
Sm = sqrt((S + n1).^2 + n2.^2);

% Estimate D_hat
% Sm = S0 * exp(-bg'Dg) ==> -ln(Sm/S0)/b = g'Dg
% Form B matrix as the Equation 5 in the report
% The dimension of B is dir_num by 6
B = zeros(dir_num, 6);
gT = g';
B(:, 1) = gT(:, 1).^2;
B(:, 2) = gT(:, 2).^2;
B(:, 3) = gT(:, 3).^2;
B(:, 4) = 2 * gT(:, 1) .* gT(:, 2);
B(:, 5) = 2 * gT(:, 1) .* gT(:, 3);
B(:, 5) = 2 * gT(:, 2) .* gT(:, 3);

% Use least-square method to do estimation
D_temp = pinv(B) * (-log(Sm / S0) / b);

D_hat = zeros(3);
D_hat(1, 1) = D_temp(1); D_hat(2, 2) = D_temp(2); D_hat(3, 3) = D_temp(3);
D_hat(1, 2) = D_temp(4); D_hat(2, 1) = D_temp(4);
D_hat(1, 3) = D_temp(4); D_hat(3, 1) = D_temp(5);
D_hat(3, 2) = D_temp(4); D_hat(2, 1) = D_temp(6);

% Compute FA and PDD for D_hat
[FA_hat, PDD_hat] = compute_FA_PDD(D_hat);

end