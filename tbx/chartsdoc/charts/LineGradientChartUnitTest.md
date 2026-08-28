# `LineGradientChart` Unit Test

Test file: [`tLineGradientChart.m`](../../charts/tests/tLineGradientChart.m).

````text
classdef tLineGradientChart < tChart
    %TLINEGRADIENTCHART Tests for the LineGradientChart class.


    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

    end % methods ( Test )
    methods ( Access = protected )

        function configureChartForPublicAPITests( testCase )

            testCase.Chart.XData = datetime( 2026, 1, 1:4 ).';
            testCase.Chart.YData = [1; 3; 2; 4];
            drawnow()

        end % configureChartForPublicAPITests

    end % methods ( Access = protected )

end % classdef

````

## See Also

* [Line Gradient Chart](LineGradientChart.md)
* [Chart Reference](ChartsIndex.md)

