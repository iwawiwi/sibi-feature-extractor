function [ res ] = SignalSampling( input_wave, len_sample )
%TESTING_SAMPLING Summary of this function goes here
%   Detailed explanation goes here1,
    len = length(input_wave);
    res = zeros(1, len_sample);
    
    skip = len / len_sample;
    idx = 1;
    for ii=1:skip:len,
        res(idx) = input_wave((round(ii)));
        idx = idx+1;
    end
    
    %figure, plot(res);
    
end

