addpath('..\chp1\')


%% 1D 

h_even = [1/2 1/2];

h_odd = [ 1/4 1/2 1/4 ];

x = [ 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 ];

y_even1 = conv2( padarray(x, [0,1],'symmetric','pre'), h_even, 'valid' );
y_even2 = conv2( padarray(x, [0,1],'symmetric','post'), h_even, 'valid' );
y_odd = conv2( padarray(x, [0,1],'symmetric','both'), h_odd, 'valid' );

figure
subplot(411)
stem(x)
title('Input')
subplot(412)
stem(y_even1)
title('Even Kernel')
subplot(413)
stem(y_even2)
title('Even Kernel')
subplot(414)
stem(y_odd)
title('Odd Kernel')


x = [ 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 ];

y_even1 = conv2( padarray(x, [0,1],'symmetric','pre'), h_even, 'valid' );
y_even2 = conv2( padarray(x, [0,1],'symmetric','post'), h_even, 'valid' );
y_odd = conv2( padarray(x, [0,1],'symmetric','both'), h_odd, 'valid' );

figure
subplot(411)
stem(x)
title('Input')
subplot(412)
stem(y_even1)
title('Even Kernel')
subplot(413)
stem(y_even2)
title('Even Kernel')
subplot(414)
stem(y_odd)
title('Odd Kernel')

%% Phase analysis

% DTFT
w = linspace(-pi,pi,100);
H_even = (1/2)+(1/2)*exp(-j*w);
figure
subplot(211)
plot(w,abs(H_even));
title('Even Kernel Magnitude DTFT')
xlabel('\omega (rads/sample)')
ylabel('|H(\omega)|')
subplot(212)
plot(w,angle(H_even));
title('Even Kernel Phase DTFT')
xlabel('\omega (rads/sample)')
ylabel('\angle H(\omega)')
% Slope is -1/2 (half sample delay, magnitude shows us we also get some  blurring

H_odd = (1/4)*exp(+j*w)+1/2+(1/4)*exp(-j*w);
figure
subplot(211)
plot(w,abs(H_odd));
title('Odd Kernel Magnitude DTFT')
xlabel('\omega (rads/sample)')
ylabel('|H(\omega)|')
subplot(212)
plot(w,angle(H_odd));
title('Odd Kernel Phase DTFT')
xlabel('\omega (rads/sample)')
ylabel('\angle H(\omega)')
% Slope is 0



%% Image

x = double(imread('cameraman.tif'));

h_even = ones(2,2)/4;

h_odd = [ 1/16 1/8 1/16
    1/8  1/4 1/8
    1/16 1/8 1/16];

y_even1 = conv2( padarray(x,[1,1],'symmetric','pre'), h_even, 'valid' );

y_even2 = conv2( padarray(x,[1,1],'symmetric','post'), h_even, 'valid' );

y_odd = conv2( padarray(x,[1,1],'symmetric','both'), h_odd, 'valid' );


im(x)
title('Original')
im(y_even1)
title('Even Kernel')

im(x)
title('Original')
im(y_even2)
title('Even Kernel')

im(x)
title('Original')
im(y_odd)
title('Odd Kernel')



