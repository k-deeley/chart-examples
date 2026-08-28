classdef tCircularNetFlowChart < tChart
    %TCIRCULARNETFLOWCHART Tests for the CircularNetFlowChart class.
    %
    % See also CircularNetFlowChart, tChart

    % Copyright 2026 The MathWorks, Inc.

    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

        function tSettingLinkDataUpdatesDerivedFlowTables( testCase )

            % Set link data with asymmetric directed flows.
            linkData = testCase.linkData();
            testCase.Chart.LinkData = linkData;
            drawnow()

            % Verify labels and derived flow values.
            testCase.verifyEqual( testCase.Chart.Labels, ...
                ["A", "B", "C"], "Setting 'LinkData' did not " + ...
                "update the chart labels correctly." )
            expectedNetFlow = [0, 3, -2; -3, 0, 3; 2, -3, 0];
            testCase.verifyEqual( testCase.Chart.NetFlow.Variables, ...
                expectedNetFlow, "Setting 'LinkData' did not " + ...
                "update the net flow table correctly." )
            testCase.verifyEqual( testCase.Chart.NetSent, [3; 3; 2], ...
                "Setting 'LinkData' did not update 'NetSent'." )
            testCase.verifyEqual( testCase.Chart.NetReceived, ...
                [2; 3; 3], "Setting 'LinkData' did not update " + ...
                "'NetReceived'." )

        end % tSettingLinkDataUpdatesDerivedFlowTables

        function tOuterLabelOffsetRoundTripsAfterDataIsSet( testCase )

            % Set chart data so the outer labels exist.
            testCase.Chart.LinkData = testCase.linkData();
            drawnow()

            % Verify that the offset property can be set and read.
            expected = 20;
            testCase.Chart.OuterLabelOffset = expected;
            actual = testCase.Chart.OuterLabelOffset;
            testCase.verifyEqual( actual, expected, ...
                "Setting 'OuterLabelOffset' did not update the " + ...
                "stored chart property." )

        end % tOuterLabelOffsetRoundTripsAfterDataIsSet

        function tLabelVisibilityAndFaceAlphaRoundTrip( testCase )

            % Set non-default visible style properties.
            testCase.Chart.FaceAlpha = 0.25;
            testCase.Chart.ShowLabels = "off";
            drawnow()

            % Verify the public style state.
            testCase.verifyEqual( testCase.Chart.FaceAlpha, 0.25, ...
                "Setting 'FaceAlpha' did not round-trip correctly." )
            expected = matlab.lang.OnOffSwitchState( "off" );
            testCase.verifyEqual( testCase.Chart.ShowLabels, ...
                expected, "Setting 'ShowLabels' did not round-trip " + ...
                "correctly." )

        end % tLabelVisibilityAndFaceAlphaRoundTrip

    end % methods ( Test )

    methods ( Access = protected )

        function configureChartForPublicAPITests( testCase )

            testCase.Chart.LinkData = testCase.linkData();
            drawnow()

        end % configureChartForPublicAPITests

        function propertyNames = propertyAssignmentExclusions( ~ )

            propertyNames = "OuterLabelOffset";

        end % propertyAssignmentExclusions

    end % methods ( Access = protected )

    methods ( Access = private )

        function linkData = linkData( ~ )

            linkData = array2table( ...
                [0, 5, 1; 2, 0, 4; 3, 1, 0], ...
                "VariableNames", ["A", "B", "C"] );

        end % linkData

    end % methods ( Access = private )

end % classdef
