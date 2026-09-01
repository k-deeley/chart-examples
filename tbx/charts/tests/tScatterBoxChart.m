classdef tScatterBoxChart < tChart
    %TSCATTERBOXCHART Tests for the ScatterBoxChart class.
    %
    % See also ScatterBoxChart, tChart

    % Copyright 2026 The MathWorks, Inc.

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

        function tScatterPropertiesRoundTrip( testCase )

            % Set scatter style properties.
            testCase.Chart.ScatterSizeData = 48;
            testCase.Chart.ScatterCData = [1, 0, 0];
            testCase.Chart.ScatterMarker = "x";
            testCase.Chart.FilledScatterMarkers = "on";
            testCase.Chart.VariableSizeScatterMarkers = "off";
            drawnow()

            % Verify public style state.
            testCase.verifyEqual( testCase.Chart.ScatterSizeData, 48, ...
                "Setting 'ScatterSizeData' did not round-trip." )
            testCase.verifyEqual( testCase.Chart.ScatterCData, ...
                [1, 0, 0], "Setting 'ScatterCData' did not " + ...
                "normalize to RGB." )
            testCase.verifyThat( testCase.Chart.ScatterMarker, ...
                IsEquivalentText( "x" ), ...
                "Setting 'ScatterMarker' did not round-trip." )
            testCase.verifyTrue( ...
                testCase.Chart.FilledScatterMarkers, ...
                "Setting 'FilledScatterMarkers' did not round-trip." )
            testCase.verifyFalse( ...
                testCase.Chart.VariableSizeScatterMarkers, ...
                "Setting 'VariableSizeScatterMarkers' did not " + ...
                "round-trip." )

        end % tScatterPropertiesRoundTrip

        function tBoxPropertiesRoundTrip( testCase )

            % Set boxchart style properties.
            testCase.Chart.BoxFaceColor = "g";
            testCase.Chart.WhiskerLineStyle = "--";
            testCase.Chart.WhiskerLineColor = "b";
            testCase.Chart.BoxMarkerColor = "r";
            testCase.Chart.BoxMarkerSize = 8;
            testCase.Chart.BoxMarker = "x";
            testCase.Chart.BoxLineWidth = 2;
            drawnow()

            % Verify public style state.
            testCase.verifyEqual( testCase.Chart.BoxFaceColor, ...
                [0, 1, 0], "Setting 'BoxFaceColor' did not " + ...
                "normalize to RGB." )
            testCase.verifyThat( testCase.Chart.WhiskerLineStyle, ...
                IsEquivalentText( "--" ), ...
                "Setting 'WhiskerLineStyle' did not round-trip." )
            testCase.verifyEqual( testCase.Chart.WhiskerLineColor, ...
                [0, 0, 1], "Setting 'WhiskerLineColor' did not " + ...
                "normalize to RGB." )
            testCase.verifyEqual( testCase.Chart.BoxMarkerColor, ...
                [1, 0, 0], "Setting 'BoxMarkerColor' did not " + ...
                "normalize to RGB." )
            testCase.verifyEqual( testCase.Chart.BoxMarkerSize, 8, ...
                "Setting 'BoxMarkerSize' did not round-trip." )
            testCase.verifyThat( testCase.Chart.BoxMarker, ...
                IsEquivalentText( "x" ), ...
                "Setting 'BoxMarker' did not round-trip." )
            testCase.verifyEqual( testCase.Chart.BoxLineWidth, 2, ...
                "Setting 'BoxLineWidth' did not round-trip." )

        end % tBoxPropertiesRoundTrip

        function tAnnotationMethodsSetCorrectText( testCase, ...
                AnnotationMethod )

            % Call the given annotation method.
            expected = "Scatter Box";
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
