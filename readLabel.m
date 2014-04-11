function [labels] = readLabel(baseFolder)
%READLABEL Summary of this function goes here
%   Detailed explanation goes here
        
    %cd(baseFolder); 
    filename = sprintf('%s/label.txt', baseFolder);
    
    % Read labels
    fid = fopen(filename);
    tline = fgetl(fid);
    labels = cell(1,5);
    idx = 1;
    while ischar(tline)
        %disp(tline)
        labels{idx} = tline;
        idx = idx+1;
        tline = fgetl(fid);
    end
    
    fclose(fid);
end