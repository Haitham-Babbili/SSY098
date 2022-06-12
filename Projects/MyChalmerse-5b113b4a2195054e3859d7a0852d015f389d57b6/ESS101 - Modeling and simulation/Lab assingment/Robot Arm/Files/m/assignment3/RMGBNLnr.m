function [ nl_greyMdls, nl_est_Js ] = RMGBNLnr( est_ALL, Ns )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明

N = 64;
Km = 0.00839;
Rm = 3.21;
J = 0.0017;
T = 0;
%% Nonlinear Model
order = [1 1 2];
parameters = {N, Km, Rm, J};
initial_states = [1; 0];
nl_greyMdl = idnlgrey('RMGreyBoxNl', order, parameters, initial_states, T);
setpar(nl_greyMdl, 'Fixed', {true true true false});
nl_greyMdls = {};
nl_est_Js = [];
for i = 1 : Ns
    nl_greyMdl = nlgreyest(est_ALL{i}, nl_greyMdl, 'Display', 'Full');
    nl_J_best = nl_greyMdl.Parameters(4).Value;
    [nl_J_est, dnl_J_est] = getpvec(nl_greyMdl,'free');
    nl_greyMdls{i} = nl_greyMdl;
    nl_est_Js = vertcat(nl_est_Js, [nl_J_best, nl_J_est, dnl_J_est]);
end

end

