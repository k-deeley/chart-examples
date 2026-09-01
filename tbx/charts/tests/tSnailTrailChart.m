classdef tSnailTrailChart < tChart
    %TSNAILTRAILCHART Tests for the SnailTrailChart class.
    %
    % See also SnailTrailChart, tChart

    % Copyright 2026 The MathWorks, Inc.

    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

        function tSettingReturnsUpdatesPerformanceStatistics( testCase )

            % Set deterministic returns.
            returns = testCase.returnsData();
            testCase.Chart.Returns = returns;
            testCase.Chart.Period = 4;
            drawnow()

            % Verify the derived statistics table height.
            expectedHeight = height( returns ) - testCase.Chart.Period + 1;
            testCase.verifyEqual( ...
                height( testCase.Chart.PerformanceStatistics ), ...
                expectedHeight, "Setting 'Returns' did not update " + ...
                "'PerformanceStatistics' to the expected height." )
            testCase.verifyEqual( testCase.Chart.CurrentIndex, 1, ...
                "Setting 'Returns' did not rewind 'CurrentIndex'." )

        end % tSettingReturnsUpdatesPerformanceStatistics

        function tStepAndRewindUpdateCurrentIndex( testCase )

            % Configure deterministic state.
            testCase.Chart.Returns = testCase.returnsData();
            testCase.Chart.Period = 4;
            testCase.Chart.TrailLength = 3;
            drawnow()

            % Step forward and back.
            step( testCase.Chart, 2 )
            testCase.verifyEqual( testCase.Chart.CurrentIndex, 3, ...
                "Calling step() did not advance 'CurrentIndex'." )
            step( testCase.Chart, -1 )
            testCase.verifyEqual( testCase.Chart.CurrentIndex, 2, ...
                "Calling step() with a negative value did not move " + ...
                "'CurrentIndex' backward." )

            % Rewind.
            rewind( testCase.Chart )
            testCase.verifyEqual( testCase.Chart.CurrentIndex, 1, ...
                "Calling rewind() did not restore 'CurrentIndex' " + ...
                "to 1." )

        end % tStepAndRewindUpdateCurrentIndex

        function tSettingCurrentDateUpdatesCurrentIndex( testCase )

            % Configure deterministic state.
            testCase.Chart.Returns = testCase.returnsData();
            testCase.Chart.Period = 4;
            drawnow()

            % Select the second available date.
            expectedDate = testCase.Chart.PerformanceStatistics. ...
                PeriodEndDate(2);
            testCase.Chart.CurrentDate = expectedDate;
            testCase.verifyEqual( testCase.Chart.CurrentIndex, 2, ...
                "Setting 'CurrentDate' did not update " + ...
                "'CurrentIndex'." )
            testCase.verifyEqual( testCase.Chart.CurrentDate, ...
                expectedDate, "Setting 'CurrentDate' did not " + ...
                "round-trip correctly." )

        end % tSettingCurrentDateUpdatesCurrentIndex

        function tInvalidCurrentIndexThrowsException( testCase )

            % Configure deterministic state.
            testCase.Chart.Returns = testCase.returnsData();
            testCase.Chart.Period = 4;
            drawnow()

            % Verify current index bounds.
            f = @() set( testCase.Chart, "CurrentIndex", 100 );
            testCase.verifyError( f, "SnailTrail:InvalidCurrentIndex", ...
                "Setting an out-of-range 'CurrentIndex' did not " + ...
                "throw the expected exception." )

        end % tInvalidCurrentIndexThrowsException

    end % methods ( Test )
    methods ( Access = protected )

        function configureChartForPublicAPITests( testCase )

            testCase.Chart.Returns = testCase.returnsData();
            testCase.Chart.Period = 4;
            testCase.Chart.TrailLength = 5;
            testCase.Chart.CurrentIndex = 1;
            drawnow()

        end % configureChartForPublicAPITests

        function propertyNames = propertyAssignmentExclusions( ~ )

            propertyNames = ["Returns"; "TrailLength"; ...
                "CurrentIndex"; "CurrentDate"; "Period"];

        end % propertyAssignmentExclusions

        function samples = chartSpecificPublicMethodCallSamples( ...
                testCase )

            samples = [
                testCase.publicMethodCallSample( "animate" )
                testCase.publicMethodCallSample( "rewind" )
                testCase.publicMethodCallSample( "step", {1} ) ];

        end % chartSpecificPublicMethodCallSamples

    end % methods ( Access = protected )

    methods ( Access = private )

        function returns = returnsData( ~ )

            date = datetime( 2026, 1, 1:12 ).';
            asset = linspace( 0.01, 0.12, 12 ).';
            benchmark = linspace( 0.005, 0.06, 12 ).';
            returns = timetable( date, asset, benchmark );

        end % returnsData

    end % methods ( Access = private )

end % classdef
