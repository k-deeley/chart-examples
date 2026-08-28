# `AircraftChart` Unit Test

Test file: [`tAircraftChart.m`](../../charts/tests/tAircraftChart.m).

````text
classdef tAircraftChart < tChart
    %TAIRCRAFTCHART Tests for the AircraftChart class.


    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

    end % methods ( Test )

    methods ( Access = protected )

        function samples = chartSpecificPublicMethodCallSamples( ...
                testCase )

            samples = [
                testCase.publicMethodCallSample( "roll", {10} )
                testCase.publicMethodCallSample( "pitch", {10} )
                testCase.publicMethodCallSample( "yaw", {10} )
                testCase.publicMethodCallSample( "reset" ) ];

        end % chartSpecificPublicMethodCallSamples

    end % methods ( Access = protected )

end % classdef

````

## See Also

* [Aircraft Chart](AircraftChart.md)
* [Chart Reference](ChartsIndex.md)

