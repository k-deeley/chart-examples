# `ImpliedVolatilityChart` Test Class

Test file: `tImpliedVolatilityChart.m`.

````text 
classdef tImpliedVolatilityChart < tChart
    %TIMPLIEDVOLATILITYCHART Tests for ImpliedVolatilityChart.
    %
    % See also ImpliedVolatilityChart, tChart


    properties ( TestParameter )
        % Annotation methods.
        AnnotationMethod = struct( "xlabel", "xlabel", ...
            "ylabel", "ylabel", ...
            "zlabel", "zlabel", ...
            "title", "title" )
    end % properties ( TestParameter )

    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

        function tSettingOptionDataRoundTrips( testCase )

            % Set option data.
            expected = testCase.optionData();
            testCase.Chart.OptionData = expected;
            drawnow()

            % Verify the table is stored.
            testCase.verifyEqual( testCase.Chart.OptionData, expected, ...
                "Setting 'OptionData' did not round-trip correctly." )

        end % tSettingOptionDataRoundTrips

        function tInterpolationAndMarkerPropertiesRoundTrip( testCase )

            % Set chart style properties.
            testCase.Chart.InterpolationMethod = "linear";
            testCase.Chart.Marker = "x";
            testCase.Chart.MarkerSize = 8;
            testCase.Chart.MarkerFaceColor = [1, 0, 0];
            testCase.Chart.MarkerEdgeColor = [0, 0, 1];
            drawnow()

            % Verify public state.
            testCase.verifyThat( testCase.Chart.InterpolationMethod, ...
                IsEquivalentText( "linear" ), ...
                "Setting 'InterpolationMethod' did not " + ...
                "round-trip correctly." )
            testCase.verifyThat( testCase.Chart.Marker, ...
                IsEquivalentText( "x" ), ...
                "Setting 'Marker' did not round-trip correctly." )
            testCase.verifyEqual( testCase.Chart.MarkerSize, 8, ...
                "Setting 'MarkerSize' did not round-trip correctly." )
            testCase.verifyEqual( testCase.Chart.MarkerFaceColor, ...
                [1, 0, 0], "Setting 'MarkerFaceColor' did not " + ...
                "round-trip correctly." )
            testCase.verifyEqual( testCase.Chart.MarkerEdgeColor, ...
                [0, 0, 1], "Setting 'MarkerEdgeColor' did not " + ...
                "round-trip correctly." )

        end % tInterpolationAndMarkerPropertiesRoundTrip

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
            expected = "Volatility";
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

            testCase.Chart.OptionData = testCase.optionData();
            drawnow()

        end % configureChartForPublicAPITests

    end % methods ( Access = protected )

    methods ( Access = private )

        function optionData = optionData( ~ )

            timeToExpiry = repelem( [1; 2], 4 );
            strike = repmat( [80; 90; 100; 110], 2, 1 );
            volatility = [0.20; 0.18; 0.19; 0.21; ...
                0.24; 0.22; 0.23; 0.25];
            spot = 100 * ones( size( strike ) );
            optionData = table( timeToExpiry, strike, ...
                volatility, spot, 'VariableNames', ...
                ["T", "K", "Sigma", "S"] );

        end % optionData

    end % methods ( Access = private )

end % classdef

````

## See Also

* [Implied Volatility Chart](../landing/ImpliedVolatilityChart.md)
* [Chart Examples](../../ChartExamples.md)

