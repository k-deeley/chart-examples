# `PolarChart` Test Class

Test file: `tPolarChart.m`.

````text 
classdef tPolarChart < tChart
    %TPOLARCHART Tests for the PolarChart class.
    %
    % See also PolarChart, tChart


    properties ( TestParameter )
        % Tick and tick label methods.
        TickMethod = struct( "rticks", "rticks", ...
            "thetaticks", "thetaticks", ...
            "rticklabels", "rticklabels", ...
            "thetaticklabels", "thetaticklabels" )
    end % properties ( TestParameter )

    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

        function tSettingAngularDataResizesRadialData( testCase )

            % Start with four polar samples.
            testCase.Chart.AngularData = (1:4).';
            testCase.Chart.RadialData = [(1:4).', (4:-1:1).'];
            drawnow()

            % Shorten angular data and verify radial data is truncated.
            testCase.Chart.AngularData = (1:2).';
            drawnow()
            testCase.verifyThat( testCase.Chart.RadialData(:, 1), ...
                IsEqualVector( [1; 2] ), "Shortening " + ...
                "'AngularData' did not truncate 'RadialData'." )

        end % tSettingAngularDataResizesRadialData

        function tSettingRadialDataTruncatesAngularData( testCase )

            % Start with four angular samples.
            testCase.Chart.AngularData = (1:4).';
            testCase.Chart.RadialData = [(1:4).', (4:-1:1).'];
            drawnow()

            % Shorten radial data and verify angular data is truncated.
            testCase.Chart.RadialData = [(1:2).', (2:-1:1).'];
            drawnow()
            testCase.verifyThat( testCase.Chart.AngularData, ...
                IsEqualVector( [1; 2] ), "Shortening " + ...
                "'RadialData' did not truncate 'AngularData'." )

        end % tSettingRadialDataTruncatesAngularData

        function tTickMethodsSetCorrectValues( testCase, TickMethod )

            % Call the given tick method.
            if endsWith( TickMethod, "labels" )
                expected = ["A", "B", "C"];
            else
                expected = [0, 1, 2];
            end % if
            feval( TickMethod, testCase.Chart, expected )
            drawnow()

            % Verify that the value has been set correctly.
            actual = feval( TickMethod, testCase.Chart );
            if endsWith( TickMethod, "labels" )
                actual = actual(1:numel( expected ));
                testCase.verifyThat( actual, ...
                    IsEquivalentText( expected ), "Calling " + ...
                    TickMethod + "() did not set the expected labels." )
            else
                testCase.verifyThat( actual, IsEqualVector( expected ), ...
                    "Calling " + TickMethod + "() did not set the " + ...
                    "expected tick values." )
            end % if

        end % tTickMethodsSetCorrectValues

    end % methods ( Test )

    methods ( Access = protected )

        function configureChartForPublicAPITests( testCase )

            testCase.Chart.AngularData = (1:4).';
            testCase.Chart.RadialData = [(1:4).', (4:-1:1).'];
            drawnow()

        end % configureChartForPublicAPITests

    end % methods ( Access = protected )

end % classdef

````

## See Also

* [Polar Chart](../landing/PolarChart.md)
* [Chart Examples](../../ChartExamples.md)

