function figstep
%
% Function to let the user bring each open figure to the foreground in
% order by pressing the space bar
%

num_figs = get(0,'Children');

for k = 1:length(num_figs)
  figure(k)
  pause
end