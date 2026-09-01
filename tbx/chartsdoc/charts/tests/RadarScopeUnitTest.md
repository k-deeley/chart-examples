# `RadarScope` Test Class

Test file: `tRadarScope.m`.

````text 
classdef tRadarScope < tChart
    %TRADARSCOPE Tests for the RadarScope class.
    %
    % See also RadarScope, tChart


    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

        function tAddAndRemoveBlipUpdatesBlipList( testCase )

            % Add a blip to the radar scope.
            blip = testCase.createBlip();
            addBlip( testCase.Chart, blip )
            drawnow()
            testCase.verifyNumElements( testCase.Chart.Blips, 1, ...
                "Calling addBlip() did not add the blip to the " + ...
                "radar scope." )
            testCase.verifySameHandle( testCase.Chart.Blips, blip, ...
                "Calling addBlip() did not store the expected blip." )

            % Remove the blip from the radar scope.
            removeBlip( testCase.Chart, blip )
            drawnow()
            testCase.verifyEmpty( testCase.Chart.Blips, ...
                "Calling removeBlip() did not remove the blip from " + ...
                "the radar scope." )

        end % tAddAndRemoveBlipUpdatesBlipList

        function tStylePropertiesRoundTrip( testCase )

            % Set style properties.
            testCase.Chart.BackdropColor = [1, 0, 0];
            testCase.Chart.BlipColor = [0, 0, 1];
            testCase.Chart.GridLineWidth = 2;
            testCase.Chart.GridAlpha = 0.25;
            testCase.Chart.ShowProximityLamp = "off";
            drawnow()

            % Verify public style state.
            testCase.verifyEqual( testCase.Chart.BackdropColor, ...
                [1, 0, 0], "Setting 'BackdropColor' did not " + ...
                "round-trip correctly." )
            testCase.verifyEqual( testCase.Chart.BlipColor, [0, 0, 1], ...
                "Setting 'BlipColor' did not round-trip correctly." )
            testCase.verifyEqual( testCase.Chart.GridLineWidth, 2, ...
                "Setting 'GridLineWidth' did not round-trip." )
            testCase.verifyEqual( testCase.Chart.GridAlpha, 0.25, ...
                "Setting 'GridAlpha' did not round-trip." )
            expected = matlab.lang.OnOffSwitchState( "off" );
            testCase.verifyEqual( testCase.Chart.ShowProximityLamp, ...
                expected, ...
                "Setting 'ShowProximityLamp' did not round-trip." )

        end % tStylePropertiesRoundTrip

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
* [Chart Examples](../../ChartExamples.md)

