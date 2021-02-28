% Plot some 2D signals

addpath(genpath('..\..\MATLAB\'));

%% Rect

[x,y] = meshgrid( -1:.05:1 );

g = double( abs(x) < .5 & abs(y) < .5 );


figure
mesh( x, y, g  ) % note the use of d here
xlabel('x (meters)');
ylabel('y (meters)');
zlabel('rect(x,y)');
title('2D rect function')

%% 1D Sinc

x = linspace(-5,5,1000);

y = sinc(x);

figure
plot(x,y, 'b-')

xlabel('x (meters)');
ylabel('sinc(x)');
title('Sinc function')
grid


%% 2D sinc

[x,y] = meshgrid( linspace(-4,4,100) );
z = sinc(x).*sinc(y);

figure
mesh(x,y,z)

xlabel('x (meters)');
ylabel('y (meters)');
zlabel('sinc(x,y)');
title('2D sinc function')

%% Circ

[x,y] = meshgrid( linspace(-1,1,100) );
z = double( sqrt( x.^2 + y.^2 ) < .5 );

figure
mesh(x,y,z)

xlabel('x (meters)');
ylabel('y (meters)');
zlabel('circ(x,y)');
title('2D circ function')


%% Cosine

[x,y] = meshgrid( linspace(-1,1,100) );

u0=1;
v0=2;

z = cos( 2*pi*(u0*x + v0*y));

figure
mesh(x,y,z)

xlabel('x (meters)');
ylabel('y (meters)');
zlabel('f(x,y)');
title('2D cosine')


%% Cosine + spectrum

N = 256;
d = .01; % meters

[w1,w2,f1,f2,u,v,x,y] = fftshift_samples2d( N, d );

[X,Y]=meshgrid(x,y);

u0=1;
v0=2;
z = cos( 2*pi*(u0*X + v0*Y));


im(z,1,0,2,x,y)
axis xy
xlabel('x (meters)');
ylabel('y (meters)');
zlabel('f(x,y)');
title('2D cosine')

  
Z = fftshift(fft2(ifftshift(z)));
   

im( abs(Z) == max(abs(Z(:))) ,1,0,2,u,v)
axis xy
xlabel('u (cycles/meter)');
ylabel('v (cycles/meter)');
zlabel('|G(u,v)|');
title('CSFT of cosine')
axis([-10,10,-10,10])



u0=-5;
v0=8;
z = cos( 2*pi*(u0*X + v0*Y));


im(z,1,0,2,x,y)
axis xy
xlabel('x (meters)');
ylabel('y (meters)');
zlabel('f(x,y)');
title('2D cosine')

  
Z = fftshift(fft2(ifftshift(z)));
   

im( abs(Z) == max(abs(Z(:))) ,1,0,2,u,v)
axis xy
xlabel('u (cycles/meter)');
ylabel('v (cycles/meter)');
zlabel('|G(u,v)|');
title('CSFT of cosine')
axis([-10,10,-10,10])


%% Rect - Sinc pair


[x,y] = meshgrid( -1:.05:1 );

g = double( abs(x) < .5 & abs(y) < .5 );


figure
mesh( x, y, g  ) % note the use of d here
xlabel('x (m)');
ylabel('y (m)');
zlabel('rect(x,y)');
title('2D rect function')


[x,y] = meshgrid( linspace(-4,4,100) );
z = sinc(x).*sinc(y);

figure
mesh(x,y,z)

xlabel('u (cyc/m)');
ylabel('v (cyc/m)');
zlabel('sinc(u,v)');
title('CSFT')


%% circ - jinc pair

[x,y] = meshgrid( linspace(-1,1,100) );
z = double( sqrt( x.^2 + y.^2 ) < .5 );

figure
mesh(x,y,z)

xlabel('x (meters)');
ylabel('y (meters)');
zlabel('circ(x,y)');
title('2D circ function')


[u,v] = meshgrid( linspace(-4,4,100) );
d = sqrt(u.^2+v.^2);
z = besselj(1, pi*d ) ./ (2*d);

figure
mesh(u,v,z)

xlabel('u (cyc/m)');
ylabel('v (cyc/m)');
zlabel('sinc(u,v)');
title('CSFT')

