# `ClockChart` Test Class

Test file: `tClockChart.m`.

````text 
classdef tClockChart < tChart
    %TCLOCKCHART Tests for the ClockChart class.
    %
    % See also ClockChart, tChart


    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

        function tShowNumbersUpdatesClockNumberVisibility( testCase )

            % Hide the clock numbers.
            testCase.Chart.ShowNumbers = "off";
            drawnow()
            actual = [testCase.Chart.ClockNumbers.Visible];
            expected = repmat( matlab.lang.OnOffSwitchState( "off" ), ...
                size( actual ) );
            testCase.verifyEqual( actual, expected, ...
                "Setting 'ShowNumbers' to 'off' did not hide the " + ...
                "clock number labels." )

            % Show the clock numbers.
            testCase.Chart.ShowNumbers = "on";
            drawnow()
            actual = [testCase.Chart.ClockNumbers.Visible];
            expected = repmat( matlab.lang.OnOffSwitchState( "on" ), ...
                size( actual ) );
            testCase.verifyEqual( actual, expected, ...
                "Setting 'ShowNumbers' to 'on' did not show the " + ...
                "clock number labels." )

        end % tShowNumbersUpdatesClockNumberVisibility

    end % methods ( Test )
end % classdef

````

## See Also

* [Clock Chart](../landing/ClockChart.md)
* [Chart Examples](../../ChartExamples.md)

