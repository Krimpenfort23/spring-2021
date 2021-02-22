addpath('..\chp1\')
addpath('..\..\Data\')

x=dicomread('00000150.dcm');

air = x < 400;
im(air)

body = x > 500;
im(body)

body = imfill( body, 'holes' );
im(body)

lung = air & body;
im(lung)

lung2 = bwareaopen( lung, 100 );
im(lung2)

lung2 = imfill( lung2, 'holes' );
im(lung2)

body = bwareaopen(body,10000);
im(body)

x(x==-2000)=0;
im(x)
display_masks( cat(3, body,lung2), ['r', 'g'], [2,2])
legend('Body','Lungs')
