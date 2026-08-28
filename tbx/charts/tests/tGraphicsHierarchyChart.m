classdef tGraphicsHierarchyChart < tChart
    %TGRAPHICSHIERARCHYCHART Tests for GraphicsHierarchyChart.

    % Copyright 2026 The MathWorks, Inc.

    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

    end % methods ( Test )
end % classdef
