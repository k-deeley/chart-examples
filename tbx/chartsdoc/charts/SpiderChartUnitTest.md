# `SpiderChart` Unit Test

Test file: [`tSpiderChart.m`](../../charts/tests/tSpiderChart.m).

````text
classdef tSpiderChart < tChart
    %TSPIDERCHART Tests for the SpiderChart class.


    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

    end % methods ( Test )

    methods ( Access = protected )

        function propertyNames = propertyAssignmentExclusions( ~ )

            propertyNames = ["Data"; "LabelText"; "LineColors"];

        end % propertyAssignmentExclusions

    end % methods ( Access = protected )

end % classdef

````

## See Also

* [Spider Chart](SpiderChart.md)
* [Chart Reference](ChartsIndex.md)

