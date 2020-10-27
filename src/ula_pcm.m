function [a_quan]=ula_pcm(a,n,u)
%ULA_PCM 	u-law PCM encoding of a sequence
%       	[A_QUAN]=MULA_PCM(X,N,U).
%       	X=input sequence.
%       	n=number of quantization levels (even).     	
%		a_quan=quantized output before encoding.
%       U the parameter of the u-law

% todo: 
a_max = max(abs(a)); % 找到采样点的最大值
a_quan = a ./ a_max; % 将采样点映射到(-1, 1)
for i = -1 : 2 / n : 1 % 将(-1, 1)分成n段
    %非均匀量化需要将信号非线性放大
    a_quan_seg = a_quan(a_quan >= inv_ulaw(i, u) & a_quan < inv_ulaw((i + 2 / n),u)); % 获取在(i, i + 2 / n)范围内的采样点
    a_quan(a_quan >= inv_ulaw(i, u) & a_quan < inv_ulaw((i + 2 / n),u)) = (max(a_quan_seg) + min(a_quan_seg)) / 2; % 将这些采样点设为（最大值 + 最小值） / 2
end
end