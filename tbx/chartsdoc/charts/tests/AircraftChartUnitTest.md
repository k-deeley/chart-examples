# `AircraftChart` Test Class

Test file: `tAircraftChart.m`.

````text 
classdef tAircraftChart < tChart
    %TAIRCRAFTCHART Tests for the AircraftChart class.
    %
    % See also AircraftChart, tChart


    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

        function tAttitudeMethodsUpdateAndResetTransform( testCase )

            % Record the initial transform.
            drawnow()
            initialMatrix = testCase.Chart.Transform.Matrix;

            % Verify that the attitude methods change the transform.
            roll( testCase.Chart, 10 )
            pitch( testCase.Chart, 20 )
            yaw( testCase.Chart, 30 )
            actual = testCase.Chart.Transform.Matrix;
            testCase.verifyNotEqual( actual, initialMatrix, ...
                "Calling roll(), pitch(), and yaw() did not update " + ...
                "the aircraft transform matrix." )

            % Verify that reset restores the identity transform.
            reset( testCase.Chart )
            actual = testCase.Chart.Transform.Matrix;
            testCase.verifyEqual( actual, eye( 4 ), ...
                "Calling reset() did not restore the aircraft " + ...
                "transform matrix to the identity matrix." )

        end % tAttitudeMethodsUpdateAndResetTransform

        function tAxesForwardingMethodsSetAxesProperties( testCase )

            % Verify title forwarding.
            expectedTitle = "Aircraft";
            txt = title( testCase.Chart, expectedTitle );
            testCase.verifyThat( txt.String, ...
                IsEquivalentText( expectedTitle ), "Calling title() " + ...
                "did not update the aircraft axes title." )

            % Verify box, view and axis forwarding.
            box( testCase.Chart, "off" )
            view( testCase.Chart, [30, 20] )
            axis( testCase.Chart, [-1, 1, -2, 2, -3, 3] )
            expectedBox = matlab.lang.OnOffSwitchState( "off" );
            testCase.verifyEqual( testCase.Chart.Axes.Box, ...
                expectedBox, ...
                "Calling box() did not update the axes box." )
            testCase.verifyEqual( testCase.Chart.Axes.View, [30, 20], ...
                "Calling view() did not update the axes view." )
            actualLimits = axis( testCase.Chart );
            testCase.verifyEqual( actualLimits, ...
                [-1, 1, -2, 2, -3, 3], "Calling axis() did not " + ...
                "update the axes limits." )

        end % tAxesForwardingMethodsSetAxesProperties

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

* [Aircraft Chart](../landing/AircraftChart.md)
* [Chart Reference](../ChartsIndex.md)

