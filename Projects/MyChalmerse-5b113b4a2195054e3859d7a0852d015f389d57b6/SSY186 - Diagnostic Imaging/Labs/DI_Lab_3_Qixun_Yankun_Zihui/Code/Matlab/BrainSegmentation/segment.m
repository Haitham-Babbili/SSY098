function segment( files_path, dims, oneslice, pm )
% This program demonstrates segmentation of MR-brain image into
% three tissues: white matter, gray matter, and CSF (cerebrospinal fluid)
% Used MR-modalities   : T1-weighted, T2-weighted and PD (Proton Density)
% Segmentation  method : k-means
% Performance measure  : Dice index
% Image to segment     : an axial slice
%
% Input Arguments:
%   - files_path: paths of .mnc file
%   - dims : "2" or "3", if "2", use T1 and T2 to do segmentation';
%            else, use T1, T2 and PD to do segmentaton.
%   - oneslice : do segmentation on one slice is it is 1, else all
%                points in the volume will be classified.
%   - pm : the method to calculate similar coefficient,
%          "di" for dice index, "ji" for jaccard index.
%
% SSY186 Diagnostic Imaging 2017 
% Author: Your Name

% Set default values
if nargin < 4 || isempty(pm)
    pm = 'di';
end

if nargin < 3 || isempty(oneslice)
    oneslice = 1;
end

if nargin < 2 || isempty(dims)
    dims = 2;
end

fprintf(['--- Brain Tissue Segmentation demo : ' datestr(now) '\n']);
close all;

% define tissue labels
% see http://brainweb.bic.mni.mcgill.ca/brainweb/anatomic_normal.html
CSF=1; GM=2; WM=3; GLIA=8;
% BCK=0; FAT=4; MUSCLE=5; SKIN=6; SKULL=7;  CON=9;
% BCK = background, CSF = cerebrospinal fluid, GM = gray matter ...

% define filenames (using Brainweb names)
% fnT1  = 't1_icbm_normal_1mm_pn0_rf0';   % T1
% fnT2  = 't2_icbm_normal_1mm_pn0_rf0';   % T2
% fnPD  = 'pd_icbm_normal_1mm_pn0_rf0';   % PD
% fnGT  = 'phantom_1.0mm_normal_crisp';   % Ground Truth

% loadmnc from: http://www.mathworks.com/matlabcentral/fileexchange/32644-loadminc
% load data volumes
[T1, ~] = loadminc(files_path{1});
[T2, ~] = loadminc(files_path{2});
[PD, ~] = loadminc(files_path{3});
[GT, ~] = loadminc(files_path{4});

GT = uint8(GT);     % GT = Ground Truth labels
GT(GT==GLIA) = GM;  % let's treat glia cells as gray matter
 
% take a look at the volumes
% T2 = permute(T2, [1 2 3]);  % the original, axial view
% T2 = permute(T2, [3 2 1]); % look at a different view

% Take a look at the volume data
% browseVolume(T1);
% browseVolume(T2); % comment out this line, when you are familiar with the data
% browseVolume(PD);
% browseVolume(GT);

[~, ~, K] = size(T1);    % get size of the volume
Kc = round(K/2);         % select central index
 
% oneslice=1;  % to make it easier to demonstrate we use ONE central (axial)slice only
if oneslice
    % Let's work with ONE slice only
    % display the central axial slice
    
    figure(10); T1 = T1(:,:,Kc);  imagesc(T1); colormap gray; title(['T1 slice#: ' num2str(Kc)]);
    % T1n = T1 - min(T1(:)); T1n = T1n/max(T1n(:));  % normalize/stretch to 0..1
    %imwrite(T1n, 'T1.jpg','jpg','Quality', 100);
    
    figure(20); T2 = T2(:,:,Kc);  imagesc(T2); colormap gray; title(['T2 slice#: ' num2str(Kc)]);
    % T2n = T2 - min(T2(:)); T2n = T2n/max(T2n(:));
    %imwrite(T2n, 'T2.jpg','jpg','Quality', 100);
    
    figure(30); PD = PD(:,:,Kc);  imagesc(PD); colormap gray; title(['PD slice#: ' num2str(Kc)]); 
    % PDn = PD - min(PD(:)); PDn = PDn/max(PDn(:));
    %imwrite(PDn, 'PD.jpg','jpg','Quality', 100);
     
    figure(40); GT = GT(:,:,Kc);  imagesc(GT);
    title(['Ground Truth, slice #:' num2str(Kc) '\newline 0=BCK, 1=CSF, 2=GM, 3= WM ...']);
    colorbar;
    
