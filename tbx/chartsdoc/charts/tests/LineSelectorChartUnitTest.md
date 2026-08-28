# `LineSelectorChart` Test Class

Test file: `tLineSelectorChart.m`.

````text 
classdef tLineSelectorChart < tChart
    %TLINESELECTORCHART Tests for the LineSelectorChart class.
    %
    % See also LineSelectorChart, tChart


    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

        function tSettingXDataResizesYData( testCase )

            % Start with four data points and two traces.
            testCase.Chart.YData = [(1:4).', (4:-1:1).'];
            testCase.Chart.XData = (1:4).';
            drawnow()

            % Shorten XData and verify YData is truncated.
            testCase.Chart.XData = (1:2).';
            drawnow()
            testCase.verifyThat( testCase.Chart.YData(:, 1), ...
                IsEqualVector( [1; 2] ), "Shortening 'XData' " + ...
                "did not truncate 'YData' to the same height." )

        end % tSettingXDataResizesYData

        function tSelectingLineUpdatesLineAppearance( testCase )

            % Set multiple traces.
            testCase.Chart.XData = (1:4).';
            testCase.Chart.YData = [(1:4).', (4:-1:1).'];
            testCase.Chart.SelectedColor = [1, 0, 0];
            testCase.Chart.SelectedLineWidth = 4;
            testCase.Chart.TraceLineWidth = 1;
            drawnow()

            % Select the second trace.
            select( testCase.Chart, 2 )
            drawnow()
            testCase.verifyEqual( testCase.Chart.Lines(2).Color, ...
                [1, 0, 0], "Calling select() did not update the " + ...
                "selected line color." )
            testCase.verifyEqual( testCase.Chart.Lines(2).LineWidth, ...
                4, "Calling select() did not update the selected " + ...
                "line width." )

            % Deselect all traces.
            deselect( testCase.Chart )
            drawnow()
            actual = [testCase.Chart.Lines.LineWidth];
            testCase.verifyEqual( actual, [1, 1], ...
                "Calling deselect() did not restore trace widths." )

        end % tSelectingLineUpdatesLineAppearance

        function tInvalidLineSelectionThrowsException( testCase )

            % Set a single trace and select an out-of-range line.
            testCase.Chart.XData = (1:4).';
            testCase.Chart.YData = (1:4).';
            drawnow()

            f = @() select( testCase.Chart, 2 );
            testCase.verifyError( f, ...
                "LineSelectorChart:InvalidLineIndex", ...
                "Selecting an out-of-range line did not throw the " + ...
                "expected exception." )

        end % tInvalidLineSelectionThrowsException

    end % methods ( Test )

    methods ( Access = protected )

        function configureChartForPublicAPITests( testCase )

            testCase.Chart.XData = (1:4).';
            testCase.Chart.YData = [(1:4).', (4:-1:1).'];
            drawnow()

        end % configureChartForPublicAPITests

        function samples = chartSpecificPublicMethodCallSamples( ...
                testCase )

            samples = [
                testCase.publicMethodCallSample( "deselect" )
                testCase.publicMethodCallSample( "select", {1} ) ];

        end % chartSpecificPublicMethodCallSamples

    end % methods ( Access = protected )

end % classdef

````

## See Also

* [Line Selector Chart](../landing/LineSelectorChart.md)
* [Chart Reference](../ChartsIndex.md)

