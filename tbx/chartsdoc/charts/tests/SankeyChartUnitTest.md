# `SankeyChart` Test Class

Test file: `tSankeyChart.m`.

````text 
classdef tSankeyChart < tChart
    %TSANKEYCHART Tests for the SankeyChart class.
    %
    % See also SankeyChart, tChart


    properties ( TestParameter )
        % Label properties and values.
        LabelProperty = struct( ...
            "LabelAlignment", ["LabelAlignment", "right"], ...
            "NodeLabelInterpreter", ["NodeLabelInterpreter", "none"] )
    end % properties ( TestParameter )

    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

        function tSettingGraphDataStoresWeightsAndNodePositions( testCase )

            % Set a simple weighted graph.
            graphData = testCase.graphData();
            testCase.Chart.GraphData = graphData;
            drawnow()

            % Verify graph data and computed node coordinates.
            actual = testCase.Chart.GraphData.Edges.Weight;
            testCase.verifyEqual( actual, ...
                [2; 1; 3], "Setting 'GraphData' did not preserve " + ...
                "edge weights." )
            testCase.verifyNumElements( testCase.Chart.XNodeData, 3, ...
                "Setting 'GraphData' did not update 'XNodeData'." )
            testCase.verifyNumElements( testCase.Chart.YNodeData, 3, ...
                "Setting 'GraphData' did not update 'YNodeData'." )

        end % tSettingGraphDataStoresWeightsAndNodePositions

        function tGraphWithoutWeightsAddsUnitWeights( testCase )

            % Set a graph without an edge weight column.
            graphData = digraph( ["A"; "B"], ["B"; "C"] );
            testCase.Chart.GraphData = graphData;
            drawnow()

            % Verify that default unit weights were added.
            actual = testCase.Chart.GraphData.Edges.Weight;
            testCase.verifyEqual( actual, ...
                ones( 2, 1 ), "Setting an unweighted graph did not " + ...
                "add unit edge weights." )

        end % tGraphWithoutWeightsAddsUnitWeights

        function tLabelPropertyUpdatesChart( testCase, LabelProperty )

            % Unpack.
            propertyName = LabelProperty(1);
            expected = LabelProperty(2);

            % Set and verify the label property.
            testCase.Chart.(propertyName) = expected;
            drawnow()
            testCase.verifyThat( testCase.Chart.(propertyName), ...
                IsEquivalentText( expected ), "Setting '" + ...
                propertyName + "' did not " + ...
                "round-trip correctly." )

        end % tLabelPropertyUpdatesChart

        function tStylePropertiesRoundTrip( testCase )

            % Set style properties.
            testCase.Chart.LinkAlpha = 0.25;
            testCase.Chart.NodeAlpha = 0.75;
            testCase.Chart.NodeWidth = 0.1;
            testCase.Chart.LinkType = "line";
            testCase.Chart.NodeLabelVisible = "off";
            drawnow()

            % Verify public style state.
            testCase.verifyEqual( testCase.Chart.LinkAlpha, 0.25, ...
                "Setting 'LinkAlpha' did not round-trip." )
            testCase.verifyEqual( testCase.Chart.NodeAlpha, 0.75, ...
                "Setting 'NodeAlpha' did not round-trip." )
            testCase.verifyEqual( testCase.Chart.NodeWidth, 0.1, ...
                "Setting 'NodeWidth' did not round-trip." )
            testCase.verifyThat( testCase.Chart.LinkType, ...
                IsEquivalentText( "line" ), ...
                "Setting 'LinkType' did not round-trip." )
            expected = matlab.lang.OnOffSwitchState( "off" );
            testCase.verifyEqual( testCase.Chart.NodeLabelVisible, ...
                expected, ...
                "Setting 'NodeLabelVisible' did not round-trip." )

        end % tStylePropertiesRoundTrip

    end % methods ( Test )

    methods ( Access = protected )

        function configureChartForPublicAPITests( testCase )

            testCase.Chart.GraphData = testCase.graphData();
            drawnow()

        end % configureChartForPublicAPITests

        function propertyNames = propertyAssignmentExclusions( ~ )

            propertyNames = ["GraphData"; "NodePadRatio"];

        end % propertyAssignmentExclusions

    end % methods ( Access = protected )

    methods ( Access = private )

        function graphData = graphData( ~ )

            graphData = digraph( ["A"; "A"; "B"], ...
                ["B"; "C"; "C"], [2; 1; 3] );

        end % graphData

    end % methods ( Access = private )

end % classdef

````

## See Also

* [Sankey Chart](../landing/SankeyChart.md)
* [Chart Examples](../../ChartExamples.md)

