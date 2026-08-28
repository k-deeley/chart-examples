classdef tCircularNetFlowChart < tChart
    %TCIRCULARNETFLOWCHART Tests for the CircularNetFlowChart class.

    % Copyright 2026 The MathWorks, Inc.

    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

    end % methods ( Test )

    methods ( Access = protected )

        function propertyNames = propertyAssignmentExclusions( ~ )

            propertyNames = "OuterLabelOffset";

        end % propertyAssignmentExclusions

    end % methods ( Access = protected )

end % classdef
