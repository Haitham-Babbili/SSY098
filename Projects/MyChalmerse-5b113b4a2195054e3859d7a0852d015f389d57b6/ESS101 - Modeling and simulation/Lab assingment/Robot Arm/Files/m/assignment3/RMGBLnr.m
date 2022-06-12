function [ greyMdls, est_Js ] = RMGBLnr( est_ALL, Ns )
% Linear Model
N = 64;
Km = 0.00839;
Rm = 3.21;
J = 0.0017;
% Get Model
greyMdl = idgrey('RMGreyBox', {N, Km, Rm, J}, 'c');
% 
greyMdl.Structure.Parameters(1).Free = false;
greyMdl.Structure.Parameters(2).Free = false;
greyMdl.Structure.Parameters(3).Free = false;
greyMdls = {};
est_Js = [];
for i = 1 : Ns
    greyMdl = greyest(est_ALL{i}, greyMdl);
    %J_best = greyMdl.Structure.Parameters(4).Value;
    [l_J_est,dl_J_est] = getpvec(greyMdl, 'free');
    greyMdls{i} = greyMdl;
    est_Js = vertcat(est_Js, [l_J_est, dl_J_est]);
end
end

