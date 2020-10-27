function x=inv_ulaw(y,u)
%INV_ULAW		the inverse of u-law nonlinearity
%X=INV_ULAW(Y,U)	X=normalized output of the u-law nonlinearity.

% todo: 
% u律的逆运算
x=(exp(1)^(y*log(1+u))-1)/u;
end