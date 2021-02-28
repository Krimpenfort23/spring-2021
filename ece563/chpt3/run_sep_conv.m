f = double(imread('cameraman.tif'));
h = fspecial('gaussian',101,5);

mesh(h)
tic
g = conv2( padarray( f, (size(h)-1)/2, 'symmetric', 'both' ), h, 'valid');
toc
im(f)
im(g)


hy = fspecial('gaussian',[101,1],5);
hx = hy';


tic
gx = conv2( padarray( f, (size(hx)-1)/2, 'symmetric', 'both' ), hx, 'valid');
g2 = conv2( padarray( gx, (size(hy)-1)/2, 'symmetric', 'both' ), hy, 'valid');
toc

dif( g, g2)


% larger image gives more dramatic improvement in time