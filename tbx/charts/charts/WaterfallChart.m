classdef WaterfallChart < Chart
    %WATERFALLCHART Cumulative bar chart visualizing the evolution of an
    %initial value.

    % Copyright 2025 The MathWorks, Inc.

    properties
        % Bar edge alpha.
        BarEdgeAlpha(1, 1) double {mustBeInRange( BarEdgeAlpha, 0, 1 )} = 1
        % Bar edge color.
        BarEdgeColor {validatecolor} = [0.5, 0.5, 0.5]
        % Bar face alpha.
        BarFaceAlpha(1, 1) double {mustBeInRange( BarFaceAlpha, 0, 1 )} = 1
        % Bar line width.
        BarLineWidth(1, 1) double {mustBePositive, mustBeFinite} = 1
        % Bar line style.
        BarLineStyle(1, 1) string {mustBeLineStyle} = "-"
        % Bar visibility.
        BarVisible(1, 1) matlab.lang.OnOffSwitchState = "on"
        % Bar label format.
        BarLabelFormat(1, 1) string = "%g"
        % Bar label font angle.
        BarLabelFontAngle(1, 1) string {mustBeFontAngle} = "normal"
        % Bar label font color.
        BarLabelFontColor {validatecolor} = [0.5, 0.5, 0.5]
        % Bar label font name.
        BarLabelFontName(1, 1) string = "Helvetica"
        % Bar label font size.
        BarLabelFontSize(1, 1) double {mustBePositive, mustBeFinite} = 10
        % Bar label font weight.
        BarLabelFontWeight(1, 1) string {mustBeFontWeight} = "normal"
        % Bar label visibility.
        BarLabelVisible(1, 1) matlab.lang.OnOffSwitchState = "on"
        % Base line color.
        BaseLineColor {validatecolor} = [0.5, 0.5, 0.5]
        % Base line style.
        BaseLineStyle(1, 1) string {mustBeLineStyle} = "-"
        % Base line width.
        BaseLineWidth(1, 1) double {mustBePositive, mustBeFinite} = 1
        % Base line visibility.
        BaseLineVisible(1, 1) matlab.lang.OnOffSwitchState = "on"
        % Connecting line color.
        ConnectingLineColor {validatecolor} = [0.5, 0.5, 0.5]
        % Connecting line style.
        ConnectingLineStyle(1, 1) string {mustBeLineStyle} = ":"
        % Connecting line width.
        ConnectingLineWidth(1, 1) double {mustBePositive, mustBeFinite} = 1
        % Connecting line visibility.
        ConnectingLineVisible(1, 1) matlab.lang.OnOffSwitchState = "on"
        % Target line color.
        TargetLineColor {validatecolor} = [0.5, 0.5, 0.5]
        % Target line style.
        TargetLineStyle(1, 1) string {mustBeLineStyle} = "-"
        % Target line with.
        TargetLineWidth(1, 1) double {mustBePositive, mustBeFinite} = 1
        % Target line visibility.
        TargetLineVisible(1, 1) matlab.lang.OnOffSwitchState = "off"
        % Target line value.
        TargetLineValue(1, 1) double {mustBeReal, mustBeFinite} = 0
        % Target line label.
        TargetLineLabel(1, 1) string = ""
        % Total bar edge alpha.
        TotalBarEdgeAlpha(1, 1) double ...
            {mustBeInRange( TotalBarEdgeAlpha, 0, 1 )} = 1
        % Total bar edge color.
        TotalBarEdgeColor {validatecolor} = [0.5, 0.5, 0.5]
        % Total bar face alpha.
        TotalBarFaceAlpha(1, 1) double ...
            {mustBeInRange( TotalBarFaceAlpha, 0, 1 )} = 1
        % Total bar face color.
        TotalBarFaceColor = [0, 0.4470, 0.7410]
        % Total bar line width.
        TotalBarLineWidth(1, 1) double {mustBePositive, mustBeFinite} = 1
        % Total bar line style.
        TotalBarLineStyle(1, 1) string {mustBeLineStyle} = "-"
        % Total bar visibility.
        TotalBarVisible(1, 1) matlab.lang.OnOffSwitchState = "on"
    end % properties  

    properties ( Dependent )
        % Chart data.
        Data(:, 1) double {mustBeReal, mustBeFinite}
        % Global line width.
        LineWidth(1, 1) double {mustBePositive, mustBeFinite}
        % Array of face colors, one per patch.
        BarFaceColor
        % Bar width.
        BarWidth(1, 1) double {mustBeInRange( BarWidth, 0, 1 )}
    end % properties ( Dependent )

    properties ( Access = private )
        % Chart axes.
        Axes(:, 1) matlab.graphics.axis.Axes {mustBeScalarOrEmpty}
        % Patch object for the bars corresponding to the data elements.
        Patch(:, 1) matlab.graphics.primitive.Patch {mustBeScalarOrEmpty}
        % Bar for the total.
        Bar(:, 1) matlab.graphics.chart.primitive.Bar {mustBeScalarOrEmpty}
        % Line plot for the connecting lines.
        Line(:, 1) matlab.graphics.primitive.Line {mustBeScalarOrEmpty}
        % Text labels.
        BarLabels(:, 1) matlab.graphics.primitive.Text
        % Base line at y = 0.
        BaseLine(:, 1) matlab.graphics.chart.decoration.ConstantLine ...
            {mustBeScalarOrEmpty}
        % Target line.
        TargetLine(:, 1) matlab.graphics.chart.decoration.ConstantLine ...
            {mustBeScalarOrEmpty}
    end % properties ( Access = private )

    properties ( Access = private )
        % Internal storage for Data.
        Data_(:, 1) double {mustBeReal, mustBeFinite} = ...
            double.empty( 0, 1 )
        % Internal storage for BarFaceColor.
        BarFaceColor_(:, 3) double {mustBeInRange( ...
            BarFaceColor_, 0, 1 )} = double.empty( 0, 3 )
        % Internal storage for BarWidth.
        BarWidth_(1, 1) double {mustBeInRange( BarWidth_, 0, 1 )} = 0.5
        % Logical flag specifying whether a full update is needed.
        ComputationRequired(1, 1) logical = false
    end % properties ( Access = private )

    properties ( Constant, Hidden )
        % Product dependencies.
        Dependencies(1, :) string = "MATLAB"
        % Description.
        ShortDescription(1, 1) string = "Cumulative bar chart " + ...
            "visualizing the evolution of an initial value"
    end % properties ( Constant, Hidden )

    methods

        function obj = WaterfallChart( namedArgs )
            %WATERFALLCHART Construct a WaterfallChart, given optional
            %name-value arguments.

            arguments ( Input )
                namedArgs.?WaterfallChart
            end % arguments ( Input )            

            % Set any user-defined properties.
            set( obj, namedArgs )

        end % constructor

        function varargout = xlabel( obj, varargin )

            [varargout{1:nargout}] = xlabel( obj.Axes, varargin{:} );

        end % xlabel

        function varargout = ylabel( obj, varargin )

            [varargout{1:nargout}] = ylabel( obj.Axes, varargin{:} );

        end % ylabel

        function varargout = title( obj, varargin )

            [varargout{1:nargout}] = title( obj.Axes, varargin{:} );

        end % title

        function varargout = subtitle( obj, varargin )

            [varargout{1:nargout}] = subtitle( obj.Axes, varargin{:} );

        end % subtitle

        function varargout = xticks( obj, varargin )

            [varargout{1:nargout}] = xticks( obj.Axes, varargin{:} );

        end % xticks

        function varargout = xticklabels( obj, varargin )

            [varargout{1:nargout}] = xticklabels( obj.Axes, varargin{:} );

        end % xticklabels

        function varargout = yticks( obj, varargin )

            [varargout{1:nargout}] = yticks( obj.Axes, varargin{:} );

        end % yticks

        function varargout = yticklabels( obj, varargin )

            [varargout{1:nargout}] = yticklabels( obj.Axes, varargin{:} );

        end % yticklabels

        function varargout = xlim( obj, varargin )

            [varargout{1:nargout}] = xlim( obj.Axes, varargin{:} );

        end % xlim

        function varargout = ylim( obj, varargin )

            [varargout{1:nargout}] = ylim( obj.Axes, varargin{:} );

        end % ylim

        function grid( obj, varargin )

            grid( obj.Axes, varargin{:} )

        end % grid

        function box( obj, varargin )

            box( obj.Axes, varargin{:} )

        end % box

        function varargout = axis( obj, varargin )

            [varargout{1:nargout}] = axis( obj.Axes, varargin{:} );

        end % axis

        function value = get.BarFaceColor( obj )

            value = squeeze( obj.Patch.CData );

        end % get.BarFaceColor

        function set.BarFaceColor( obj, value )

            % Validate the input.
            value = validatecolor( value, "multiple" );
            nc = height( value );
            ny = numel( obj.Data );

            if nc == 1
                value = repmat( value, ny, 1 );
            else
                assert( nc == ny, "WaterfallChart:IncorrectNumColors", ...
                    "The number of colors must match the length of " + ...
                    "the waterfall chart's y-data." )
            end % if

            % Mark the chart for an update.
            obj.ComputationRequired = true;

            % Store the new colors.
            obj.BarFaceColor_ = value;

        end % set.BarFaceColor

        function set.TotalBarFaceColor( obj, value )

            if ~isequal( value, "none" )
                value = validatecolor( value );
            end % if

            obj.TotalBarFaceColor = value;

        end % set.TotalBarFaceColor

        function value = get.Data( obj )

            value = obj.Data_;

        end % get.Data

        function set.Data( obj, value )

            obj.ComputationRequired = true;
            obj.Data_ = value;

        end % set.Data

        function value = get.LineWidth( obj )

            value = obj.BarLineWidth;

        end % get.LineWidth

        function set.LineWidth( obj, value )

            set( obj, "BarLineWidth", value, ...
                "BaseLineWidth", value, ...
                "TargetLineWidth", value, ...
                "TotalBarLineWidth", value, ...
                "ConnectingLineWidth", value )

        end % set.LineWidth

        function value = get.BarWidth( obj )

            value = obj.BarWidth_;

        end % get.BarWidth

        function set.BarWidth( obj, value )

            obj.ComputationRequired = true;
            obj.BarWidth_ = value;

        end % set.BarWidth

    end % methods

    methods ( Access = protected )

        function setup( obj )
            %SETUP Initialize the chart's graphics.

            obj.Axes = axes( "Parent", obj.getLayout(), ...
                "NextPlot", "add" );
            obj.Patch = patch( "Parent", obj.Axes, ...
                "XData", NaN, ...
                "YData", NaN, ...
                "FaceColor", "flat" );
            obj.Line = line( "Parent", obj.Axes, ...
                "XData", NaN, ...
                "YData", NaN, ...
                "LineStyle", ":", ...
                "LineWidth", 2 );
            obj.BaseLine = yline( obj.Axes, 0 );
            obj.TargetLine = yline( obj.Axes, NaN, "Visible", "off" );
            obj.Bar = bar( obj.Axes, NaN, NaN );

        end % setup

        function update( obj )
            %UPDATE Update the chart's graphics.

            if obj.ComputationRequired

                % Write down the length of the current data vector and the
                % previous number of colors.
                y = obj.Data;
                ny = numel( y );
                np = height( obj.BarFaceColor_ );

                % Handle the special case when the length is zero.
                if ny == 0
                    set( obj.Patch, "XData", NaN, ...
                        "YData", NaN, ...
                        "CData", NaN )
                    set( obj.Line, "XData", NaN, "YData", NaN )
                    delete( obj.BarLabels )
                    obj.BarLabels = text( "Parent", obj.Axes, ...
                        "Position", [NaN, NaN, 0], ...
                        "HorizontalAlignment", "center", ...
                        "VerticalAlignment", "bottom", ...
                        "String", "" );
                    set( obj.Axes, "XTick", [], "XLim", [0, 1] )
                    set( obj.Bar, "XData", NaN, "YData", NaN )
                    obj.BarFaceColor_ = double.empty( 0, 3 );
                    return
                end % if

                % If there is at least one data point, compute the new
                % patch and line coordinates.
                hbw = 0.5 * obj.BarWidth;
                y0 = [0; y];
                cy = cumsum( y0 );

                % Patch coordinates. The coordinates of each bar are stored
                % in the columns of the matrices.
                for k = ny : -1 : 1
                    xp(:, k) = [k + hbw; k + hbw; k - hbw; k - hbw];
                    yp(:, k) = [cy(k); cy(k+1); cy(k+1); cy(k)];
                end % for

                % Line coordinates. Each line segment connecting two
                % successive bars is separated in the data vector using
                % NaNs.
                xl = [];
                yl = [];
                for k = 1 : (ny - 1)
                    xl = [xl, k + hbw, k + 1 - hbw, NaN]; %#ok<*AGROW>
                    yl = [yl, cy(k+1), cy(k+1), NaN];
                end % for
                xl = [xl, ny, ny+1];
                yl = [yl, cy(ny+1), cy(ny+1)];

                % Patch face colors. Either truncate or pad depending on
                % the new number of data points.
                if ny < np
                    obj.BarFaceColor_ = obj.BarFaceColor_(1:ny, :);
                else
                    obj.BarFaceColor_(end+(1:ny-np), :) = 0.5;
                end % if
                newCData = reshape( obj.BarFaceColor_, ...
                    [height( obj.BarFaceColor_ ), 1, 3] );

                % Compute the bar label coordinates and evaluate the new
                % text values.
                xt = 1:ny;
                yt = cy(2:ny+1);                
                va = repelem( "bottom", ny, 1 );
                va(y < 0) = "top";

                % Tidy up the previous bar labels.
                delete( obj.BarLabels )
                obj.BarLabels = matlab.graphics.primitive.Text...
                    .empty( 0, 1 );

                % Create the new labels.
                for k = 1 : ny
                    obj.BarLabels(k) = text( "Parent", obj.Axes, ...
                        "Position", [xt(k), yt(k), 0], ...
                        "HorizontalAlignment", "center", ...
                        "VerticalAlignment", va(k), ...
                        "String", "" );
                end % for

                % Update the graphics objects.
                set( obj.Patch, "XData", xp, "YData", yp, ...
                    "CData", newCData )
                set( obj.Line, "XData", xl, "YData", yl )
                set( obj.Axes, "XTick", 1:ny+1, "XLim", [0, ny+2] )
                set( obj.Bar, "XData", ny+1, "YData", cy(end), ...
                    "BarWidth", obj.BarWidth )

                % Reset the flag.
                obj.ComputationRequired = false;

            end % if

            % Update the chart's decorative properties.
            set( obj.Patch, "EdgeAlpha", obj.BarEdgeAlpha, ...
                "EdgeColor", obj.BarEdgeColor, ...
                "FaceAlpha", obj.BarFaceAlpha, ...
                "LineWidth", obj.BarLineWidth, ...
                "LineStyle", obj.BarLineStyle, ...
                "Visible", obj.BarVisible )
            set( obj.Line, "Color", obj.ConnectingLineColor, ...
                "LineStyle", obj.ConnectingLineStyle, ...
                "LineWidth", obj.ConnectingLineWidth, ...
                "Visible", obj.ConnectingLineVisible )
            set( obj.BaseLine, "Color", obj.BaseLineColor, ...
                "LineStyle", obj.BaseLineStyle, ...
                "LineWidth", obj.BaseLineWidth, ...
                "Visible", obj.BaseLineVisible )
            set( obj.TargetLine, "Color", obj.TargetLineColor, ...
                "LineStyle", obj.TargetLineStyle,  ...
                "LineWidth", obj.TargetLineWidth, ...
                "Visible", obj.TargetLineVisible, ...
                "Value", obj.TargetLineValue, ...
                "Label", obj.TargetLineLabel )
            y = obj.Data;
            if obj.BarLabelVisible
                totalBarLabel = sprintf( obj.BarLabelFormat, sum( y ) );
            else
                totalBarLabel = "";
            end % if
            set( obj.Bar, "EdgeAlpha", obj.TotalBarEdgeAlpha, ...
                "EdgeColor", obj.TotalBarEdgeColor, ...
                "FaceAlpha", obj.TotalBarFaceAlpha, ...
                "FaceColor", obj.TotalBarFaceColor, ...
                "LineWidth", obj.TotalBarLineWidth, ...
                "LineStyle", obj.TotalBarLineStyle, ...
                "Visible", obj.TotalBarVisible, ...
                "Labels", totalBarLabel, ...
                "LabelColor", obj.BarLabelFontColor )
            set( obj.BarLabels, "FontAngle", obj.BarLabelFontAngle, ...
                "Color", obj.BarLabelFontColor, ...
                "FontName", obj.BarLabelFontName, ...
                "FontSize", obj.BarLabelFontSize, ...
                "FontWeight", obj.BarLabelFontWeight, ...
                "Visible", obj.BarLabelVisible )

            % Update the text labels used for the bars.            
            for k = 1:numel( obj.BarLabels )
                obj.BarLabels(k).String = ...
                    sprintf( obj.BarLabelFormat, y(k) );    
            end % for

        end % update

    end % methods ( Access = protected )

end % classdef