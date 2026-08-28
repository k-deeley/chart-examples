# `CircularNetFlowChart` Unit Test

Test file: [`tCircularNetFlowChart.m`](../../charts/tests/tCircularNetFlowChart.m).

````text
classdef tCircularNetFlowChart < tChart
    %TCIRCULARNETFLOWCHART Tests for the CircularNetFlowChart class.


    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

    end % methods ( Test )

    methods ( Access = protected )

        function propertyNames = propertyAssignmentExclusions( ~ )

            propertyNames = "OuterLabelOffset";

        end % propertyAssignmentExclusions

    end % methods ( Access = protected )

end % classdef

````

## See Also

* [Circular Net Flow Chart](CircularNetFlowChart.md)
* [Chart Reference](ChartsIndex.md)

