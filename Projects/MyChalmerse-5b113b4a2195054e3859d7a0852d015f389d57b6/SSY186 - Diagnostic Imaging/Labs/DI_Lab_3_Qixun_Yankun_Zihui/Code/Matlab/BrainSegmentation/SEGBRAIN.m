%% Brain Segmentation
% Task 1 (both mandotary and optional) of lab 3 for Diagnostic Imaging.
% Group Members: Qixun Qu, Yankun Xu, Zihui Wang.
% Scripts and functions are tested in Matlab 2017a.
% 2017/05/06

%% Clean Environment
clc; clear; close all

%% Set Data Path
% Data with 0% noise and 0% intensity non-uniform 
fnT1  = 'data/t1_icbm_normal_1mm_pn0_rf0.mnc';   % T1
fnT2  = 'data/t2_icbm_normal_1mm_pn0_rf0.mnc';   % T2
fnPD  = 'data/pd_icbm_normal_1mm_pn0_rf0.mnc';   % PD
fnGT  = 'data/phantom_1.0mm_normal_crisp.mnc';   % Ground Truth
files_path_0 = {fnT1, fnT2, fnPD, fnGT};

% Data with 5% noise and 20% intensity non-uniform
fnT1  = 'data/t1_icbm_normal_1mm_pn5_rf20.mnc';   % T1
fnT2  = 'data/t2_icbm_normal_1mm_pn5_rf20.mnc';   % T2
fnPD  = 'data/pd_icbm_normal_1mm_pn5_rf20.mnc';   % PD
files_path_1 = {fnT1, fnT2, fnPD, fnGT};

clear fnT1 fnT2 fnPD fnGT

%% Task 1: Segmentation of Brain Tissues
% Segment white matter, gray matter and CSF using T1w, T2w and PD - signals.

% Step (3) Data with 0% noise and 0% intensity non-uniform
fprintf('============================================================\n\n')
fprintf('Segment WM, GM and CSF with 0%% noise and 0%% intensity non-uniform data.\n')
% Run segmentation process
segment(files_path_0, 2, 1, 'di')
fprintf('\nPress any key to continue ...\n\n')
fprintf('============================================================\n\n')
pause

% Step (4) Data with 5% noise and 20% intensity non-uniform
fprintf('Segment WM, GM and CSF with 5%% noise and 20%% intensity non-uniform data.\n')
% Run segmentation process
segment(files_path_1, 2, 1, 'di')
fprintf('\nPress any key to continue ...\n\n')
fprintf('============================================================\n\n')
pause

% Step (5) Segmentation input data is 3D: T1, T2, and PD
fprintf('Segment WM, GM and CSF with 3 dimentional data.\n')
fprintf('(0%% noise and 0%% intensity non-uniform data)\n')
% Run segmentation process
segment(files_path_0, 3, 1, 'di')
fprintf('\nPress any key to continue ...\n\n')
fprintf('============================================================\n\n')
pause

%% Optional Task
% (1) Implement Jaccard-index as a performance measure
fprintf('Implement Jaccard-index as a performance measure.\n')
fprintf('(0%% noise and 0%% intensity non-uniform data)\n')
% Run segmentation process
segment(files_path_0, 3, 1, 'ji')
fprintf('\nPress any key to continue ...\n\n')
fprintf('============================================================\n\n')
pause

% (2) Segmentation on whole volume
fprintf('Segment WM, GM and CSF of whole volume.\n')
fprintf('(0%% noise and 0%% intensity non-uniform data)\n')
% Run segmentation process
segment(files_path_0, 3, 0, 'di')
% segment(files_path_0, 3, 0, 'ji')
fprintf('\nPress any key to quit.\n\n')
fprintf('============================================================\n\n')
pause

%% Close All Windows
close all