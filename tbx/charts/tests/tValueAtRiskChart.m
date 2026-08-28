classdef tValueAtRiskChart < tChart
    %TVALUEATRISKCHART Tests for the ValueAtRiskChart class.

    % Copyright 2026 The MathWorks, Inc.

    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

    end % methods ( Test )
    methods ( Access = protected )

        function configureChartForPublicAPITests( testCase )

            testCase.Chart.Data = (-10:10).' / 100;
            drawnow()

        end % configureChartForPublicAPITests

    end % methods ( Access = protected )

end % classdef
