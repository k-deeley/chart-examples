function varargout = plotkids( graphicsObject, namedArgs )
%PLOTKIDS Visualize the graphics hierarchy under the given parent
%graphics object. If "ShowHiddenHandles" is true, then the hierarchy also
%includes children with their HandleVisibility set to "off".

% Copyright 2026 The MathWorks, Inc.

arguments ( Input )
    graphicsObject(1, 1) {mustBeValidGraphics}
    namedArgs.?GraphicsHierarchyChart
end % arguments ( Input )

% Validate the number of outputs.
nargoutchk( 0, 1 )

% Auto-parent if needed.
if ~isfield( namedArgs, "Parent" )
    namedArgs.Parent = figure();
end % if

% Create the chart.
namedArgs = namedargs2cell( namedArgs );
GHC = GraphicsHierarchyChart( "RootObject", graphicsObject, namedArgs{:} );

% Return the chart if required.
if nargout == 1
    varargout{1} = GHC;
end % if

end % plotKids

function mustBeValidGraphics( gobj )
%MUSTBEVALIDGRAPHICS Validate that the input is a valid graphics object.

assert( isgraphics( gobj ) && isvalid( gobj ), ...
    "GraphicsHierarchyChart:InvalidGraphicsObject", ...
    "The input must be a valid graphics object." )

end % mustBeValidGraphics
