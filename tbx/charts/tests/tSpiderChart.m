classdef tSpiderChart < tChart
    %TSPIDERCHART Tests for the SpiderChart class.

    % Copyright 2026 The MathWorks, Inc.

    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

    end % methods ( Test )

    methods ( Access = protected )

        function propertyNames = propertyAssignmentExclusions( ~ )

            propertyNames = ["Data"; "LabelText"; "LineColors"];

        end % propertyAssignmentExclusions

    end % methods ( Access = protected )

end % classdef
