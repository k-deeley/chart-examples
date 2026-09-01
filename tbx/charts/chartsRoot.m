function folder = chartsRoot()
%CHARTSROOT Folder containing the Chart Examples toolbox code
%
% folder = chartsRoot() returns the full path to the folder containing
% the Chart Examples toolbox code.
%
% Example:
% >> folder = chartsRoot()
% folder = "C:\MATLAB\Chart_Examples\charts"

% Copyright 2018-2026 The MathWorks, Inc.

arguments ( Output )
    folder(1, 1) string {mustBeFolder}
end % arguments ( Output )

folder = fileparts( mfilename( "fullpath" ) );

end % chartsRoot
