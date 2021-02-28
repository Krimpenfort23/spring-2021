function c=clip(c,minn,maxx) 
%
% function c=clip(c,minn,maxx) 
%
% Clipping function.  Takes any c (scalar, vector or matrix)
% and clips each value with the limits of minn and maxx.
%
% c		Input scalar, vector or matrix.
%
% minn		Minimum value of C
% maxx		Maximum value of C
%
% Author: Dr. Russell C. Hardie  
% University of Dayton
%
% COPYRIGHT © RUSSELL C. HARDIE.  ALL RIGHTS RESERVED. 

c(c<minn)=minn;
c(c>maxx)=maxx;