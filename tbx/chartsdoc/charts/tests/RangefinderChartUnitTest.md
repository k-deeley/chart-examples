# `RangefinderChart` Test Class

Test file: `tRangefinderChart.m`.

````text 
classdef tRangefinderChart < tChart
    %TRANGEFINDERCHART Tests for the RangefinderChart class.
    %
    % See also RangefinderChart, tChart


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

        function tChangingDataLengthResetsVectorStyleData( testCase )

            % Set vector size and color data.
            testCase.Chart.XData = (1:4).';
            testCase.Chart.YData = (4:-1:1).';
            testCase.Chart.SizeData = (10:10:40).';
            testCase.Chart.CData = [1, 0, 0; 0, 1, 0; ...
                0, 0, 1; 0, 0, 0];
            drawnow()

            % Change the data length and verify style data is scalarized.
            testCase.Chart.XData = (1:3).';
            drawnow()
            testCase.verifyEqual( testCase.Chart.SizeData, 36, ...
                "Changing the data length did not reset vector " + ...
                "'SizeData' to the scalar default." )
            testCase.verifySize( testCase.Chart.CData, [1, 3], ...
                "Changing the data length did not reset vector " + ...
                "'CData' to a single color." )

        end % tChangingDataLengthResetsVectorStyleData

        function tAnnotationMethodsSetCorrectText( testCase, ...
                AnnotationMethod )

            % Call the given annotation method.
            expected = "Rangefinder";
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

* [Rangefinder Chart](../landing/RangefinderChart.md)
* [Chart Reference](../ChartsIndex.md)

