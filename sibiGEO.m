function [result] = sibiGEO(baseFolder,strkata,side,nsample,nframe)
% SIBIGEO Compute regionprops feature extraction for video sample
%
% Parameter:
%   - 
%

    % Change to respective word folder
    nsample = num2str(nsample, '%02i');
    fold = sprintf('%s/%s/%s%s', baseFolder, strkata, strkata, nsample);
    %disp(fold)
    
    tic;

    img_color = [];
    img_depth = [];
    img_bin_depth = [];
    
    %% SKIP FRAMES %%
    % count total frames
    frameSize = length(dir(sprintf('%s/*LeftDepth*.png', fold)));
    %disp(frameSize)
    nskip = frameSize/nframe;
    
    %% Get all Image  and Get also Skeleton data %%
    ii = 1;
    sdata = zeros(8,nframe);
    ctr = 1;
    while round(ii) <= frameSize
        %str_color = sprintf('%s/%s%s-%sColor-%d.png', fold, strkata, nsample, side, ii);
        str_depth = sprintf('%s/%s%s-%sDepth-%d.png', fold, strkata, nsample, side, floor(ii));
        %img_now = imread(str_color);
        %img_color = cat(4, img_color, img_now);

        % Skeleton data
        skeldata = csvread(sprintf('%s/FULL Data Polar Head Point.csv', fold));
        sdata(:,ctr) = skeldata(:,floor(ii));
        
        img_now = imread(str_depth);
        img_depth = cat(4, img_depth, img_now);
        ii = ii + nskip;
        ctr = ctr+1;
    end

    %% Extract Based on Depth Only %%
    % Get binary depth %
    for ii=1:nframe
        %figure; imshow(img_depth(:,:,:,ii));
        img_bin_depth = cat(3, img_bin_depth, im2bw(img_depth(:,:,:,ii)));
    end
    % Extract features from regionprops %

    all_feats = [];
    for ii=1:nframe,
        %temp = Geo_Hand_Scenario_V1(img_bin_depth(:,:,ii));
        %size(temp)
        all_feats = vertcat(all_feats, Geo_Hand_Scenario_V2(img_bin_depth(:,:,ii)));
        % all_feats = vertcat(all_feats, Geo_Hand_Scenario_V1(img_gray(:,:,ii)));
        %figure, plot(Geo_Hand_Scenario_V1(img_bin_depth(:,:,ii)));
    end


    %% Create header %%
    save_path = sprintf('%s/[%sF]DataGeo_v2 %s%s%s-Feat.csv', fold, num2str(nframe), strkata, nsample, side);
    out = vector2d_transform_to_vector1d(all_feats);
    result = out';

    csvwrite(save_path, result);
    
    %% Save Reduced Skeleton data
    save_path = sprintf('%s/[%sF]Skel_Upper %s%s-Feat.csv', fold, num2str(nframe), strkata, nsample);
    csvwrite(save_path, sdata);
    toc

end