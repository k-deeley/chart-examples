# `ValueAtRiskChart` Test Class

Test file: `tValueAtRiskChart.m`.

````text 
classdef tValueAtRiskChart < tChart
    %TVALUEATRISKCHART Tests for the ValueAtRiskChart class.
    %
    % See also ValueAtRiskChart, tChart


    properties ( TestParameter )
        % Annotation methods.
        AnnotationMethod = struct( "xlabel", "xlabel", ...
            "ylabel", "ylabel", ...
            "title", "title" )
        % Visibility properties.
        VisibilityProperty = struct( ...
            "FittedPDFVisible", "FittedPDFVisible", ...
            "VaRLineVisible", "VaRLineVisible", ...
            "CVaRLineVisible", "CVaRLineVisible" )
    end % properties ( TestParameter )

    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

        function tSettingDataAndVaRLevelUpdatesRiskMetrics( testCase )

            % Set deterministic returns and risk level.
            data = (-10:10).' / 100;
            testCase.Chart.Data = data;
            testCase.Chart.VaRLevel = 0.95;
            drawnow()

            % Verify the derived risk metrics.
            expectedVaR = quantile( data, 0.05 );
            expectedCVaR = mean( data(data < expectedVaR) );
            testCase.verifyEqual( testCase.Chart.RiskMetrics, ...
                [expectedVaR, expectedCVaR], "RelTol", 1e-12, ...
                "Setting 'Data' and 'VaRLevel' did not update " + ...
                "'RiskMetrics' correctly." )

        end % tSettingDataAndVaRLevelUpdatesRiskMetrics

        function tDistributionAndHistogramPropertiesRoundTrip( testCase )

            % Set distribution and histogram style properties.
            testCase.Chart.Data = (-10:10).' / 100;
            testCase.Chart.DistributionName = "Normal";
            testCase.Chart.EdgeAlpha = 0.25;
            testCase.Chart.EdgeColor = [1, 0, 0];
            testCase.Chart.FaceAlpha = 0.5;
            testCase.Chart.FaceColor = [0, 0, 1];
            drawnow()

            % Verify public state.
            testCase.verifyThat( testCase.Chart.DistributionName, ...
                IsEquivalentText( "Normal" ), ...
                "Setting 'DistributionName' did not " + ...
                "round-trip." )
            testCase.verifyEqual( testCase.Chart.EdgeAlpha, 0.25, ...
                "Setting 'EdgeAlpha' did not round-trip." )
            testCase.verifyEqual( testCase.Chart.EdgeColor, [1, 0, 0], ...
                "Setting 'EdgeColor' did not round-trip." )
            testCase.verifyEqual( testCase.Chart.FaceAlpha, 0.5, ...
                "Setting 'FaceAlpha' did not round-trip." )
            testCase.verifyEqual( testCase.Chart.FaceColor, [0, 0, 1], ...
                "Setting 'FaceColor' did not round-trip." )

        end % tDistributionAndHistogramPropertiesRoundTrip

        function tVisibilityPropertyUpdatesChart( testCase, ...
                VisibilityProperty )

            % Set a line visibility property.
            testCase.Chart.(VisibilityProperty) = "off";
            drawnow()

            % Verify public visibility state.
            actual = testCase.Chart.(VisibilityProperty);
            expected = matlab.lang.OnOffSwitchState( "off" );
            testCase.verifyEqual( actual, expected, ...
                "Setting '" + VisibilityProperty + "' did not " + ...
                "round-trip correctly." )

        end % tVisibilityPropertyUpdatesChart

        function tLabelVisibilityAndControlsRoundTrip( testCase )

            % Toggle checkbox-backed properties.
            testCase.Chart.VaRLabelVisible = "off";
            testCase.Chart.CVaRLabelVisible = "off";
            testCase.Chart.Controls = "on";
            drawnow()

            % Verify public state.
            testCase.verifyFalse( testCase.Chart.VaRLabelVisible, ...
                "Setting 'VaRLabelVisible' did not round-trip." )
            testCase.verifyFalse( testCase.Chart.CVaRLabelVisible, ...
                "Setting 'CVaRLabelVisible' did not round-trip." )
            expected = matlab.lang.OnOffSwitchState( "on" );
            testCase.verifyEqual( testCase.Chart.Controls, expected, ...
                "Setting 'Controls' did not round-trip." )

        end % tLabelVisibilityAndControlsRoundTrip

        function tAnnotationMethodsSetCorrectText( testCase, ...
                AnnotationMethod )

            % Call the given annotation method.
            expected = "Risk";
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

            testCase.Chart.Data = (-10:10).' / 100;
            drawnow()

        end % configureChartForPublicAPITests

    end % methods ( Access = protected )

end % classdef

````

## See Also

* [Value At Risk Chart](../landing/ValueAtRiskChart.md)
* [Chart Reference](../ChartsIndex.md)

