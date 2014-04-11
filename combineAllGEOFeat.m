function combineAllGEOFeat(baseFolder,strkata,poslabel,nstart,nend,nframe)
% COMBINEALLGEOFEAT Combine all Region Properties feature for all video sample
% defined in 'samplename' parameter
%
% Parameter:
%	- 'samplename'	: all sample name cell
%

	csize = size(strkata,2); % sample name size
	% Loop for each cell
    result = [];
    label_result_1 = {};
    label_result_2 = {};
    label_result_3 = {};
    label_result_4 = {};
    label_result_5 = {};
    for ii = 1:csize
        kata = cell2mat(strkata(ii));
        for jj = nstart:nend
            nsamplename = sprintf('%s%02d', kata, jj);
            rootpathfile = sprintf('%s/%s/%s', baseFolder, kata, nsamplename);

            r_csvpath = sprintf('%s/[%sF]DataGeo_v2 %sRight-Feat.csv', ...
                rootpathfile, num2str(nframe), nsamplename);
            l_csvpath = sprintf('%s/[%sF]DataGeo_v2 %sLeft-Feat.csv', ...
                rootpathfile, num2str(nframe), nsamplename);

            % Read CSV file
            r_data = csvread(r_csvpath);
            l_data = csvread(l_csvpath);
            
            if(length(r_data) ~= nframe*36)
                disp(sprintf('%s = NFrame Inconsistent! COUNT = %d', ...
                    rootpathfile, length(r_data)));
                continue
            end

            % Concat csv data
            result = vertcat(result, [r_data l_data]);
            label_result_1 = vertcat(label_result_1, poslabel{ii}{1});
            label_result_2 = vertcat(label_result_2, poslabel{ii}{2});
            label_result_3 = vertcat(label_result_3, poslabel{ii}{3});
            label_result_4 = vertcat(label_result_4, poslabel{ii}{4});
            label_result_5 = vertcat(label_result_5, poslabel{ii}{5});
        end
    end

    data_length = size(r_data,2);
    disp(['Total Feature ' num2str(data_length)]);

    %% Write result to CSV
    pathtosave = sprintf('%s/[%sF]FeatureImage_GEO_V2.csv', baseFolder, num2str(nframe));
    csvwrite(pathtosave, result);
    
    %% Write Labels as CSV too
    pathtosave1 = sprintf('%s/[%sF]Module01_Labels.csv', baseFolder, num2str(nframe));
    %xlswrite(pathtosave, label_result_1);
    pathtosave2 = sprintf('%s/[%sF]Module02_Labels.csv', baseFolder, num2str(nframe));
    %xlswrite(pathtosave, label_result_2);
    pathtosave3 = sprintf('%s/[%sF]Module03_Labels.csv', baseFolder, num2str(nframe));
    %xlswrite(pathtosave, label_result_3);
    pathtosave4 = sprintf('%s/[%sF]Module04_Labels.csv', baseFolder, num2str(nframe));
    %xlswrite(pathtosave, label_result_4);
    pathtosave5 = sprintf('%s/[%sF]Module05_Labels.csv', baseFolder, num2str(nframe));
    %xlswrite(pathtosave, label_result_5);
    
    fid1 = fopen(pathtosave1,'w');
    fid2 = fopen(pathtosave2,'w');
    fid3 = fopen(pathtosave3,'w');
    fid4 = fopen(pathtosave4,'w');
    fid5 = fopen(pathtosave5,'w');
    
    for ii=1:length(label_result_1)
        fprintf(fid1, '%s\n', label_result_1{ii});
        fprintf(fid2, '%s\n', label_result_2{ii});
        fprintf(fid3, '%s\n', label_result_3{ii});
        fprintf(fid4, '%s\n', label_result_4{ii});
        fprintf(fid5, '%s\n', label_result_5{ii});
    end
    
    fclose(fid1);
    fclose(fid2);
    fclose(fid3);
    fclose(fid4);
    fclose(fid5);
end