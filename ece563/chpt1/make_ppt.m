function make_ppt(name,sx_in,sy_in)
%
%  make_ppt(name,sx_in,sy_in)
%
% Turns all open figures into a PowerPoint presentation 'name'
%
% REQUIRED INPUTS
% name  String with Powerpoint file name
%
% OPTIONAL INPUTS
% sx_in     Size in x (inches) default = 11
% sy_in     Size in y (inches) default = 8.5
%
% Author: Dr. Russell Hardie
% University of Dayton
% 6/1/2016


% Default sizes
if nargin < 3
    sx_in = 11;
    sy_in = 8.5;
end


current_path = pwd;

% Start new presentation
isOpen  = exportToPPTX();
if ~isempty(isOpen)
    % If PowerPoint already started, then close first and then open a new one
    exportToPPTX('close');
end

exportToPPTX('new','Dimensions',[sx_in sy_in], ...
    'Title','Example Presentation', ...
    'Author','MatLab', ...
    'Subject','Automatically generated PPTX file', ...
    'Comments','This file has been automatically generated by exportToPPTX');

% Additionally background color for all slides can be set as follows:
% exportToPPTX('new','BackgroundColor',[0.5 0.5 0.5]);

% Get the open figure numbers
temp = findall(0,'type','figure');
fig_numbers = sort( [temp(:).Number] );

% nfigs = get(0,'Children');
for islide = 1 : length(fig_numbers) %  length(nfigs)
    
    slideNum = exportToPPTX('addslide');
    fprintf('Added slide %d\n',slideNum);
    % figure(islide)
    
    figure(fig_numbers(islide))
    drawnow
    figH = gcf;
    exportToPPTX('addpicture',figH);
    %         exportToPPTX('addtext',sprintf('Slide Number %d',slideNum));
    %         exportToPPTX('addnote',sprintf('Notes data: slide number %d',slideNum));
    
end
% close(figH);

% Check current presentation
fileStats   = exportToPPTX('query');

if ~isempty(fileStats)
    fprintf('Presentation size: %f x %f\n',fileStats.dimensions);
    fprintf('Number of slides: %d\n',fileStats.numSlides);
end


% Save presentation and close presentation -- overwrite file if it already exists
% Filename automatically checked for proper extension
newFile = exportToPPTX('saveandclose',[current_path,'\',name]);

% Alternatively you can:
% exportToPPTX('save','example');
% exportToPPTX('close');


