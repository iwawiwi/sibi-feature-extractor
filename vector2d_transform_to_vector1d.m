function [result] = vector2d_transform_to_vector1d(input)
    arr_size = size(input); 
    arr_len = arr_size(1);
    
    result = zeros(arr_len*arr_size(2),1);
    offset = 1;
    end_point = arr_size(2);
    for ii = 1:arr_len
        result(offset:end_point,1) = input(ii,:);
        offset = end_point + 1;
        end_point = end_point + arr_size(2);
    end
end