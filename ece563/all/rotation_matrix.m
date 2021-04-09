function [out,R] = rotation_matrix( in, theta_x, theta_y, theta_z );
%
% [out,R] = rotation_matrix( in, theta_x, theta_y, theta_z );
%
% Applied a 3D rotation matrix to input data.
%
% in = [x,y,z]
% theta_x = angular rotation in radians about x (pitch, x=wing line)
% theta_y = angular rotation in radians about y (roll, y=North)
% theta_z = angular rotation in radians about z (heading)
% out = [x',y',z'];
% R     Rotation matrix applied
%
% Author: Dr. Russell Hardie
% University of Dayton
% 5/2005
%
% COPYRIGHT © 2005 THE UNIVERSITY OF DAYTON.  ALL RIGHTS RESERVED. 

Rx = [1 0 0
      0 cos(theta_x) -sin(theta_x)
      0 sin(theta_x) cos(theta_x) ];
      
Ry = [cos(theta_y) 0 sin(theta_y)
       0 1 0
       -sin(theta_y) 0 cos(theta_y) ];
   
Rz = [cos(theta_z) sin(theta_z) 0
      -sin(theta_z) cos(theta_z) 0
      0 0 1];
  
R = Rz*Rx*Ry;
% out = Rz*(Rx*(Ry*in));
out = R*in;