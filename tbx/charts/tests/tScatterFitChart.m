classdef tScatterFitChart < tChart
    %TSCATTERFITCHART Tests for the ScatterFitChart class.

    % Copyright 2026 The MathWorks, Inc.

    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

    end % methods ( Test )
    methods ( Access = protected )

        function configureChartForPublicAPITests( testCase )

            testCase.Chart.XData = (1:5).';
            testCase.Chart.YData = [2; 3; 5; 7; 11];
            drawnow()

        end % configureChartForPublicAPITests

    end % methods ( Access = protected )

end % classdef
