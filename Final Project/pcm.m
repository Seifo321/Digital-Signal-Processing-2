function output_data = pcm(data, n_bits, letter)
% Performs PCM quantization or dequantization on 2D input data
% Inputs:
%   data: 2D input data to be quantized or dequantized
%   n_bits: no of bits represinting samples
%   letter: 'a' to quantize, 's' to dequantize
% Outputs:
%   output_data: Quantized or dequantized 2D data

if letter == 'a' % perform quantization
    % find the maximum and minimum values in the input data
    max_val = max(data(:));
    min_val = min(data(:));
	n_levels = 2^n_bits;
    % calculate the step size (quantization interval)
    step_size = (max_val - min_val) / (n_levels - 1);	
    % apply quantization to each element of the data
    output_data = round((data - min_val) / step_size) * step_size + min_val;
    
elseif letter == 's' % perform dequantization
    % find the maximum and minimum values in the input data
    max_val = max(data(:));
    min_val = min(data(:));
	n_levels = 2^n_bits;
    % calculate the step size (quantization interval)
    step_size = (max_val - min_val) / (n_levels - 1); 
    % apply dequantization to each element of the data
    output_data = (data / step_size) * step_size + min_val;
    
else % handle invalid input
    error('Invalid letter input. Please enter ''a'' to quantize or ''s'' to dequantize.');
    
end

end
