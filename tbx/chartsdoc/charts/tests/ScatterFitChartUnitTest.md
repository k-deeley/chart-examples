# `ScatterFitChart` Test Class

Test file: `tScatterFitChart.m`.

````text 
classdef tScatterFitChart < tChart
    %TSCATTERFITCHART Tests for the ScatterFitChart class.
    %
    % See also ScatterFitChart, tChart


    properties ( TestParameter )
        % Annotation methods.
        AnnotationMethod = struct( "xlabel", "xlabel", ...
            "ylabel", "ylabel", ...
            "title", "title" )
    end % properties ( TestParameter )

    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

        function tSettingXDataResizesYData( testCase )

            % Start with five points.
            testCase.Chart.YData = [2; 3; 5; 7; 11];
            testCase.Chart.XData = (1:5).';
            drawnow()

            % Shorten x-data and verify y-data follows.
            testCase.Chart.XData = (1:3).';
            drawnow()
            testCase.verifyThat( testCase.Chart.YData, ...
                IsEqualVector( [2; 3; 5] ), "Shortening 'XData' " + ...
                "did not truncate 'YData'." )

        end % tSettingXDataResizesYData

        function tLineAndMarkerPropertiesRoundTrip( testCase )

            % Set visible style properties.
            testCase.Chart.LineVisible = "off";
            testCase.Chart.LineWidth = 3;
            testCase.Chart.LineStyle = "--";
            testCase.Chart.LineColor = "r";
            testCase.Chart.Marker = "x";
            drawnow()

            % Verify public style state.
            expected = matlab.lang.OnOffSwitchState( "off" );
            testCase.verifyEqual( testCase.Chart.LineVisible, expected, ...
                "Setting 'LineVisible' did not round-trip." )
            testCase.verifyEqual( testCase.Chart.LineWidth, 3, ...
                "Setting 'LineWidth' did not round-trip." )
            testCase.verifyThat( testCase.Chart.LineStyle, ...
                IsEquivalentText( "--" ), ...
                "Setting 'LineStyle' did not round-trip." )
            testCase.verifyEqual( testCase.Chart.LineColor, [1, 0, 0], ...
                "Setting 'LineColor' did not normalize to RGB." )
            testCase.verifyThat( testCase.Chart.Marker, ...
                IsEquivalentText( "x" ), ...
                "Setting 'Marker' did not round-trip." )

        end % tLineAndMarkerPropertiesRoundTrip

        function tControlsPropertyRoundTrips( testCase )

            % Toggle controls through the public property.
            testCase.Chart.Controls = "on";
            drawnow()
            expected = matlab.lang.OnOffSwitchState( "on" );
            testCase.verifyEqual( testCase.Chart.Controls, expected, ...
                "Setting 'Controls' to 'on' did not " + ...
                "round-trip correctly." )

        end % tControlsPropertyRoundTrips

        function tAnnotationMethodsSetCorrectText( testCase, ...
                AnnotationMethod )

            % Call the given annotation method.
            expected = "Fit";
            txt = feval( AnnotationMethod, testCase.Chart, expected );
            drawnow()

            % Verify that the text was set correctly.
            testCase.verifyThat( txt.String, ...
                IsEquivalentText( expected ), ...
                "Calling " + AnnotationMethod + "() did not set " + ...
                "the expected text." )

        end % tAnnotationMethodsSetCorrectText

    end % methods ( Test )

    methods ( Access = protected )

        function configureChartForPublicAPITests( testCase )

            testCase.Chart.XData = (1:5).';
            testCase.Chart.YData = [2; 3; 5; 7; 11];
            drawnow()

        end % configureChartForPublicAPITests

    end % methods ( Access = protected )

end % classdef

````

## See Also

* [Scatter Fit Chart](../landing/ScatterFitChart.md)
* [Chart Examples](../../ChartExamples.md)

