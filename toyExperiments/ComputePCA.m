% perform PCA and Whitening + L2 normalization as described in 
% 
% @inproceedings{jegou:hal-00722622,
%     hal_id = {hal-00722622},
%     url = {http://hal.inria.fr/hal-00722622},
%     title = {{Negative evidences and co-occurrences in image retrieval: the benefit of PCA and whitening}},
%     author = {J{\'e}gou, Herv{\'e} and Chum, Ondrej},
%  http://hal.inria.fr/docs/00/72/26/26/PDF/jegou_chum_eccv2012.pdf
clear;clc;
tic
featname = {{'sift_vlad_densesampling_rgbsift.arff.merged'}};
for k=1:length(featname)
    feature = readBigTable(cell2mat(featname{k}),15000,24576,1000);
    %     feature = dlmread(cell2mat(featname{k}),'',0,2);
    toc
    % pca
    [coef,score,latent,~,explained]=pca(feature);
    toc
    
    namefeat = char(featname{k});
    namecoef = [namefeat(1:end-12),'_coef'];
    save(namecoef,'coef');
    namescore = [namefeat(1:end-12),'score'];
    save(namescore,'score');
    nameexplained =[namefeat(1:end-12),'explained'];
    save(nameexplained,'explained');
    
    score = score(:,1:128);
    namescorepca = ['sift_pca128',namefeat(1:end-12)];
    save(namescorepca,'score');
    NofImages = length(feature);
    % whitening
    feat = diag(1./sqrt(latent))* score' ;
    feat = feat';
    white = feat;
    for i=1:NofImages
        x=feat(i,:);
        % l2 normalization
        feat(i,:)=x/norm(x,2);
    end
    toc
    
    name = ['sift_pca128_whiteL2_',namefeat(1:end-12)];
    save(name,'feat');
    clearvars -except featname ;
end
