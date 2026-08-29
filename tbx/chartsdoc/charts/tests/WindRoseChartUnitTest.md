# `WindRoseChart` Test Class

Test file: `tWindRoseChart.m`.

````text 
classdef tWindRoseChart < tChart
    %TWINDROSECHART Tests for the WindRoseChart class.
    %
    % See also WindRoseChart, tChart


    properties ( TestParameter )
        % Legend text properties and values.
        LegendTextProperty = struct( ...
            "LegendLocation", ["LegendLocation", "southoutside"], ...
            "LegendOrientation", ["LegendOrientation", "horizontal"], ...
            "LegendTitle", ["LegendTitle", "Speed"] )
        % Legend numeric properties and values.
        LegendNumericProperty = struct( ...
            "LegendNumColumns", ["LegendNumColumns", 2], ...
            "LegendFontSize", ["LegendFontSize", 8], ...
            "LegendLineWidth", ["LegendLineWidth", 2] )
        % Label visibility properties.
        LabelVisibleProperty = struct( ...
            "DirectionLabelVisible", "DirectionLabelVisible", ...
            "RadialLabelVisible", "RadialLabelVisible", ...
            "LegendVisible", "LegendVisible", ...
            "LegendBox", "LegendBox" )
    end % properties ( TestParameter )

    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

        function tSettingWindDataUpdatesObservationCounts( testCase )

            % Set wind data and bin edges.
            windData = testCase.windData();
            testCase.Chart.WindData = windData;
            testCase.Chart.SpeedBinEdges = [0, 5, 10, 15, Inf];
            drawnow()

            % Verify the public count tables.
            actualCounts = testCase.Chart.ObservationCounts;
            testCase.verifySize( actualCounts, [36, 4], ...
                "Setting wind data did not create one count row " + ...
                "per direction bin and one column per speed bin." )
            testCase.verifyEqual( sum( actualCounts, "all" ), ...
                height( windData ), "Observation counts did not " + ...
                "include every wind observation." )
            actualPercent = ...
                testCase.Chart.PercentageObservationCounts;
            testCase.verifyEqual( sum( actualPercent, "all" ), 100, ...
                "Percentage observation counts did not sum to 100." )

        end % tSettingWindDataUpdatesObservationCounts

        function tSettingSpeedBinEdgesUpdatesCountWidth( testCase )

            % Set wind data with three speed bins.
            testCase.Chart.WindData = testCase.windData();
            testCase.Chart.SpeedBinEdges = [0, 10, 20, Inf];
            drawnow()

            % Verify the count matrix width.
            testCase.verifySize( testCase.Chart.ObservationCounts, ...
                [36, 3], "Setting 'SpeedBinEdges' did not update " + ...
                "the number of count columns." )

        end % tSettingSpeedBinEdgesUpdatesCountWidth

        function tLegendTextPropertyUpdatesChart( testCase, ...
                LegendTextProperty )

            % Unpack.
            propertyName = LegendTextProperty(1);
            expected = LegendTextProperty(2);

            % Set and verify the legend property.
            testCase.Chart.(propertyName) = expected;
            drawnow()
            testCase.verifyThat( testCase.Chart.(propertyName), ...
                IsEquivalentText( expected ), "Setting '" + ...
                propertyName + "' did not round-trip correctly." )

        end % tLegendTextPropertyUpdatesChart

        function tLegendNumericPropertyUpdatesChart( testCase, ...
                LegendNumericProperty )

            % Unpack.
            propertyName = LegendNumericProperty(1);
            expected = str2double( LegendNumericProperty(2) );

            % Set and verify the legend property.
            testCase.Chart.(propertyName) = expected;
            drawnow()
            testCase.verifyEqual( testCase.Chart.(propertyName), ...
                expected, "Setting '" + propertyName + "' did not " + ...
                "round-trip correctly." )

        end % tLegendNumericPropertyUpdatesChart

        function tVisibilityPropertyUpdatesChart( testCase, ...
                LabelVisibleProperty )

            % Set and verify a visibility property.
            testCase.Chart.(LabelVisibleProperty) = "off";
            drawnow()
            actual = testCase.Chart.(LabelVisibleProperty);
            expected = matlab.lang.OnOffSwitchState( "off" );
            testCase.verifyEqual( actual, expected, ...
                "Setting '" + LabelVisibleProperty + "' did not " + ...
                "round-trip correctly." )

        end % tVisibilityPropertyUpdatesChart

    end % methods ( Test )

    methods ( Access = protected )

        function configureChartForPublicAPITests( testCase )

            testCase.Chart.WindData = testCase.windData();
            testCase.Chart.SpeedBinEdges = [0, 5, 10, 15, Inf];
            drawnow()

        end % configureChartForPublicAPITests

        function propertyNames = propertyAssignmentExclusions( ~ )

            propertyNames = ["WindData"; "SpeedBinEdges"; ...
                "RadialLabelDirection"];

        end % propertyAssignmentExclusions

    end % methods ( Access = protected )

    methods ( Access = private )

        function windData = windData( ~ )

            Direction = [5; 95; 185; 275];
            Speed = [2; 7; 12; 17];
            windData = table( Direction, Speed );

        end % windData

    end % methods ( Access = private )

end % classdef

````

## See Also

* [Wind Rose Chart](../landing/WindRoseChart.md)
* [Chart Examples](../../ChartExamples.md)

