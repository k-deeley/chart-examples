function folder = chartsDocRoot()
%CHARTSDOCROOT Folder containing the Chart Examples documentation
%
% folder = chartsDocRoot() returns the full path to the folder containing
% the Chart Examples documentation.
%
% Example:
% >> folder = chartsDocRoot()
% folder = "C:\MATLAB\Chart_Examples\charts"

% Copyright 2018-2026 The MathWorks, Inc.

arguments ( Output )
    folder(1, 1) string {mustBeFolder}
end % arguments ( Output )

folder = fileparts( mfilename( "fullpath" ) );

end % chartsDocRoot
