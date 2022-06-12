
% Create grey-box model
N = 64;
Km = 0.00839;
Rm = 3.21;
J = 0.0017;
greyMdl = idgrey('RMGreyBox', {N, Km, Rm, J}, 'c');
% Specify N, Km, Rm as known parameters
greyMdl.Structure.Parameters(1).Free = false;
greyMdl.Structure.Parameters(2).Free = false;
greyMdl.Structure.Parameters(3).Free = false;
% Estimate best J with measured data
greyMdl = greyest(Theta1_grey_n, greyMdl);
% Update parameters of model
[J_best,dJ_best] = getpvec(greyMdl, 'free');






