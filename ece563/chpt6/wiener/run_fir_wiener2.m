%% Demonstrate the FIR Wiener filter
%
% Dr. Russell Hardie
% University of Dayton
% ECE 563
% 

%% Degrade Image

cl

% Load image
d = double( imread('cameraman.tif') );
[sy,sx] = size(d);

% Degradation impulse response
h = ones(3,3)/9;
[hsy,hsx] = size(h);
padx = (hsx-1)/2;
pady = (hsy-1)/2;
x = conv2( padarray( d, [pady,padx],'symmetric','both' ), h, 'valid' );

% Display desired image
im(d);
title('Desired')

% Display observed (degraded) image
im(x);
err_deg = dif(d,x);
title(sprintf('Observed (MSE=%2.2f)',err_deg.mse))

% Frequency response of blur
H = fft2(h,sy,sx);
[~, ~, f1, f2] = fftshift_samples2d( [sx, sy] );
im(abs(fftshift(H)), 1, 1, 2, f1, f2);
title('Blur Magnitude Freq Response');


%% FIR Wiener Filter (Test on Train)

% Extract local windows with im2col
ws = 15;
X = im2col(x,[ws,ws], 'sliding');
num_cols = size(X,2);

% Estimate correlation matrix (R) (unbiased) direct
R = (1/(num_cols-1))*(X*X');
im(R);
title('Correlation Matrix')

% Estimate correlation matrix (R) from covarinance matrix (C)
% C = cov(X');
% mu = mean(X');
% R = C + mu'*mu;
% im(R)

% Estimate cross-correlation vector (p)
des_pad = (ws-1)/2;
desired = d( des_pad+1:end - des_pad, des_pad+1:end - des_pad );
p = mean( repmat( desired(:), 1, ws*ws ).*X' )';

% FIR Wiener filter weights
w = R\p; % w=inv(R)*p
w = reshape(w, ws, ws );

im(w);
title('FIR Wiener Weights')

figure
mesh(w);
title('FIR Wiener Weights')

% Process degraded image
out = conv2(  padarray( x, [des_pad,des_pad],'symmetric','both' ), w, 'valid' );
im(out);
err_wiener = dif(d,out);
title(sprintf('FIR Filtered Image (MSE=%2.2f)',err_wiener.mse))


%% Use Different Training Image

% In practice one would estimate R,p from another statistically
% representative image - obviously not the image youy want to restores
% because you need the desired version of the image for p.

% Load second image for training
d2 = double( imread('pout.tif') );
[sy,sx] = size(d2);

% Degrade the training image
x2 = conv2( padarray( d2, [pady,padx],'symmetric','both' ), h, 'valid' );

% Extract local windows
ws = 15;
X2 = im2col(x2,[ws,ws],'sliding');
num_cols2 = size(X2,2);

% Estimate R
C2 = cov(X2');
mu2 = mean(X2');
R2 = C2 + mu2'*mu2;

% Estimate p
desired2 = d2( des_pad+1:end - des_pad, des_pad+1:end - des_pad );
p2 = mean( repmat( desired2(:), 1, ws*ws ).*X2' )';

% FIR Wiener weights
w2 = R2\p2; 
w2 = reshape(w2, ws, ws );

% Display weights
figure
subplot(121)
im(w2,0);
title('FIR Wiener Weights (Pout)')
subplot(122)
im(w,0);
title('FIR Wiener Weights (Cameraman)')

% Process degraded image
out2 = conv2(  padarray( x, [des_pad,des_pad],'symmetric','both' ), w2, 'valid' );

% Display processed cameraman trained on pout
im(out2);
err_wiener_pout = dif(d,out2);
title(sprintf('FIR Wiener (Pout) (MSE=%2.2f)', err_wiener_pout.mse))

% Display processed cameraman trained on cameraman
im(out);
err_wiener_cameraman = dif(d,out);
title(sprintf('FIR Wiener (cameraman) (MSE=%2.2f)', err_wiener_cameraman.mse))


%% Noise reduction applictaion with NO desired image

% Noise realization 1
x1 = d + randn(size(d))*20;

% Noise realization 2
x2 = d + randn(size(d))*20;

im(x1);
title('Noisy Image 1');
err1 = dif(d,x1);
title(sprintf('Noisy Image 1 (MSE=%2.2f)', err1.mse))

im(x2);
err2 = dif(d,x2);
title(sprintf('Noisy Image 2 (MSE=%2.2f)', err2.mse))

% Extract local windows
ws = 15;
X = im2col(x1,[ws,ws],'sliding');
num_cols = size(X,2);

% Estimate correlation matrix (R)
C = cov(X');
mu = mean(X');
R = C + mu'*mu;

% Estimate cross-correlation (p)
des_pad = (ws-1)/2;
desired = x2( des_pad+1:end - des_pad, des_pad+1:end - des_pad );
p = mean( repmat( desired(:), 1, ws*ws ).*X' )';

% FIR Filter W=weights
w = R\p; % w=inv(R)*p
w = reshape(w, ws, ws );

im(w);
title('FIR Wiener Weights')

figure
mesh(w);
title('FIR Wiener Weights')

% Apply FIR filter to x1
out = conv2(  padarray( x1, [des_pad,des_pad],'symmetric','both' ), w, 'valid' );

% Display output with MSE
im(out);
err_out = dif(d,out);
title(sprintf('FIR Filtered Image (MSE=%2.2f)', err_out.mse))

