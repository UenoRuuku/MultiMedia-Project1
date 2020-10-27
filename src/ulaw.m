function [z]=ulaw(y,u)
%		u-law nonlinearity for nonuniform PCM
%		X=ULAW(Y,U).
%		Y=input vector.

% todo: 
z=sign(y)*(log(1+u*abs(y))/log(1+u));
end