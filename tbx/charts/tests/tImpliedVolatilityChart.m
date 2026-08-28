classdef tImpliedVolatilityChart < tChart
    %TIMPLIEDVOLATILITYCHART Tests for ImpliedVolatilityChart.

    % Copyright 2026 The MathWorks, Inc.

    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

    end % methods ( Test )
    methods ( Access = protected )

        function configureChartForPublicAPITests( testCase )

            timeToExpiry = [1; 1; 2; 2];
            strike = [90; 110; 90; 110];
            volatility = [0.18; 0.20; 0.22; 0.24];
            spot = 100 * ones( 4, 1 );
            testCase.Chart.OptionData = table( timeToExpiry, strike, ...
                volatility, spot, 'VariableNames', ...
                {'T', 'K', 'Sigma', 'S'} );
            drawnow()

        end % configureChartForPublicAPITests

    end % methods ( Access = protected )

end % classdef
