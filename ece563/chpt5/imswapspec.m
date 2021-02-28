function [out1,out2]=imswapspec(in1,in2);
%
% [out1,out2]=imswapspec(in1,in2);
%
% Function to use the phase from in1 and the magnitude
% of in2 to create out.  This demonstrates the importance of
% phase in constituting an image.
%
% in1       Image 1
% in2       Image 2 (same size as Image 1)
%
% out1       Output image using phase spectrum from Image 1
%            and magnitude spectrum from Image 2.
% out2       Output image using phase spectrum from Image 1
%            and magnitude spectrum from Image 2.
%
% Author: Dr. Russell Hardie
% University of Dayton
% 2/17/02, 1/26/2010
% 2/8/21 uses im() instead of old custom imstd()


%% Compute the FFTs

% Image 1
X1=fft2(in1);
MX1=abs(X1);
PX1=angle(X1);

% Image 2
X2=fft2(in2);
MX2=abs(X2);
PX2=angle(X2);


%% Mix the magnitudes and phases

% Magnitude from 2, phase from 1
OUT1=MX2.*exp(1j*PX1);
out1=real(ifft2(OUT1));

% Magnitude from 1, phase from 2
OUT2=MX1.*exp(1j*PX2);
out2=real(ifft2(OUT2));


%% Display images

figure
subplot(221)
im(in1,0)
title('Image 1');

subplot(222)
im(in2,0);
title('Image 2');

subplot(223)
im(out1,0);
title('Phase Spec. Image 1 + Magnitude Spec. Image 2');

subplot(224)
im(out2,0);
title('Phase Spec. Image 2 + Magnitude Spec. Image 1');
