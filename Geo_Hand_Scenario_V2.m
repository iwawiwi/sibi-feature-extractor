function [ features ] = Geo_Hand_Scenario_V2( img_bw )
%GEO_HAND_SCENARIO_V1 Summary of this function goes here
%   Detailed explanation goes here
    features = [];
    
    temp_feats = regionprops(img_bw, 'all');
    % Select first object detected %
    % size(temp_feats)
    % Handling no region found
    if size(temp_feats,1) == 0
        % Exception -> Throws 0 value
        features = zeros(1,36);
    else 
        % Should find largest area found by regionprops
        choosen_idx = 1;
        max_area = 0;
        for ii = 1:size(temp_feats,1)
            curr_area = temp_feats(ii).Area;
            if (max_area > curr_area)
                choosen_idx = ii;
            end
        end

        % figure; imshow(img_bw);
        %disp(['Choosen index ' num2str(choosen_idx) ' from size ' num2str(size(temp_feats,1))]);

        temp_feats = temp_feats(choosen_idx);
        area = temp_feats.Area / 100;
        centroid = temp_feats.Centroid;
        major_ax = temp_feats.MajorAxisLength;
        minor_ax = temp_feats.MinorAxisLength;
        orientation = temp_feats.Orientation;
        temp_convex_hull = temp_feats.ConvexHull;
        norm_convex_hull = zeros(size(temp_convex_hull));
        % Normalize convexhull (x, y) by centroid %
        for ii=1:size(temp_convex_hull, 1),
            norm_convex_hull(ii, :) = temp_convex_hull(ii, :) - centroid;
        end

        sample_convex_hull = [SignalSampling(norm_convex_hull(:, 1), 15)' SignalSampling(norm_convex_hull(:, 2), 15)'];

        features = [area centroid orientation major_ax minor_ax sample_convex_hull(:, 1)' sample_convex_hull(:, 2)'];    
    end
end