end
 
sizeIMG = size(T1); % remember size of the volume
T1 = T1(:); T2 = T2(:); GT = GT(:); % make data one dimensional == kmeans() requirement

% construct tissue masks/labels
BRAIN_MASK = ((GT==CSF) | (GT==GM) | (GT==WM));
CSF_MASK   = GT==CSF;
GM_MASK    = GT==GM;
WM_MASK    = GT==WM;

% we are interested in brain tissues only
% so let's treat non-brain voxels as NaN
% or another way: we assume that we could
% perfectly separate WM/MM/CSF from other tissues
T1(~BRAIN_MASK) = NaN;
T2(~BRAIN_MASK) = NaN;
GT(~BRAIN_MASK) = NaN;
 
% normalize to 0..1, why?  otherwise some modality
% may dominate distance measurements (in the kmeans-algorithm)
T1 = T1-min(T1(:)); T1 = T1/max(T1(:));
T2 = T2-min(T2(:)); T2 = T2/max(T2(:));

if dims == 3
    PD = PD(:);
    PD(~BRAIN_MASK) = NaN;
    PD = PD-min(PD(:));
    PD = PD/max(PD(:));
end

%% take a look how data look like, using scatterplots
figure; set(gca,'FontSize', 14);
switch dims
    case 2
        scatter(T1(BRAIN_MASK), T2(BRAIN_MASK),'k.', 'LineWidth', 1);
    case 3
        scatter3(T1(BRAIN_MASK), T2(BRAIN_MASK), PD(BRAIN_MASK), 'k.', 'LineWidth', 1);
        zlabel('PD');
end
grid on; title('Brain data: data to cluster');
xlabel('T1'); ylabel('T2');

% uiwait(msgbox('Click OK to continue','Tissue Segmentation','modal'));

% take a look how data look like, use scatterplots
% this time using true labels
figure; set(gca,'FontSize', 14);
switch dims
    case 2
        plot(T1(CSF_MASK), T2(CSF_MASK),'r.', 'LineWidth', 1); hold on;
        plot(T1(GM_MASK),  T2(GM_MASK), 'g.', 'LineWidth', 1);
        plot(T1(WM_MASK),  T2(WM_MASK), 'b.', 'LineWidth', 1);
    case 3
        plot3(T1(CSF_MASK), T2(CSF_MASK), PD(CSF_MASK), 'r.', 'LineWidth', 1); hold on;
        plot3(T1(GM_MASK),  T2(GM_MASK), PD(GM_MASK), 'g.', 'LineWidth', 1);
        plot3(T1(WM_MASK),  T2(WM_MASK), PD(WM_MASK), 'b.', 'LineWidth', 1);
        zlabel('PD');
end
legend('CSF', 'GM', 'WM');
grid on; title('Brain data: true labels');
xlabel('T1'); ylabel('T2');
 
% put data into one vector/matrix
switch dims
    case 2
        X = [T1 T2];  % X = input data for segmentation,  using T1 and T2
        start_center = [0 1; 0.5 0.5; 1 0];
    case 3
        X = [T1 T2, PD]; % X = input data for segmentation,  using T1, T2 and PD
        start_center = [0 1 1; .5 .5 .5; 1 0 0.5];
end
nrClasses = 3; % desired # of output segments

% do segmentation using k-means algorithm
% see >> help kmeans
MSGID = 'stats:kmeans:MissingDataRemoved'; warning('off', MSGID);

[cidx, ~] = kmeans(X, nrClasses, 'Start', start_center);  % <-- the main row
cidx = uint8(cidx);

% [cidx, ctrs] = kmeans(X, nrClasses); % <--- wibrowseVolumell the result be different
% without 'clever' initialization ? i.e with no 'Start' parameter

% Segmentation/clustering is ready! Show the results ...
% Show the k-means result as scatterplot

