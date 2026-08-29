# `SpiderChart` Test Class

Test file: `tSpiderChart.m`.

````text 
classdef tSpiderChart < tChart
    %TSPIDERCHART Tests for the SpiderChart class.
    %
    % See also SpiderChart, tChart


    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

        function tSettingDataUpdatesNodeAndLineCounts( testCase )

            % Set data with four nodes and two lines.
            data = [0.1, 0.2; 0.3, 0.4; 0.5, 0.6; 0.7, 0.8];
            testCase.Chart.Data = data;
            drawnow()

            % Verify public data and derived counts.
            testCase.verifyEqual( testCase.Chart.Data, data, ...
                "Setting 'Data' did not round-trip correctly." )
            testCase.verifyEqual( testCase.Chart.NumNodes, 4, ...
                "Setting 'Data' did not update 'NumNodes'." )
            testCase.verifyEqual( testCase.Chart.NumLines, 2, ...
                "Setting 'Data' did not update 'NumLines'." )

        end % tSettingDataUpdatesNodeAndLineCounts

        function tTargetDataAndLabelTextRoundTrip( testCase )

            % Configure chart data and matching labels.
            testCase.Chart.Data = [0.1; 0.3; 0.5];
            testCase.Chart.TargetData = [0.2; 0.4; 0.6];
            testCase.Chart.LabelText = ["A"; "B"; "C"];
            drawnow()

            % Verify public dependent properties.
            testCase.verifyThat( testCase.Chart.TargetData, ...
                IsEqualVector( [0.2; 0.4; 0.6] ), ...
                "Setting 'TargetData' did not round-trip." )
            testCase.verifyThat( testCase.Chart.LabelText, ...
                IsEquivalentText( ["A"; "B"; "C"] ), ...
                "Setting 'LabelText' did not round-trip." )

        end % tTargetDataAndLabelTextRoundTrip

        function tInvalidDependentLengthsThrowExceptions( testCase )

            % Configure chart data with three nodes and two lines.
            testCase.Chart.Data = [0.1, 0.2; 0.3, 0.4; 0.5, 0.6];
            drawnow()

            % Verify size validation.
            f = @() set( testCase.Chart, "TargetData", [0.1; 0.2] );
            testCase.verifyError( f, ...
                "SpiderChart:InvalidTargetDataLength", ...
                "Setting 'TargetData' with the wrong number of " + ...
                "values did not throw the expected exception." )
            f = @() set( testCase.Chart, "LabelText", ["A"; "B"] );
            testCase.verifyError( f, "Spider:InvalidLabelTextLength", ...
                "Setting 'LabelText' with the wrong number of " + ...
                "values did not throw the expected exception." )
            f = @() set( testCase.Chart, "LineColors", [1, 0, 0] );
            testCase.verifyError( f, "Spider:ColorMatrixSizeMismatch", ...
                "Setting 'LineColors' with the wrong number of " + ...
                "rows did not throw the expected exception." )

        end % tInvalidDependentLengthsThrowExceptions

        function tStylePropertiesRoundTrip( testCase )

            % Configure data and set style properties.
            testCase.Chart.Data = [0.1; 0.3; 0.5];
            testCase.Chart.WebLineWidth = 2;
            testCase.Chart.LineWidth = 3;
            testCase.Chart.TargetVisible = "on";
            testCase.Chart.TargetColor = [1, 0, 0];
            testCase.Chart.TargetLineWidth = 4;
            testCase.Chart.TargetLineStyle = "--";
            testCase.Chart.LabelFontSize = 12;
            testCase.Chart.LabelFontAngle = "italic";
            testCase.Chart.LabelFontWeight = "bold";
            drawnow()

            % Verify public style state.
            testCase.verifyEqual( testCase.Chart.WebLineWidth, 2, ...
                "Setting 'WebLineWidth' did not round-trip." )
            testCase.verifyEqual( testCase.Chart.LineWidth, 3, ...
                "Setting 'LineWidth' did not round-trip." )
            actual = testCase.Chart.TargetVisible;
            expected = matlab.lang.OnOffSwitchState( "on" );
            testCase.verifyEqual( actual, expected, ...
                "Setting 'TargetVisible' did not round-trip." )
            actual = testCase.Chart.TargetColor;
            testCase.verifyEqual( actual, [1, 0, 0], ...
                "Setting 'TargetColor' did not round-trip." )
            testCase.verifyEqual( testCase.Chart.TargetLineWidth, 4, ...
                "Setting 'TargetLineWidth' did not round-trip." )
            testCase.verifyThat( testCase.Chart.TargetLineStyle, ...
                IsEquivalentText( "--" ), ...
                "Setting 'TargetLineStyle' did not round-trip." )
            testCase.verifyEqual( testCase.Chart.LabelFontSize, 12, ...
                "Setting 'LabelFontSize' did not round-trip." )
            testCase.verifyThat( testCase.Chart.LabelFontAngle, ...
                IsEquivalentText( "italic" ), ...
                "Setting 'LabelFontAngle' did not " + ...
                "round-trip." )
            testCase.verifyThat( testCase.Chart.LabelFontWeight, ...
                IsEquivalentText( "bold" ), ...
                "Setting 'LabelFontWeight' did not " + ...
                "round-trip." )

        end % tStylePropertiesRoundTrip

    end % methods ( Test )

    methods ( Access = protected )

        function configureChartForPublicAPITests( testCase )

            testCase.Chart.Data = [0.1; 0.3; 0.5];
            testCase.Chart.LabelText = ["A"; "B"; "C"];
            drawnow()

        end % configureChartForPublicAPITests

        function propertyNames = propertyAssignmentExclusions( ~ )

            propertyNames = ["Data"; "LabelText"; "LineColors"];

        end % propertyAssignmentExclusions

    end % methods ( Access = protected )

end % classdef

````

## See Also

* [Spider Chart](../landing/SpiderChart.md)
* [Chart Examples](../../ChartExamples.md)

