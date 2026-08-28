# `SankeyChart` Test Class

Test file: `tSankeyChart.m`.

````text 
classdef tSankeyChart < tChart
    %TSANKEYCHART Tests for the SankeyChart class.


    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

    end % methods ( Test )

    methods ( Access = protected )

        function propertyNames = propertyAssignmentExclusions( ~ )

            propertyNames = ["GraphData"; "NodePadRatio"];

        end % propertyAssignmentExclusions

    end % methods ( Access = protected )

end % classdef

````

## See Also

* [Sankey Chart](../landing/SankeyChart.md)
* [Chart Reference](../ChartsIndex.md)

