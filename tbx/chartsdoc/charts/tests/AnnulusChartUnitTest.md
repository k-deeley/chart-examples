# `AnnulusChart` Test Class

Test file: `tAnnulusChart.m`.

````text 
classdef tAnnulusChart < tChart
    %TANNULUSCHART Tests for the AnnulusChart class.


    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

    end % methods ( Test )

    methods ( Access = protected )

        function configureChartForPublicAPITests( testCase )

            testCase.Chart.Data = [1; 2; 3];
            testCase.Chart.LabelText = ["A"; "B"; "C"];
            testCase.Chart.LabelVisible = "on";
            drawnow()

        end % configureChartForPublicAPITests

        function propertyNames = propertyAssignmentExclusions( ~ )

            propertyNames = "FaceColor";

        end % propertyAssignmentExclusions

        function samples = chartSpecificPublicMethodCallSamples( ...
                testCase )

            samples = [
                testCase.publicMethodCallSample( "retract" )
                testCase.publicMethodCallSample( "explode", {1} )
                testCase.publicMethodCallSample( "resetView" ) ];

        end % chartSpecificPublicMethodCallSamples

    end % methods ( Access = protected )

end % classdef

````

## See Also

* [Annulus Chart](../landing/AnnulusChart.md)
* [Chart Reference](../ChartsIndex.md)