figure; set(gca,'FontSize', 14);
switch dims
    case 2
        plot(X(cidx==CSF,1),X(cidx==CSF,2),'r.', ...
             X(cidx==GM,1) ,X(cidx==GM,2) ,'g.', ...
             X(cidx==WM,1) ,X(cidx==WM,2) ,'b.');
    case 3
        plot3(X(cidx==CSF,1),X(cidx==CSF,2),X(cidx==CSF,3), 'r.', ...
              X(cidx==GM,1) ,X(cidx==GM,2),X(cidx==GM,3) ,'g.', ...
              X(cidx==WM,1) ,X(cidx==WM,2),X(cidx==WM,3) ,'b.');
        zlabel('PD');
end
xlabel('T1'); ylabel('T2'); legend('CSF','GM', 'WM');    
title('Segmented data'); grid on;

% Calculate the performance measures: confusion matrix and Dice index
fprintf('Confusion matrix:\n')
cm = confusionmat(cidx(:), GT(:));   % >> help confusionmat
disp(cm)

% calculate similar coefficient
% sc = similarCoefficient(cm, pm);

switch pm
    case 'di'
        method = 'Dice Index';
        sc = diceIndex(cm);
    case 'ji'
        method = 'Jaccard Index';
        sc = jaccardIndex(cm);
end
        
% disp('Modality = (T1, T2), Protocol=ICBM, Phantom_name=normal, Slice_thickness=1mm, Noise=0%, INU=0%');
fprintf([method ':\n\t| CSF\t\t| GM\t\t| WM\n']);
fprintf('\t| %.4f\t| %.4f\t| %.4f\n', sc(2), sc(3), sc(4))
plotIndex(sc, method);

T1   = reshape(T1, sizeIMG); % make 2D image again
GT   = reshape(GT, sizeIMG);
cidx = reshape(cidx, sizeIMG);
errors =(GT~=cidx);
brainPixels = (GT>0);
nrErrors = sum(errors(:));
nrBrainPixels = sum(brainPixels(:));
ratio = nrErrors/nrBrainPixels;
disp(['Total # of errors: ' num2str(sum(errors(:)))  ' (' num2str(100*ratio) '%)']);

if oneslice
   
    % visualize  segmentation results in spatial domain
    % plot erroneously assigned pixels on the original images
    figure; set(gca,'FontSize', 12);
    MSGID = 'MATLAB:concatenation:integerInteraction';  warning('off', MSGID);
    imagesc([cidx errors; cidx GT]); axis off;

    title(['UPPER-LEFT : errors on segmented image  ' ...
           'UPPER-RIGHT: error pixels \newline' ...
           'LOWER-LEFT : segmentation result        ' ...
           'LOWER-RIGHT: Ground Truth image \newline' ...
           '0= BCK 1=CSF, 2= GM, 3 = WM']);
    hold on; cb = colorbar;
    set(cb,'YTick', [0 1 2 3], 'YTickLabel',[{'0'} {'1'} {'2'} {'3'}]);

    [x, y] = find(errors);
    plot(y, x, 'wo');

    figure; % plot errors on T1 image
    set(gcf, 'Position', [300, 150, 400, 400])
    imagesc(T1); hold on; plot(y, x, 'ro'); colormap gray; axis image off;
    title(['Wrongly classified pixels in red \newline' ...
           method ': CSF  GM   WM : ' num2str(sc(2:4)) '\newline' ...
           'Total # of errors: ' num2str(nrErrors)]);
end

fprintf('Ready !\n');

end

function browseVolume(V)
    % shows the volume V, slice by slice
    figure;
    [~, ~, K] = size(V);
    for k=1:K
        slice = V(:,:,k); imagesc(slice); colormap gray; title(k); drawnow;
        pause(0.1);
    end
end

function plotIndex(sc, method)
    figure; LW=2; set(gca,'FontSize', 14);
    plot(sc(2:end) ,'ro:', 'LineWidth', LW); hold on; grid on;
    ax = axis; xlabel('Tissue type'); ylabel(method);
    axis([0 4 ax(3) ax(4)]);
    set(gca,'XTick', 0:4);
    set(gca,'XTickLabel',[ {''} {'CSF'} {'GM'} {'WM'} {''}]);
end