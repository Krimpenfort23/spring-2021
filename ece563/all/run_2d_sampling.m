addpath(genpath('../../MATLAB'));


%% Continuous image f_c(x,y)=sinc(x,y)

% X,Y grid
x = linspace(-2,2,100);
[xx,yy]=meshgrid( x );

% 2D sinc
 zz = sinc(xx) .* sinc(yy);
 
% Shaded surface plot
figure
surfl(xx,yy,zz);
colormap(gray)
shading interp
xlabel('x (m)')
ylabel('y (m)');
zlabel('f_c(x,y)')
title('f_c(x,y) = sinc(x,y)')
axis tight
view(-35,40)

im(zz,1,0,2,x,x); axis xy
xlabel('x (m)')
ylabel('y (m)');
title('f_c(x,y) = sinc(x,y)')


%% 2D comb function

% Delta X,Y coordinates 
deltax = .25;
xs = [ -2:deltax:2 ];
[ xxs, yys ] = meshgrid( xs );

% Areas
delta = ones(size(xxs));
zer = zeros(size(xxs));

% 3D Quiver plot
figure
quiver3( xxs, yys, zer, zer, zer, delta,  0 , 'g'  )
axis tight
view(-35,40)
xlabel(' x (m) ' )
xlabel(' y (m) ' )
title('Comb Function' )


%% Superimpose the surface and comb

% Shaded surface plot
figure
surfl(xx,yy,zz);
colormap(gray)
shading interp
xlabel('x (m)')
ylabel('y (m)');
zlabel('f_c(x,y)')
title('f_c(x,y) = sinc(x,y)')
axis tight
view(-35,40)

% 3D Quiver plot
hold on
quiver3( xxs, yys, zer, zer, zer, delta,  0 , 'g'  )
axis tight
view(-35,40)


%% Show the comb times the surface


% Shaded surface plot
figure
surfl(xx,yy,zz);
colormap(gray)
shading interp
xlabel('x (m)')
ylabel('y (m)');
alpha(.5)

hold on

zzs = sinc(xxs) .* sinc(yys);
zer = zeros(size(xxs));
quiver3( xxs,yys,zer, zer, zer, zzs,  0 , 'g'  )
view(-35,40)
xlabel(' x (m) ' )
ylabel(' y (m) ' )
zlabel('f_s(x,y)')
title( 'Dirac Sampled' )
axis tight


figure
quiver3( xxs, yys, zer, zer, zer, zzs,  0 , 'g'  )
axis tight
view(-35,40)
xlabel(' x (m) ' )
ylabel(' y (m) ' )
zlabel('f_s(x,y)')
title( 'Dirac Sampled' )


%% Show final discrete-space sequence as stem

figure
stem3( [-8:8], [-8:8], zzs,  'g'  )

view(-35,40)
xlabel(' n_1 (sample)' )
ylabel(' n_2 (sample)' )
zlabel(' f_d(n_1,n_2) ')
title('Discrete Space Sequence' )
axis tight


%% Display samples as an image

im(zzs,1,0,2,[-8:8],[-8:8]); axis xy
xlabel('n_1 (sample)')
ylabel('n_2 (sample)');
title('Discrete Space Sequence' )

