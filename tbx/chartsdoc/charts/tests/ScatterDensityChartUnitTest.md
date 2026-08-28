# `ScatterDensityChart` Test Class

Test file: `tScatterDensityChart.m`.

````text 
classdef tScatterDensityChart < tChart
    %TSCATTERDENSITYCHART Tests for ScatterDensityChart.
    %
    % See also ScatterDensityChart, tChart


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

        function tSettingXDataResizesYData( testCase )

            % Start with four points.
            testCase.Chart.YData = [4; 3; 2; 1];
            testCase.Chart.XData = [1; 2; 3; 4];
            drawnow()

            % Shorten x-data and verify y-data follows.
            testCase.Chart.XData = [1; 2];
            drawnow()
            testCase.verifyThat( testCase.Chart.YData, ...
                IsEqualVector( [4; 3] ), "Shortening 'XData' " + ...
                "did not truncate 'YData'." )

        end % tSettingXDataResizesYData

        function tDensityPropertiesRoundTrip( testCase )

            % Set density-related properties.
            testCase.Chart.XData = (1:5).';
            testCase.Chart.YData = [2; 3; 5; 7; 11];
            drawnow()
            testCase.Chart.Radius = 2;
            testCase.Chart.DensityMethod = "boundary";
            drawnow()
            testCase.Chart.CLim = [0, 5];
            drawnow()

            % Verify public state.
            testCase.verifyEqual( testCase.Chart.Radius, 2, ...
                "Setting 'Radius' did not round-trip correctly." )
            testCase.verifyEqual( testCase.Chart.DensityMethod, ...
                "boundary", "Setting 'DensityMethod' did not " + ...
                "round-trip correctly." )
            testCase.verifyEqual( testCase.Chart.CLim, [0, 5], ...
                "Setting 'CLim' did not round-trip correctly." )

        end % tDensityPropertiesRoundTrip

        function tAnnotationMethodsSetCorrectText( testCase, ...
                AnnotationMethod )

            % Call the given annotation method.
            expected = "Density";
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

            testCase.Chart.XData = (1:5).';
            testCase.Chart.YData = [2; 3; 5; 7; 11];
            drawnow()

        end % configureChartForPublicAPITests

    end % methods ( Access = protected )

end % classdef

````

## See Also

* [Scatter Density Chart](../landing/ScatterDensityChart.md)
* [Chart Reference](../ChartsIndex.md)

