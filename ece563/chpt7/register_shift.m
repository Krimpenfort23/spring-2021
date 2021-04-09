function S = register_shift(image1, image2, thresh, buff, method)
%
% S = register_shift( image1, image2, thresh, buff, method );
%
% Lucas and Kanade gradient-based image shift estimation.
% ECE563 version
%
% Note: A smoothing prefilter may improve performance.  Multiscale is
% needed for very large shifts.
%
% References:
%
% B. D. Lucas and T. Kanade (1981), An iterative image registration
% technique with an application to stereo vision. Proceedings of Imaging
% Understanding Workshop, pages 121--130
%
% Bruce D. Lucas (1984) Generalized Image Matching by the Method of
% Differences (doctoral dissertation)
%
% REQUIRED INPUTS
%
% image1	Reference image
% image2	Unknown shift image
% thresh	The threshold for the largest shift to accept, suggested=.1
% buff		The border buffer to ignore due to border effects and
%           shift effects, suggested=max expected  shift
%
% OPTIONAL INPUTS
%
% method    Interpolation method ('nea','bil','bic'), default = 'bil'
%
% OUTPUTS
%
% S=[sx,sy]	Output shift vector
% sx		horizontal shift
% sy 		vertical shift
%
% Author: Dr. Russell C. Hardie
%
% Modification History:
% Original code June 1996
% Modified 8/12/04
% Modified for M=zeros, inv(M) out of loop, limit S to +- buff 9/20/07
% Modified comments 3/3/1012


% Default interpolation type
if nargin < 5 || isempty(method)
    method = 'bil';
end

%---------------------------------%
% Estimate the discrete gradients %
%---------------------------------%

xkernel = (1 / 6) * [1, 0, -1; ...
    1, 0, -1; ...
    1, 0, -1];

ykernel = (1 / 6) * [1, 1, 1; ...
    0, 0, 0; ...
    -1, -1, -1];

gx = conv2(image1, xkernel, 'same');
gy = conv2(image1, ykernel, 'same');

%-----------------------------------------------%
% Cut out center because of later shift effects %
%-----------------------------------------------%

% old size
[fully, fullx] = size(gx);

% Crop interior to allow for maximum shift
gx = gx(buff+1:fully-buff, buff+1:fullx-buff);
gy = gy(buff+1:fully-buff, buff+1:fullx-buff);
image1 = image1(buff+1:fully-buff, buff+1:fullx-buff);

% new smaller size
[ydim, xdim] = size(image1);

%-----------------------%
% Generate the M matrix %
%-----------------------%

cross = sum(sum(gx .* gy));
M = [sum(sum(gx.^2)), cross; ...
    cross, sum(sum(gy.^2))];

% If M is not well conditioned, best to just output 0,0 and exit
if cond(M) > 1000
    S = [0; 0];
else
    %---------------------------%
    % Initialize loop constants %
    %---------------------------%

    Minv = inv(M);

    count = 0; % Number of times through loop
    stop = 0; % Loop stop flag

    im2 = image2; % start with the ``warped'' image being the full second image
    S = zeros(2, 1); % set initial shift estimates to zero

    X = [1:fullx]; % samp grid of original data in x
    Y = [1:fully]'; % samp grid of original data in y

    %---------------------------%
    % Begin iterative estimates %
    %---------------------------%

    while stop ~= 1
        count = count + 1;

        % calculate the difference image over the interior region
        gt = im2(buff+1:fully-buff, buff+1:fullx-buff) - image1;

        % Generate the V matrix
        V = [sum(sum(gt .* gx)); ...
            sum(sum(gt .* gy))];

        % Find local shift estimate (Schaum)
        local = Minv * V;

        % Update the global estimate
        S = S + local;

        % See if its time to stop or warp and continue
        if count > 10 || (abs(local(1)) < thresh && abs(local(2)) < thresh)
            stop = 1;
        else % sub-pixelly shift image2 according to latest estimate

            S(S < -buff) = -buff;
            S(S > buff) = buff;

            XI = [1 - S(1):fullx - S(1)];
            YI = [1 - S(2):fully - S(2)]';

            im2 = interp2(X, Y, image2, XI, YI, method);
            % Note that this repositioning puts NaN outside of original
            % grid.  This is why I cut out using buff and only operate on
            % the interior portion (free of NaN).

        end

    end

end
