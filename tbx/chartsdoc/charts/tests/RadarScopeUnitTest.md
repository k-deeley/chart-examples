# `RadarScope` Test Class

Test file: `tRadarScope.m`.

````text 
classdef tRadarScope < tChart
    %TRADARSCOPE Tests for the RadarScope class.


    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

    end % methods ( Test )

    methods ( Access = protected )

        function samples = chartSpecificPublicMethodCallSamples( ...
                testCase )

            blipToAdd = testCase.createBlip();
            blipToRemove = testCase.createBlip();
            addBlip( testCase.Chart, blipToRemove )

            samples = [
                testCase.publicMethodCallSample( ...
                "addBlip", {blipToAdd} )
                testCase.publicMethodCallSample( ...
                "removeBlip", {blipToRemove} ) ];

        end % chartSpecificPublicMethodCallSamples

    end % methods ( Access = protected )

    methods ( Access = private )

        function blip = createBlip( testCase )

            blip = Blip( "Position", [0, 20] );
            testCase.addTeardown( @() delete( blip ) )

        end % createBlip

    end % methods ( Access = private )

end % classdef

````

## See Also

* [Radar Scope](../landing/RadarScope.md)
* [Chart Reference](../ChartsIndex.md)

