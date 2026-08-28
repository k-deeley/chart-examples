# `SpiderChart` Test Class

Test file: `tSpiderChart.m`.

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

* [Spider Chart](../landing/SpiderChart.md)
* [Chart Reference](../ChartsIndex.md)

