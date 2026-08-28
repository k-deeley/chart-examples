# `InductionMotorChart` Test Class

Test file: `tInductionMotorChart.m`.

````text 
classdef tInductionMotorChart < tChart
    %TINDUCTIONMOTORCHART Tests for the InductionMotorChart class.
    %
    % See also InductionMotorChart, tChart


    properties ( TestParameter )
        % Annotation methods.
        AnnotationMethod = struct( "xlabel", "xlabel", ...
            "ylabel", "ylabel", ...
            "title", "title", ...
            "subtitle", "subtitle" )
    end % properties ( TestParameter )

    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

        function tOperatingPointAndStylePropertiesRoundTrip( testCase )

            % Set public chart state.
            testCase.Chart.OperatingPoint = [1000, 25];
            testCase.Chart.LineWidth = 3;
            testCase.Chart.MarkerSize = 14;
            testCase.Chart.FaceAlpha = 0.25;
            testCase.Chart.LegendVisible = "off";
            drawnow()

            % Verify public state.
            testCase.verifyEqual( testCase.Chart.OperatingPoint, ...
                [1000, 25], "Setting 'OperatingPoint' did not " + ...
                "round-trip correctly." )
            testCase.verifyEqual( testCase.Chart.LineWidth, 3, ...
                "Setting 'LineWidth' did not round-trip." )
            testCase.verifyEqual( testCase.Chart.MarkerSize, 14, ...
                "Setting 'MarkerSize' did not round-trip." )
            testCase.verifyEqual( testCase.Chart.FaceAlpha, 0.25, ...
                "Setting 'FaceAlpha' did not round-trip." )
            expected = matlab.lang.OnOffSwitchState( "off" );
            testCase.verifyEqual( testCase.Chart.LegendVisible, ...
                expected, ...
                "Setting 'LegendVisible' did not round-trip." )

        end % tOperatingPointAndStylePropertiesRoundTrip

        function tAnnotationMethodsSetCorrectText( testCase, ...
                AnnotationMethod )

            % Call the given annotation method.
            expected = "Motor";
            txt = feval( AnnotationMethod, testCase.Chart, expected );
            drawnow()

            % Verify that the text was set correctly.
            testCase.verifyThat( txt.String, ...
                IsEquivalentText( expected ), ...
                "Calling " + AnnotationMethod + "() did not set " + ...
                "the expected text." )

        end % tAnnotationMethodsSetCorrectText

    end % methods ( Test )
end % classdef

````

## See Also

* [Induction Motor Chart](../landing/InductionMotorChart.md)
* [Chart Reference](../ChartsIndex.md)

