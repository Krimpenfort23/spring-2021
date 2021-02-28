addpath(genpath('..\..\MATLAB\'));

% dsft(x,shy,shx,N,cycles_flag);

x = ones(5,5);

dsft(x,0,0,256,0);

dsft(x,3,3,256,0);

dsft(x,3,3,256,1);

dsftl(x,3,3,256,1);