classdef tSignalTraceChart < tChart
    %TSIGNALTRACECHART Tests for the SignalTraceChart class.
    %
    % See also SignalTraceChart, tChart

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

        function tSettingTimeResizesSignalData( testCase )

            % Start with four samples and two signals.
            testCase.Chart.Time = (1:4).';
            testCase.Chart.SignalData = [(1:4).', (4:-1:1).'];
            drawnow()

            % Shorten time and verify signal data is truncated.
            testCase.Chart.Time = (1:2).';
            drawnow()
            testCase.verifyThat( testCase.Chart.SignalData(:, 1), ...
                IsEqualVector( [1; 2] ), "Shortening 'Time' did " + ...
                "not truncate 'SignalData' to the same height." )

        end % tSettingTimeResizesSignalData

        function tSettingSignalDataTruncatesTime( testCase )

            % Start with four time samples.
            testCase.Chart.Time = (1:4).';
            testCase.Chart.SignalData = [(1:4).', (4:-1:1).'];
            drawnow()

            % Shorten signal data and verify time is truncated.
            testCase.Chart.SignalData = [(1:2).', (2:-1:1).'];
            drawnow()
            testCase.verifyThat( testCase.Chart.Time, ...
                IsEqualVector( [1; 2] ), "Shortening " + ...
                "'SignalData' did not truncate 'Time'." )

        end % tSettingSignalDataTruncatesTime

        function tAnnotationMethodsSetCorrectText( testCase, ...
                AnnotationMethod )

            % Call the given annotation method.
            expected = "Signal Trace";
            txt = feval( AnnotationMethod, testCase.Chart, expected );
            drawnow()

            % Verify that the text was set correctly.
            testCase.verifyThat( txt.String, ...
                IsEquivalentText( expected ), ...
                "Calling " + AnnotationMethod + "() did not set " + ...
                "the expected text." )

        end % tAnnotationMethodsSetCorrectText

        function tDecreasingTimeThrowsException( testCase )

            % Verify that time data must be increasing.
            f = @() set( testCase.Chart, "Time", [2; 1] );
            testCase.verifyError( f, "MATLAB:expectedIncreasing", ...
                "Setting decreasing 'Time' did not throw the " + ...
                "expected exception." )

        end % tDecreasingTimeThrowsException

    end % methods ( Test )

    methods ( Access = protected )

        function configureChartForPublicAPITests( testCase )

            testCase.Chart.Time = (1:5).';
            testCase.Chart.SignalData = [(1:5).', (5:-1:1).'];
            drawnow()

        end % configureChartForPublicAPITests

    end % methods ( Access = protected )

end % classdef
