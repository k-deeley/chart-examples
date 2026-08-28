classdef tLineGradientChart < tChart
    %TLINEGRADIENTCHART Tests for the LineGradientChart class.

    % Copyright 2026 The MathWorks, Inc.

    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

    end % methods ( Test )
    methods ( Access = protected )

        function configureChartForPublicAPITests( testCase )

            testCase.Chart.XData = datetime( 2026, 1, 1:4 ).';
            testCase.Chart.YData = [1; 3; 2; 4];
            drawnow()

        end % configureChartForPublicAPITests

    end % methods ( Access = protected )

end % classdef
