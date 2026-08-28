classdef tEdgeworthBowleyChart < tChart
    %TEDGEWORTHBOWLEYCHART Tests for the EdgeworthBowleyChart class.

    % Copyright 2026 The MathWorks, Inc.

    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

    end % methods ( Test )

    methods ( Access = protected )

        function propertyNames = propertyAssignmentExclusions( ~ )

            propertyNames = ["AData"; "BData"];

        end % propertyAssignmentExclusions

    end % methods ( Access = protected )

end % classdef
