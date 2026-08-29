# `SettlementChart` Test Class

Test file: `tSettlementChart.m`.

````text 
classdef tSettlementChart < tChart
    %TSETTLEMENTCHART Tests for the SettlementChart class.
    %
    % See also SettlementChart, tChart


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

        function tOptionInputsUpdateDerivedPrices( testCase )

            % Set deterministic option inputs.
            testCase.Chart.Strike = [90; 100; 110];
            testCase.Chart.Price = 100;
            testCase.Chart.Rate = 0.05;
            testCase.Chart.Time = 0.25;
            testCase.Chart.Volatility = 0.2;
            testCase.Chart.Yield = 0.01;
            drawnow()

            % Verify derived option values.
            expectedAtTheMoney = 100 * exp( (0.05 - 0.01) * 0.25 );
            [expectedCall, expectedPut] = blsprice( 100, ...
                [90; 100; 110], 0.05, 0.25, 0.2, 0.01 );
            expectedPrices = [expectedCall, expectedPut];
            testCase.verifyEqual( testCase.Chart.AtTheMoneyPrice, ...
                expectedAtTheMoney, "RelTol", 1e-12, ...
                "The chart did not compute the expected " + ...
                "at-the-money price." )
            testCase.verifyEqual( testCase.Chart.OptionPrices, ...
                expectedPrices, "RelTol", 1e-12, ...
                "The chart did not compute the expected option prices." )

        end % tOptionInputsUpdateDerivedPrices

        function tResetRestoresDefaultInputs( testCase )

            % Change the model inputs.
            testCase.Chart.Strike = [90; 100; 110];
            testCase.Chart.Price = 95;
            testCase.Chart.Rate = 0.01;
            testCase.Chart.Time = 0.5;
            testCase.Chart.Volatility = 0.2;
            testCase.Chart.Yield = 0.02;

            % Reset and verify defaults.
            reset( testCase.Chart )
            drawnow()
            actualStrike = testCase.Chart.Strike;
            expectedStrike = (85:0.1:115).';
            testCase.verifyEqual( actualStrike, expectedStrike, ...
                "Calling reset() did not restore the default strikes." )
            testCase.verifyEqual( testCase.Chart.Price, 100, ...
                "Calling reset() did not restore the default price." )
            testCase.verifyEqual( testCase.Chart.Rate, 0.05, ...
                "Calling reset() did not restore the default rate." )
            testCase.verifyEqual( testCase.Chart.Time, 0.25, ...
                "Calling reset() did not restore the default time." )
            testCase.verifyEqual( testCase.Chart.Volatility, 0.5, ...
                "Calling reset() did not restore the default " + ...
                "volatility." )
            testCase.verifyEqual( testCase.Chart.Yield, 0, ...
                "Calling reset() did not restore the default yield." )

        end % tResetRestoresDefaultInputs

        function tStyleAndControlsPropertiesRoundTrip( testCase )

            % Set representative style properties.
            testCase.Chart.CallColor = [1, 0, 0];
            testCase.Chart.PutColor = [0, 0, 1];
            testCase.Chart.AtTheMoneyColor = [0, 1, 0];
            testCase.Chart.AtTheMoneyLabel = "ATM";
            testCase.Chart.Controls = "on";
            drawnow()

            % Verify public style state.
            testCase.verifyEqual( testCase.Chart.CallColor, [1, 0, 0], ...
                "Setting 'CallColor' did not round-trip." )
            testCase.verifyEqual( testCase.Chart.PutColor, [0, 0, 1], ...
                "Setting 'PutColor' did not round-trip." )
            testCase.verifyEqual( testCase.Chart.AtTheMoneyColor, ...
                [0, 1, 0], "Setting 'AtTheMoneyColor' did not " + ...
                "round-trip." )
            testCase.verifyThat( testCase.Chart.AtTheMoneyLabel, ...
                IsEquivalentText( "ATM" ), ...
                "Setting 'AtTheMoneyLabel' did not " + ...
                "round-trip." )
            expected = matlab.lang.OnOffSwitchState( "on" );
            testCase.verifyEqual( testCase.Chart.Controls, expected, ...
                "Setting 'Controls' did not round-trip." )

        end % tStyleAndControlsPropertiesRoundTrip

        function tAnnotationMethodsSetCorrectText( testCase, ...
                AnnotationMethod )

            % Call the given annotation method.
            expected = "Settlement";
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

        function samples = chartSpecificPublicMethodCallSamples( ...
                testCase )

            samples = testCase.publicMethodCallSample( "reset" );

        end % chartSpecificPublicMethodCallSamples

    end % methods ( Access = protected )

end % classdef

````

## See Also

* [Settlement Chart](../landing/SettlementChart.md)
* [Chart Examples](../../ChartExamples.md)

