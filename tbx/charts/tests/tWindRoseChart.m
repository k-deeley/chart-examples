classdef tWindRoseChart < tChart
    %TWINDROSECHART Tests for the WindRoseChart class.

    % Copyright 2026 The MathWorks, Inc.

    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

    end % methods ( Test )

    methods ( Access = protected )

        function propertyNames = propertyAssignmentExclusions( ~ )

            propertyNames = ["WindData"; "SpeedBinEdges"; ...
                "RadialLabelDirection"];

        end % propertyAssignmentExclusions

    end % methods ( Access = protected )

end % classdef
