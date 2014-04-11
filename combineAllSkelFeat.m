function combineAllSkelFeat(baseFolder,strkata,nstart,nend,nframe)
% COMBINEALLSKELFEAT Combine all Skeleton tangen angle feature for all video sample
% defined in 'samplename' parameter
%
% Parameter:
%	- 'samplename'	: all sample name cell
%
	csize = size(strkata, 2); % sample name size
	% Loop for each cell
	result = [];

    for ii = 1:csize
        kata = cell2mat(strkata(ii));
        for jj = nstart:nend
            nsamplename = sprintf('%s%02d', kata, jj);
            rootpathfile = sprintf('%s/%s/%s', baseFolder, kata, nsamplename);

            path = sprintf('%s/[%sF]Skel_Upper %s-Feat.csv', ...
                rootpathfile, num2str(nframe), nsamplename);

            % Read CSV file
            data = csvread(path);
            if(length(data) ~= nframe)
                disp(sprintf('%s = NFrame Inconsistent! COUNT = %d', rootpathfile, length(data)));
                continue
            end
            
            % skip

            % Concat csv data
            result = vertcat(result, [data(1,:) data(2,:)  data(3,:)  data(4,:)  data(5,:)  data(6,:)  data(7,:) data(8,:)]);
        end
    end

    data_length = size(data,2);
    disp(['Total Feature ' num2str(data_length)]);

    %% Write result to CSV
    pathtosave = sprintf('%s/[%sF]FeatureSkeleton_HeadCenter_V1.csv', baseFolder, num2str(nframe));
    csvwrite(pathtosave, result);
end