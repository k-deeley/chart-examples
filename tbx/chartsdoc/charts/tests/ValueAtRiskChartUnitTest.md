# `ValueAtRiskChart` Test Class

Test file: `tValueAtRiskChart.m`.

````text 
classdef tValueAtRiskChart < tChart
    %TVALUEATRISKCHART Tests for the ValueAtRiskChart class.


    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

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

