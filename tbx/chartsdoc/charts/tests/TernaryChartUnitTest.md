# `TernaryChart` Test Class

Test file: `tTernaryChart.m`.

````text 
classdef tTernaryChart < tChart
    %TTERNARYCHART Tests for the TernaryChart class.
    %
    % See also TernaryChart, tChart


    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

        function tSettingDataRoundTrips( testCase )

            % Set ternary data.
            expected = testCase.ternaryData();
            testCase.Chart.Data = expected;
            drawnow()

            % Verify the data table is stored.
            testCase.verifyEqual( testCase.Chart.Data, expected, ...
                "Setting 'Data' did not round-trip correctly." )

        end % tSettingDataRoundTrips

        function tSwapDataReordersVariables( testCase )

            % Set data and swap the first two inputs.
            testCase.Chart.Data = testCase.ternaryData();
            swapdata( testCase.Chart, 1, 2 )
            drawnow()

            % Verify the table variables were swapped.
            variableNames = testCase.Chart.Data.Properties.VariableNames;
            actual = variableNames(1:2);
            testCase.verifyThat( actual, ...
                IsEquivalentText( ["B", "A"] ), ...
                "Calling swapdata() did not swap the specified " + ...
                "table variables." )

        end % tSwapDataReordersVariables

        function tRotateUpdatesDirection( testCase )

            % Set data and rotate the chart.
            testCase.Chart.Data = testCase.ternaryData();
            rotate( testCase.Chart, "clockwise" )
            drawnow()

            % Verify the public direction state.
            actual = testCase.Chart.Direction;
            testCase.verifyThat( actual, ...
                IsEquivalentText( "clockwise" ), ...
                "Calling rotate() did not update 'Direction'." )

        end % tRotateUpdatesDirection

        function tSurfaceAndScatterPropertiesRoundTrip( testCase )

            % Set visual properties.
            testCase.Chart.Data = testCase.ternaryData();
            testCase.Chart.Marker = "x";
            testCase.Chart.MarkerSize = 8;
            testCase.Chart.MarkerEdgeColor = [1, 0, 0];
            testCase.Chart.MarkerFaceColor = [0, 0, 1];
            testCase.Chart.SurfaceType = "mesh";
            testCase.Chart.FaceAlpha = 0.5;
            testCase.Chart.EdgeAlpha = 0.25;
            testCase.Chart.LineStyle = "--";
            testCase.Chart.LineWidth = 2;
            testCase.Chart.InterpolationMethod = "linear";
            drawnow()

            % Verify public style state.
            testCase.verifyThat( testCase.Chart.Marker, ...
                IsEquivalentText( "x" ), ...
                "Setting 'Marker' did not round-trip." )
            testCase.verifyEqual( testCase.Chart.MarkerSize, 8, ...
                "Setting 'MarkerSize' did not round-trip." )
            testCase.verifyEqual( testCase.Chart.MarkerEdgeColor, ...
                [1, 0, 0], "Setting 'MarkerEdgeColor' did not " + ...
                "round-trip." )
            testCase.verifyEqual( testCase.Chart.MarkerFaceColor, ...
                [0, 0, 1], "Setting 'MarkerFaceColor' did not " + ...
                "round-trip." )
            testCase.verifyEqual( testCase.Chart.FaceAlpha, 0.5, ...
                "Setting 'FaceAlpha' did not round-trip." )
            testCase.verifyEqual( testCase.Chart.EdgeAlpha, 0.25, ...
                "Setting 'EdgeAlpha' did not round-trip." )
            testCase.verifyThat( testCase.Chart.LineStyle, ...
                IsEquivalentText( "--" ), ...
                "Setting 'LineStyle' did not round-trip." )
            testCase.verifyEqual( testCase.Chart.LineWidth, 2, ...
                "Setting 'LineWidth' did not round-trip." )
            testCase.verifyThat( testCase.Chart.SurfaceType, ...
                IsEquivalentText( "mesh" ), ...
                "Setting 'SurfaceType' did not round-trip." )
            testCase.verifyThat( testCase.Chart.InterpolationMethod, ...
                IsEquivalentText( "linear" ), ...
                "Setting 'InterpolationMethod' did not " + ...
                "round-trip." )

        end % tSurfaceAndScatterPropertiesRoundTrip

    end % methods ( Test )

    methods ( Access = protected )

        function configureChartForPublicAPITests( testCase )

            testCase.Chart.Data = testCase.ternaryData();
            drawnow()

        end % configureChartForPublicAPITests

        function propertyNames = propertyAssignmentExclusions( ~ )

            propertyNames = ["Data"; "MarkerEdgeColor"; ...
                "ColorbarVisible"];

        end % propertyAssignmentExclusions

        function samples = publicMethodCallSamples( testCase )

            samples = publicMethodCallSamples@tChart( testCase );
            sampleNames = string( {samples.Name} ).';
            samples(sampleNames == "ylabel") = [];
            samples = [
                samples
                testCase.publicMethodCallSample( ...
                "ylabel", {"left", "Test label"} )
                testCase.publicMethodCallSample( "resetLabels" )
                testCase.publicMethodCallSample( "swapdata", {1, 2} )
                testCase.publicMethodCallSample( ...
                "rotate", {"clockwise"} ) ];

        end % publicMethodCallSamples

    end % methods ( Access = protected )

    methods ( Access = private )

        function data = ternaryData( ~ )

            [a, b] = ndgrid( 0:0.25:1 );
            idx = a + b <= 1;
            a = a(idx);
            b = b(idx);
            c = 1 - a - b;
            z = 1 + a + 2 * b + 3 * c;
            data = table( a, b, c, z, ...
                'VariableNames', ["A", "B", "C", "Z"] );

        end % ternaryData

    end % methods ( Access = private )

end % classdef

````

## See Also

* [Ternary Chart](../landing/TernaryChart.md)
* [Chart Reference](../ChartsIndex.md)

