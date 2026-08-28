# `LineGradientChart` Test Class

Test file: `tLineGradientChart.m`.

````text 
classdef tLineGradientChart < tChart
    %TLINEGRADIENTCHART Tests for the LineGradientChart class.
    %
    % See also LineGradientChart, tChart


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

            % Start with four data points.
            testCase.Chart.YData = [1; 2; 3; 4];
            testCase.Chart.XData = datetime( 2026, 1, 1:4 ).';
            drawnow()

            % Shorten XData and verify YData is truncated.
            expectedX = datetime( 2026, 1, 1:2 ).';
            testCase.Chart.XData = expectedX;
            drawnow()
            testCase.verifyEqual( testCase.Chart.XData, expectedX, ...
                "Setting 'XData' did not round-trip correctly." )
            testCase.verifyThat( testCase.Chart.YData, ...
                IsEqualVector( [1; 2] ), "Shortening 'XData' did " + ...
                "not truncate 'YData' to the same length." )

        end % tSettingXDataResizesYData

        function tSettingYDataResizesXData( testCase )

            % Start with two x-values.
            testCase.Chart.XData = datetime( 2026, 1, 1:2 ).';
            drawnow()

            % Lengthen YData and verify XData is padded with NaT.
            testCase.Chart.YData = [1; 2; 3];
            drawnow()
            testCase.verifyNumElements( testCase.Chart.XData, 3, ...
                "Lengthening 'YData' did not resize 'XData'." )
            testCase.verifyTrue( isnat( testCase.Chart.XData(end) ), ...
                "Lengthening 'YData' did not pad 'XData' with NaT." )

        end % tSettingYDataResizesXData

        function tDecreasingXDataThrowsException( testCase )

            % Verify that x-data must be sorted.
            f = @() set( testCase.Chart, "XData", ...
                datetime( 2026, 1, [2, 1] ).' );
            testCase.verifyError( f, ...
                "LineGradientChart:DecreasingData", ...
                "Setting decreasing 'XData' did not throw the " + ...
                "expected exception." )

        end % tDecreasingXDataThrowsException

        function tAnnotationMethodsSetCorrectText( testCase, ...
                AnnotationMethod )

            % Call the given annotation method.
            expected = "Gradient";
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

            testCase.Chart.XData = datetime( 2026, 1, 1:4 ).';
            testCase.Chart.YData = [1; 3; 2; 4];
            drawnow()

        end % configureChartForPublicAPITests

    end % methods ( Access = protected )

end % classdef

````

## See Also

* [Line Gradient Chart](../landing/LineGradientChart.md)
* [Chart Reference](../ChartsIndex.md)

