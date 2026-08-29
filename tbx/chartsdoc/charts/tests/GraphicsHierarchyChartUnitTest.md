# `GraphicsHierarchyChart` Test Class

Test file: `tGraphicsHierarchyChart.m`.

````text 
classdef tGraphicsHierarchyChart < tChart
    %TGRAPHICSHIERARCHYCHART Tests for GraphicsHierarchyChart.
    %
    % See also GraphicsHierarchyChart, tChart


    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

        function tRootObjectUpdatesGraphPlot( testCase )

            % Create a small graphics hierarchy to visualize.
            fig = figure( "Visible", "off" );
            testCase.addTeardown( @() delete( fig ) )
            ax = axes( "Parent", fig );
            line( ax, 1:3, 1:3 )

            % Set the root object and verify a graph is rendered.
            testCase.Chart.RootObject = fig;
            drawnow()
            testCase.verifySameHandle( testCase.Chart.RootObject, fig, ...
                "Setting 'RootObject' did not update the stored " + ...
                "graphics object." )
            testCase.verifyGreaterThanOrEqual( ...
                numel( testCase.Chart.GraphPlot.XData ), 2, ...
                "Setting 'RootObject' did not render the expected " + ...
                "graphics hierarchy." )

        end % tRootObjectUpdatesGraphPlot

        function tShowNodeLabelsUpdatesGraphPlotLabels( testCase )

            % Use the test figure as the root object.
            testCase.Chart.RootObject = testCase.Figure;
            drawnow()

            % Toggle node labels off and verify the graph plot labels.
            testCase.Chart.ShowNodeLabels = "off";
            drawnow()
            testCase.verifyEmpty( testCase.Chart.GraphPlot.NodeLabel, ...
                "Setting 'ShowNodeLabels' to 'off' did not clear " + ...
                "the graph plot node labels." )

            % Toggle node labels on and verify labels are restored.
            testCase.Chart.ShowNodeLabels = "on";
            drawnow()
            actual = testCase.Chart.GraphPlot.NodeLabel;
            testCase.verifyNotEmpty( actual, ...
                "Setting 'ShowNodeLabels' to 'on' did not restore " + ...
                "the graph plot node labels." )

        end % tShowNodeLabelsUpdatesGraphPlotLabels

        function tTitleMethodSetsCorrectText( testCase )

            % Call the title method.
            expected = "Graphics";
            txt = title( testCase.Chart, expected );
            drawnow()

            % Verify that the text was set correctly.
            testCase.verifyThat( txt.String, ...
                IsEquivalentText( expected ), ...
                "Calling title() did not set the expected text." )

        end % tTitleMethodSetsCorrectText

    end % methods ( Test )

    methods ( Access = protected )

        function configureChartForPublicAPITests( testCase )

            testCase.Chart.RootObject = testCase.Figure;
            drawnow()

        end % configureChartForPublicAPITests

    end % methods ( Access = protected )

end % classdef

````

## See Also

* [Graphics Hierarchy Chart](../landing/GraphicsHierarchyChart.md)
* [Chart Examples](../../ChartExamples.md)

