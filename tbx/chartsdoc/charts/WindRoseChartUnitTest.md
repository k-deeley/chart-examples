# `WindRoseChart` Unit Test

Test file: [`tWindRoseChart.m`](../../charts/tests/tWindRoseChart.m).

````text
classdef tWindRoseChart < tChart
    %TWINDROSECHART Tests for the WindRoseChart class.


    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

    end % methods ( Test )

    methods ( Access = protected )

        function propertyNames = propertyAssignmentExclusions( ~ )

            propertyNames = ["WindData"; "SpeedBinEdges"; ...
                "RadialLabelDirection"];

        end % propertyAssignmentExclusions

    end % methods ( Access = protected )

end % classdef

````

## See Also

* [Wind Rose Chart](WindRoseChart.md)
* [Chart Reference](ChartsIndex.md)

