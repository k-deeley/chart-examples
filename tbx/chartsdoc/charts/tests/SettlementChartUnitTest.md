# `SettlementChart` Test Class

Test file: `tSettlementChart.m`.

````text 
classdef tSettlementChart < tChart
    %TSETTLEMENTCHART Tests for the SettlementChart class.


    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

    end % methods ( Test )

    methods ( Access = protected )

        function samples = chartSpecificPublicMethodCallSamples( ...
                testCase )

            samples = testCase.publicMethodCallSample( "reset" );

        end % chartSpecificPublicMethodCallSamples

    end % methods ( Access = protected )

end % classdef

````

## See Also

* [Settlement Chart](../landing/SettlementChart.md)
* [Chart Reference](../ChartsIndex.md)

