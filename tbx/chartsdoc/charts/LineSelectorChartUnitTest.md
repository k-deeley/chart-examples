# `LineSelectorChart` Unit Test

Test file: [`tLineSelectorChart.m`](../../charts/tests/tLineSelectorChart.m).

````text
classdef tLineSelectorChart < tChart
    %TLINESELECTORCHART Tests for the LineSelectorChart class.


    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

    end % methods ( Test )

    methods ( Access = protected )

        function configureChartForPublicAPITests( testCase )

            testCase.Chart.XData = (1:4).';
            testCase.Chart.YData = [(1:4).', (4:-1:1).'];
            drawnow()

        end % configureChartForPublicAPITests

        function samples = chartSpecificPublicMethodCallSamples( ...
                testCase )

            samples = [
                testCase.publicMethodCallSample( "deselect" )
                testCase.publicMethodCallSample( "select", {1} ) ];

        end % chartSpecificPublicMethodCallSamples

    end % methods ( Access = protected )

end % classdef

````

## See Also

* [Line Selector Chart](LineSelectorChart.md)
* [Chart Reference](ChartsIndex.md)

