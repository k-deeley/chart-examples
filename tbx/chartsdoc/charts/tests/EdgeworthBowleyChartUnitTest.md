# `EdgeworthBowleyChart` Test Class

Test file: `tEdgeworthBowleyChart.m`.

````text 
classdef tEdgeworthBowleyChart < tChart
    %TEDGEWORTHBOWLEYCHART Tests for the EdgeworthBowleyChart class.


    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

    end % methods ( Test )

    methods ( Access = protected )

        function propertyNames = propertyAssignmentExclusions( ~ )

            propertyNames = ["AData"; "BData"];

        end % propertyAssignmentExclusions

    end % methods ( Access = protected )

end % classdef

````

## See Also

* [Edgeworth Bowley Chart](../landing/EdgeworthBowleyChart.md)
* [Chart Reference](../ChartsIndex.md)

