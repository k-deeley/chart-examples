classdef tSankeyChart < tChart
    %TSANKEYCHART Tests for the SankeyChart class.

    % Copyright 2026 The MathWorks, Inc.

    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

    end % methods ( Test )

    methods ( Access = protected )

        function propertyNames = propertyAssignmentExclusions( ~ )

            propertyNames = ["GraphData"; "NodePadRatio"];

        end % propertyAssignmentExclusions

    end % methods ( Access = protected )

end % classdef
