# `AnnulusChart` Test Class

Test file: `tAnnulusChart.m`.

````text 
classdef tAnnulusChart < tChart
    %TANNULUSCHART Tests for the AnnulusChart class.
    %
    % See also AnnulusChart, tChart


    properties ( TestParameter )
        % Legend text properties and values.
        LegendTextProperty = struct( ...
            "LegendTitle", ["LegendTitle", "Allocation"], ...
            "LegendLocation", ["LegendLocation", "southoutside"], ...
            "LegendOrientation", ["LegendOrientation", "horizontal"] )
        % Legend numeric properties and values.
        LegendNumericProperty = struct( ...
            "LegendFontSize", ["LegendFontSize", 8], ...
            "LegendNumColumns", ["LegendNumColumns", 2] )
        % Legend on/off properties and values.
        LegendOnOffProperty = struct( ...
            "LegendVisible", ["LegendVisible", "off"], ...
            "LegendBox", ["LegendBox", "off"] )
    end % properties ( TestParameter )

    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

        function tSettingDataUpdatesPercentagesAndGraphics( testCase )

            % Set chart data with known percentages.
            data = [1; 2; 7];
            testCase.Chart.Data = data;
            drawnow()

            % Verify that the public percentages are correct.
            expected = 100 * data / sum( data );
            constraint = IsEqualVector( expected );
            testCase.verifyThat( testCase.Chart.DataPercentages, ...
                constraint, "Setting the chart's 'Data' property " + ...
                "did not update 'DataPercentages' correctly." )

            % Verify that the rendered graphics match the data length.
            testCase.verifySize( testCase.Chart.WedgeGraphics, ...
                [numel( data ), 6], "Setting the chart's 'Data' " + ...
                "property did not create the expected number of " + ...
                "wedge graphics objects." )
            testCase.verifyNumElements( testCase.Chart.WedgeLabels, ...
                numel( data ), "Setting the chart's 'Data' property " + ...
                "did not create the expected number of wedge labels." )

            % Reduce the data length and verify that graphics are removed.
            data = [2; 3];
            testCase.Chart.Data = data;
            drawnow()
            expected = 100 * data / sum( data );
            constraint = IsEqualVector( expected );
            testCase.verifyThat( testCase.Chart.DataPercentages, ...
                constraint, "Reducing the chart data length did not " + ...
                "update 'DataPercentages' correctly." )
            testCase.verifySize( testCase.Chart.WedgeGraphics, ...
                [numel( data ), 6], "Reducing the chart data length " + ...
                "did not remove the expected wedge graphics objects." )
            testCase.verifyNumElements( testCase.Chart.WedgeLabels, ...
                numel( data ), "Reducing the chart data length did " + ...
                "not remove the expected wedge labels." )

        end % tSettingDataUpdatesPercentagesAndGraphics

        function tLabelPropertiesUpdateRenderedLabels( testCase )

            % Set label text with percentages shown.
            data = [1; 3];
            expectedText = ["A (25.0%)"; "B (75.0%)"];
            testCase.Chart.Data = data;
            testCase.Chart.LabelText = ["A"; "B"];
            testCase.Chart.LabelPercentages = "on";
            drawnow()

            % Verify that the rendered labels include percentages.
            actualText = {testCase.Chart.WedgeLabels.String}.';
            testCase.verifyThat( actualText, ...
                IsEquivalentText( expectedText ), "Setting the " + ...
                "chart's label text with 'LabelPercentages' set to " + ...
                "'on' did not update the rendered labels correctly." )

            % Verify that hiding percentages updates the rendered labels.
            testCase.Chart.LabelPercentages = "off";
            drawnow()
            actualText = {testCase.Chart.WedgeLabels.String}.';
            testCase.verifyThat( actualText, ...
                IsEquivalentText( ["A"; "B"] ), "Setting the " + ...
                "chart's 'LabelPercentages' property to 'off' did " + ...
                "not remove percentages from the rendered labels." )

            % Verify label visibility.
            testCase.Chart.LabelVisible = "off";
            drawnow()
            actualVisible = [testCase.Chart.WedgeLabels.Visible];
            expectedVisible = repmat( ...
                matlab.lang.OnOffSwitchState( "off" ), ...
                size( actualVisible ) );
            testCase.verifyEqual( actualVisible, expectedVisible, ...
                "Setting the chart's 'LabelVisible' property to " + ...
                "'off' did not hide the rendered labels." )

            % Verify label font size.
            expectedFontSize = 14;
            testCase.Chart.LabelFontSize = expectedFontSize;
            drawnow()
            actualFontSize = [testCase.Chart.WedgeLabels.FontSize];
            testCase.verifyEqual( actualFontSize, ...
                expectedFontSize * ones( 1, numel( data ) ), ...
                "Setting the chart's 'LabelFontSize' property did " + ...
                "not update the rendered labels." )

        end % tLabelPropertiesUpdateRenderedLabels

        function tLegendTextUpdatesRenderedLegend( testCase )

            % Set legend text with percentages shown.
            data = [1; 3];
            expected = ["First (25.0%)"; "Second (75.0%)"];
            testCase.Chart.Data = data;
            testCase.Chart.LegendText = ["First"; "Second"];
            testCase.Chart.LegendPercentages = "on";
            drawnow()

            % Verify that the rendered legend string is correct.
            actual = testCase.Chart.Legend.String(:);
            testCase.verifyThat( actual, IsEquivalentText( expected ), ...
                "Setting the chart's legend text with " + ...
                "'LegendPercentages' set to 'on' did not update " + ...
                "the rendered legend correctly." )

            % Verify that hiding percentages updates the rendered legend.
            testCase.Chart.LegendPercentages = "off";
            drawnow()
            actual = testCase.Chart.Legend.String(:);
            testCase.verifyThat( actual, ...
                IsEquivalentText( ["First"; "Second"] ), ...
                "Setting the chart's 'LegendPercentages' property " + ...
                "to 'off' did not remove percentages from the legend." )

        end % tLegendTextUpdatesRenderedLegend

        function tLegendTextPropertyUpdatesLegend( testCase, ...
                LegendTextProperty )

            % Unpack.
            propertyName = LegendTextProperty(1);
            expected = LegendTextProperty(2);

            % Set the legend property.
            testCase.Chart.(propertyName) = expected;
            drawnow()

            % Verify that the underlying legend is correct.
            if propertyName == "LegendTitle"
                actual = testCase.Chart.Legend.Title.String;
            else
                actual = testCase.Chart.Legend.(erase( ...
                    propertyName, "Legend" ));
            end % if
            testCase.verifyThat( actual, IsEquivalentText( expected ), ...
                "Setting the chart's '" + propertyName + ...
                "' property did not update the legend correctly." )

        end % tLegendTextPropertyUpdatesLegend

        function tLegendNumericPropertyUpdatesLegend( testCase, ...
                LegendNumericProperty )

            % Unpack.
            propertyName = LegendNumericProperty(1);
            expected = str2double( LegendNumericProperty(2) );

            % Set the legend property.
            testCase.Chart.(propertyName) = expected;
            drawnow()

            % Verify that the underlying legend is correct.
            actual = testCase.Chart.Legend.(erase( ...
                propertyName, "Legend" ));
            testCase.verifyEqual( actual, expected, ...
                "Setting the chart's '" + propertyName + ...
                "' property did not update the legend correctly." )

        end % tLegendNumericPropertyUpdatesLegend

        function tLegendOnOffPropertyUpdatesLegend( testCase, ...
                LegendOnOffProperty )

            % Unpack.
            propertyName = LegendOnOffProperty(1);
            expected = LegendOnOffProperty(2);

            % Set the legend property.
            testCase.Chart.(propertyName) = expected;
            drawnow()

            % Verify that the underlying legend is correct.
            actual = testCase.Chart.Legend.(erase( ...
                propertyName, "Legend" ));
            expected = matlab.lang.OnOffSwitchState( expected );
            testCase.verifyEqual( actual, expected, ...
                "Setting the chart's '" + propertyName + ...
                "' property did not update the legend correctly." )

        end % tLegendOnOffPropertyUpdatesLegend

        function tSettingLegendColorUpdatesLegend( testCase )

            % Set the legend color to "none".
            expected = "none";
            testCase.Chart.LegendColor = expected;
            drawnow()
            actual = testCase.Chart.Legend.Color;
            testCase.verifyThat( actual, IsEquivalentText( expected ), ...
                "Setting the chart's 'LegendColor' property to " + ...
                "'none' did not update the legend correctly." )

            % Set the legend color to an RGB color.
            expected = [1, 0, 0];
            testCase.Chart.LegendColor = "r";
            drawnow()
            actual = testCase.Chart.Legend.Color;
            testCase.verifyEqual( actual, expected, ...
                "Setting the chart's 'LegendColor' property to " + ...
                "a valid color did not update the legend correctly." )

        end % tSettingLegendColorUpdatesLegend

        function tSettingFaceColorUpdatesWedges( testCase )

            % Set the chart data and face colors.
            testCase.Chart.Data = [1; 2; 3];
            expected = [1, 0, 0; 0, 1, 0; 0, 0, 1];
            testCase.Chart.FaceColor = expected;
            drawnow()

            % Verify that the first face for each wedge uses the color.
            actual = cell2mat( ...
                get( testCase.Chart.WedgeGraphics(:, 1), ...
                "FaceColor" ) );
            testCase.verifyEqual( actual, expected, ...
                "Setting the chart's 'FaceColor' property did not " + ...
                "update the wedge face colors correctly." )

        end % tSettingFaceColorUpdatesWedges

        function tMismatchedTextLengthsThrowExceptions( testCase )

            % Set chart data.
            testCase.Chart.Data = [1; 2; 3];
            drawnow()

            % Verify that label text length is validated.
            f = @() set( testCase.Chart, "LabelText", ["A"; "B"] );
            testCase.verifyError( f, ...
                "AnnulusChart:LabelTextLengthMismatch", ...
                "Setting the chart's 'LabelText' property with " + ...
                "the wrong number of values did not throw the " + ...
                "expected exception." )

            % Verify that legend text length is validated.
            f = @() set( testCase.Chart, "LegendText", ["A"; "B"] );
            testCase.verifyError( f, ...
                "AnnulusChart:LegendTextLengthMismatch", ...
                "Setting the chart's 'LegendText' property with " + ...
                "the wrong number of values did not throw the " + ...
                "expected exception." )

        end % tMismatchedTextLengthsThrowExceptions

        function tMismatchedFaceColorHeightThrowsException( testCase )

            % Set chart data.
            testCase.Chart.Data = [1; 2; 3];
            drawnow()

            % Verify that face color height is validated.
            f = @() set( testCase.Chart, "FaceColor", [1, 0, 0] );
            testCase.verifyError( f, ...
                "AnnulusChart:FaceColorHeightMismatch", ...
                "Setting the chart's 'FaceColor' property with " + ...
                "the wrong number of colors did not throw the " + ...
                "expected exception." )

        end % tMismatchedFaceColorHeightThrowsException

        function tExplodeAndRetractMoveWedges( testCase )

            % Set chart data and record the initial first wedge location.
            testCase.Chart.Data = [1; 1; 1];
            drawnow()
            initialXData = testCase.Chart.WedgeGraphics(1, 1).XData;
            initialYData = testCase.Chart.WedgeGraphics(1, 1).YData;

            % Explode the first wedge and verify that it moved.
            explode( testCase.Chart, 1 )
            drawnow()
            explodedXData = testCase.Chart.WedgeGraphics(1, 1).XData;
            explodedYData = testCase.Chart.WedgeGraphics(1, 1).YData;
            testCase.verifyNotEqual( explodedXData, initialXData, ...
                "Calling explode() did not update the wedge's " + ...
                "'XData' property." )
            testCase.verifyNotEqual( explodedYData, initialYData, ...
                "Calling explode() did not update the wedge's " + ...
                "'YData' property." )

            % Retract the first wedge and verify that it moved back.
            retract( testCase.Chart, 1 )
            drawnow()
            actualXData = testCase.Chart.WedgeGraphics(1, 1).XData;
            actualYData = testCase.Chart.WedgeGraphics(1, 1).YData;
            testCase.verifyEqual( actualXData, initialXData, ...
                "AbsTol", 1e-12, "Calling retract() did not " + ...
                "restore the wedge's 'XData' property." )
            testCase.verifyEqual( actualYData, initialYData, ...
                "AbsTol", 1e-12, "Calling retract() did not " + ...
                "restore the wedge's 'YData' property." )

        end % tExplodeAndRetractMoveWedges

        function tResetViewRestoresDefaultView( testCase )

            % Change the chart view.
            view( testCase.Chart, [30, 20] )
            drawnow()

            % Reset the chart view.
            resetView( testCase.Chart )
            drawnow()

            % Verify the default view is restored.
            [actualAzimuth, actualElevation] = view( ...
                testCase.Chart.Axes );
            actual = [actualAzimuth, actualElevation];
            testCase.verifyEqual( actual, [0, 50], ...
                "Calling resetView() did not restore the default " + ...
                "chart view." )

        end % tResetViewRestoresDefaultView

        function tControlsPropertyUpdatesLayout( testCase )

            % Show the chart controls.
            testCase.Chart.Controls = "on";
            drawnow()
            actual = testCase.Chart.LayoutGrid.ColumnWidth;
            testCase.verifyThat( actual, ...
                IsEquivalentText( ["1x", "fit"] ), ...
                "Setting the chart's 'Controls' property to 'on' " + ...
                "did not show the chart controls." )

            % Hide the chart controls.
            testCase.Chart.Controls = "off";
            drawnow()
            actual = testCase.Chart.LayoutGrid.ColumnWidth;
            testCase.verifyThat( actual, ...
                IsEquivalentText( ["1x", "0x"] ), ...
                "Setting the chart's 'Controls' property to 'off' " + ...
                "did not hide the chart controls." )

        end % tControlsPropertyUpdatesLayout

    end % methods ( Test )

    methods ( Access = protected )

        function configureChartForPublicAPITests( testCase )

            testCase.Chart.Data = [1; 2; 3];
            testCase.Chart.LabelText = ["A"; "B"; "C"];
            testCase.Chart.LabelVisible = "on";
            drawnow()

        end % configureChartForPublicAPITests

        function propertyNames = propertyAssignmentExclusions( ~ )

            propertyNames = "FaceColor";

        end % propertyAssignmentExclusions

        function samples = chartSpecificPublicMethodCallSamples( ...
                testCase )

            samples = [
                testCase.publicMethodCallSample( "retract" )
                testCase.publicMethodCallSample( "explode", {1} )
                testCase.publicMethodCallSample( "resetView" ) ];

        end % chartSpecificPublicMethodCallSamples

    end % methods ( Access = protected )

end % classdef

````

## See Also

* [Annulus Chart](../landing/AnnulusChart.md)
* [Chart Reference](../ChartsIndex.md)

