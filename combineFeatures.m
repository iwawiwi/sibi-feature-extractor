function combineFeatures(baseFolder,nframe)
% COMBINEFEATURES Combine all Skeleton tangen angle feature for all video sample
% defined in 'samplename' parameter
%
% Parameter:
%	- 'samplename'	: all sample name cell
%
    geo_feat_path = sprintf('%s/[%sF]FeatureImage_GEO_V2.csv', baseFolder, num2str(nframe));
    skl_feat_path = sprintf('%s/[%sF]FeatureSkeleton_HeadCenter_V1.csv', baseFolder, num2str(nframe));
    lbl_1_path = sprintf('%s/[%sF]Module01_Labels.csv', baseFolder, num2str(nframe));
    lbl_2_path = sprintf('%s/[%sF]Module02_Labels.csv', baseFolder, num2str(nframe));
    lbl_3_path = sprintf('%s/[%sF]Module03_Labels.csv', baseFolder, num2str(nframe));
    lbl_4_path = sprintf('%s/[%sF]Module04_Labels.csv', baseFolder, num2str(nframe));
    lbl_5_path = sprintf('%s/[%sF]Module05_Labels.csv', baseFolder, num2str(nframe));
    
    geo_feat = csvread(geo_feat_path);
    skl_feat = csvread(skl_feat_path);
    feats = [skl_feat geo_feat];
    
    fid1 = fopen(lbl_1_path);
    fid2 = fopen(lbl_2_path);
    fid3 = fopen(lbl_3_path);
    fid4 = fopen(lbl_4_path);
    fid5 = fopen(lbl_5_path);
    
    l1 = {};
    l2 = {};
    l3 = {};
    l4 = {};
    l5 = {};
    
    tline1 = fgetl(fid1);
    tline2 = fgetl(fid2);
    tline3 = fgetl(fid3);
    tline4 = fgetl(fid4);
    tline5 = fgetl(fid5);
    while ischar(tline1)
        l1 = vertcat(l1, tline1);
        l2 = vertcat(l2, tline2);
        l3 = vertcat(l3, tline3);
        l4 = vertcat(l4, tline4);
        l5 = vertcat(l5, tline5);
        tline1 = fgetl(fid1);
        tline2 = fgetl(fid2);
        tline3 = fgetl(fid3);
        tline4 = fgetl(fid4);
        tline5 = fgetl(fid5);
    end
    
    fclose(fid1);
    fclose(fid2);
    fclose(fid3);
    fclose(fid4);
    fclose(fid5);
    
    mod_1_path = sprintf('%s/%sF_Module01_Feats.csv', baseFolder, num2str(nframe));
    mod_2_path = sprintf('%s/%sF_Module02_Feats.csv', baseFolder, num2str(nframe));
    mod_3_path = sprintf('%s/%sF_Module03_Feats.csv', baseFolder, num2str(nframe));
    mod_4_path = sprintf('%s/%sF_Module04_Feats.csv', baseFolder, num2str(nframe));
    mod_5_path = sprintf('%s/%sF_Module05_Feats.csv', baseFolder, num2str(nframe));
    A = {}; B = {}; C = {}; D = {}; E = {};
    for ii=1:size(l1,1) 
        A = vertcat(A, {feats(ii,:), l1{ii}});
        B = vertcat(B, {feats(ii,:), l2{ii}});
        C = vertcat(C, {feats(ii,:), l3{ii}});
        D = vertcat(D, {feats(ii,:), l4{ii}});
        E = vertcat(E, {feats(ii,:), l5{ii}});
    end
    xlswrite(mod_1_path,A);
    xlswrite(mod_2_path,B);
    xlswrite(mod_3_path,C);
    xlswrite(mod_4_path,D);
    xlswrite(mod_5_path,E);
    %dlmwrite(mod_1_path, );
end