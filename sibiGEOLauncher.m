function sibiGEOLauncher(baseFolder,nstart,nend,nframe)

    if isempty(baseFolder) % default base folder
        baseFolder = 'D:/SIBI/Frames/FULL';
    end
    
    % List all possible word folder in this directory
    %cd(baseFolder);
    d = dir(baseFolder);
    isd = [d(:).isdir];
    strkata = {d(isd).name};
    strkata(ismember(strkata,{'.','..'})) = [];

	strkata = reshape(strkata,1,[]); % reshape to 1xN cell
	csize = size(strkata,2); % total name to compute

	%% Loop for all sample name
    clabels = cell(1,csize);
	for ii = 1:csize
		kata = cell2mat(strkata(ii));
		%% Launch sibiGEO function for defined sample number
    	for jj = nstart:nend
        	result_right = sibiGEO(baseFolder,kata,'Right',jj,nframe); % Right Hand Reduced Feature
        	result_left = sibiGEO(baseFolder,kata,'Left',jj,nframe); % Left Hand Reduced Feature
        end
        
        % Read Labels
        fold = sprintf('%s/%s', baseFolder, kata);
        clabels{ii} = readLabel(fold);
    end
    
    %% Combine GEO feature
    disp('Combining depth image features')
    combineAllGEOFeat(baseFolder,strkata,clabels,nstart,nend,nframe);
    
    %% Combine Skeleton feature
    disp('Combining skeleton data features')
    combineAllSkelFeat(baseFolder,strkata,nstart,nend,nframe);
end