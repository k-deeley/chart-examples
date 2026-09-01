# `EdgeworthBowleyChart` Test Class

Test file: `tEdgeworthBowleyChart.m`.

````text 
classdef tEdgeworthBowleyChart < tChart
    %TEDGEWORTHBOWLEYCHART Tests for the EdgeworthBowleyChart class.
    %
    % See also EdgeworthBowleyChart, tChart


    properties ( TestParameter )
        % Annotation methods.
        AnnotationMethod = struct( "xlabel", "xlabel", ...
            "ylabel", "ylabel", ...
            "title", "title" )
    end % properties ( TestParameter )

    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

        function tSettingADataUpdatesQuantities( testCase )

            % Set A-data with known terminal quantity values.
            data = [0, 0.4; 1, 0.7; 2, 1.0];
            testCase.Chart.AData = data;
            drawnow()

            % Verify public derived state.
            testCase.verifyEqual( testCase.Chart.AData, data, ...
                "Setting 'AData' did not round-trip correctly." )
            testCase.verifyEqual( testCase.Chart.Quantity1, 2, ...
                "Setting 'AData' did not update 'Quantity1'." )
            testCase.verifyEqual( testCase.Chart.Quantity2, 1, ...
                "Setting 'AData' did not update 'Quantity2'." )

        end % tSettingADataUpdatesQuantities

        function tSettingBDataResizesAData( testCase )

            % Set A-data and then shorter B-data.
            testCase.Chart.AData = [0, 0.4; 1, 0.7; 2, 1.0];
            testCase.Chart.BData = [0, 1.0; 1, 0.6];
            drawnow()

            % Verify that A-data is truncated to match B-data height.
            testCase.verifySize( testCase.Chart.AData, [2, 2], ...
                "Setting shorter 'BData' did not truncate 'AData'." )
            testCase.verifyEqual( testCase.Chart.Quantity1, 1, ...
                "Setting 'BData' did not update 'Quantity1'." )

        end % tSettingBDataResizesAData

        function tStylePropertiesRoundTrip( testCase )

            % Set style properties.
            testCase.Chart.LineWidth = 3;
            testCase.Chart.LineColor = [1, 0, 0];
            testCase.Chart.MarkerSize = 12;
            drawnow()

            % Verify public style state.
            testCase.verifyEqual( testCase.Chart.LineWidth, 3, ...
                "Setting 'LineWidth' did not round-trip." )
            testCase.verifyEqual( testCase.Chart.LineColor, [1, 0, 0], ...
                "Setting 'LineColor' did not normalize to RGB." )
            testCase.verifyEqual( testCase.Chart.MarkerSize, 12, ...
                "Setting 'MarkerSize' did not round-trip." )

        end % tStylePropertiesRoundTrip

        function tAnnotationMethodsSetCorrectText( testCase, ...
                AnnotationMethod )

            % Call the given annotation method.
            expected = "Edgeworth";
            txt = feval( AnnotationMethod, testCase.Chart, expected );
            drawnow()

            % Verify that the text was set correctly.
            testCase.verifyThat( txt.String, ...
                IsEquivalentText( expected ), ...
                "Calling " + AnnotationMethod + "() did not set " + ...
                "the expected text." )

        end % tAnnotationMethodsSetCorrectText

    end % methods ( Test )

    methods ( Access = protected )

        function configureChartForPublicAPITests( testCase )

            testCase.Chart.AData = [0, 0.4; 1, 0.7; 2, 1.0];
            testCase.Chart.BData = [0, 1.0; 1, 0.6; 2, 0.2];
            drawnow()

        end % configureChartForPublicAPITests

        function propertyNames = propertyAssignmentExclusions( ~ )

            propertyNames = ["AData"; "BData"];

        end % propertyAssignmentExclusions

    end % methods ( Access = protected )

end % classdef

````

## See Also

* [Edgeworth Bowley Chart](../landing/EdgeworthBowleyChart.md)
* [Chart Examples](../../ChartExamples.md)

