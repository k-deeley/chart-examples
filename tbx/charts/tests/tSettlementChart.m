classdef tSettlementChart < tChart
    %TSETTLEMENTCHART Tests for the SettlementChart class.

    % Copyright 2026 The MathWorks, Inc.

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
