# `CylinderChart` Test Class

Test file: `tCylinderChart.m`.

````text 
classdef tCylinderChart < tChart
    %TCYLINDERCHART Tests for the CylinderChart class.
    %
    % See also CylinderChart, tChart


    properties ( TestParameter )
        % Annotation methods and expected text.
        AnnotationMethod = struct( "xlabel", "xlabel", ...
            "zlabel", "zlabel", ...
            "title", "title" )
    end % properties ( TestParameter )

    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

        function tSettingDataUpdatesStackAndLayerCounts( testCase )

            % Set chart data.
            data = [1, 2, 3; 4, 5, 6];
            testCase.Chart.Data = data;
            drawnow()

            % Verify the dependent counts and stored data.
            testCase.verifyEqual( testCase.Chart.Data, data, ...
                "Setting 'Data' did not round-trip correctly." )
            testCase.verifyEqual( testCase.Chart.NumStacks, 2, ...
                "Setting 'Data' did not update 'NumStacks'." )
            testCase.verifyEqual( testCase.Chart.NumLayers, 3, ...
                "Setting 'Data' did not update 'NumLayers'." )

        end % tSettingDataUpdatesStackAndLayerCounts

        function tSettingFaceColorsUpdatesStoredColors( testCase )

            % Set data with two layers and assign one color per layer.
            testCase.Chart.Data = [1, 2; 3, 4];
            drawnow()
            expected = [1, 0, 0; 0, 0, 1];
            testCase.Chart.FaceColors = expected;
            drawnow()

            % Verify the public color property.
            testCase.verifyEqual( testCase.Chart.FaceColors, expected, ...
                "Setting 'FaceColors' did not update the stored " + ...
                "layer colors." )

        end % tSettingFaceColorsUpdatesStoredColors

        function tInvalidFaceColorsThrowException( testCase )

            % Set data with two layers.
            testCase.Chart.Data = [1, 2; 3, 4];
            drawnow()

            % Verify that one row per layer is required.
            f = @() set( testCase.Chart, "FaceColors", [1, 0, 0] );
            testCase.verifyError( f, "Cylinder:InvalidFaceColors", ...
                "Setting 'FaceColors' with the wrong number of rows " + ...
                "did not throw the expected exception." )

        end % tInvalidFaceColorsThrowException

        function tAnnotationMethodsSetCorrectText( testCase, ...
                AnnotationMethod )

            % Call the given annotation method.
            expected = "Cylinder";
            txt = feval( AnnotationMethod, testCase.Chart, expected );
            drawnow()

            % Verify that the text was set correctly.
            testCase.verifyThat( txt.String, ...
                IsEquivalentText( expected ), ...
                "Calling " + AnnotationMethod + "() did not set " + ...
                "the expected text." )

        end % tAnnotationMethodsSetCorrectText

        function tLegendMethodSetsLegendText( testCase )

            % Set data before adding a legend.
            testCase.Chart.Data = [1, 2; 3, 4];
            drawnow()

            % Verify that legend() forwards to the cylinder surfaces.
            expected = ["Layer A"; "Layer B"];
            leg = legend( testCase.Chart, expected );
            actual = leg.String(:);
            testCase.verifyThat( actual, IsEquivalentText( expected ), ...
                "Calling legend() did not set the expected legend text." )

        end % tLegendMethodSetsLegendText

    end % methods ( Test )

    methods ( Access = protected )

        function configureChartForPublicAPITests( testCase )

            testCase.Chart.Data = [1, 2; 3, 4];
            drawnow()

        end % configureChartForPublicAPITests

        function samples = publicMethodCallSamples( testCase )

            samples = publicMethodCallSamples@tChart( testCase );
            sampleNames = string( {samples.Name} ).';
            samples(sampleNames == "legend") = [];
            samples = [
                samples
                testCase.publicMethodCallSample( ...
                "legend", {["Layer A"; "Layer B"]} ) ];

        end % publicMethodCallSamples

    end % methods ( Access = protected )

end % classdef

````

## See Also

* [Cylinder Chart](../landing/CylinderChart.md)
* [Chart Examples](../../ChartExamples.md)

