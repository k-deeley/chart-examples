classdef tSnailTrailChart < tChart
    %TSNAILTRAILCHART Tests for the SnailTrailChart class.

    % Copyright 2026 The MathWorks, Inc.

    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

    end % methods ( Test )
    methods ( Access = protected )

        function configureChartForPublicAPITests( testCase )

            date = datetime( 2026, 1, 1:12 ).';
            asset = linspace( 0.01, 0.12, 12 ).';
            benchmark = linspace( 0.005, 0.06, 12 ).';
            testCase.Chart.Returns = timetable( date, asset, benchmark );
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

end % classdef
