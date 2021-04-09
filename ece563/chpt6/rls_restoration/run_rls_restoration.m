%% Run regularized least squares for image restoration
%
% Dr. Russell Hardie
% University of Dayton
% ECE 563
% 

%% Load image

f = double(imread('cameraman.tif'));


%% Degrade image

% Define PSF
% psf = zeros(5,5)/25;
% psf(1:4,1:4) = 1/ 16;

psf = fspecial('gaussian',9,2);
% psf = ones(5,5)/25;

% PSF size
[psfy, psfx] = size(psf);
padx = (psfx-1)/2;
pady = (psfy-1)/2;

% Apply blurring and add noise
gobs = conv2( padarray(f,[pady,padx],'both','symmetric'),psf, 'valid' ) ...
    + randn(size(f))*1;

% Display images
im(f);
title('Ideal Image');

im(gobs);
err = dif(f,gobs);
title(sprintf('Blurred Image (MSE=%2.2f)',err.mse));


%% Do RLS restoration

% Run the RLS function
[fest, cost] = rls_restoration(gobs, psf, .001, 100 );

im(fest);
err_rls = dif(f,fest);
title(sprintf('RLS Image (MSE=%2.2f)',err_rls.mse));

% View results
figure
subplot(221)
semilogy(cost); grid
xlabel('Iteration');
ylabel('Cost');
title('Cost Function');
subplot(222)
im(f,0);
title('Ideal')
subplot(223)
im(gobs,0);
title(sprintf('Blurred Image (MSE=%2.2f)',err.mse));
subplot(224)
im(fest,0);
title(sprintf('RLS Image (MSE=%2.2f)',err_rls.mse));

