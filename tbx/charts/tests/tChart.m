classdef ( Abstract ) tChart < Testable
    %TCHART Common test infrastructure for testing charts and components.

    % Copyright 2025 The MathWorks, Inc.

    properties ( GetAccess = protected, SetAccess = private )
        % Figure parent.
        Figure(:, 1) matlab.ui.Figure {mustBeScalarOrEmpty}
        % Class name of the chart/component under test.
        ChartType(1, 1) string
        % Chart/component under test.
        Chart(:, 1) {mustBeA( Chart, ["Chart", "Component"] ), ...
            mustBeScalarOrEmpty} = Chart.empty( 0, 1 )
    end % properties ( GetAccess = protected, SetAccess = private )

    methods ( TestClassSetup )

        function checkConstruction( testCase )

            % Identify the chart/component under test.
            testClassName = class( testCase );
            testCase.ChartType = extractAfter( testClassName, 1 );

            % Attempt to construct the component.
            testCase.fatalAssertWarningFree( @() constructChart(), ...
                "Calling the " + testCase.ChartType + " constructor" + ...
                " was not warning-free." )

            function constructChart()

                c = feval( testCase.ChartType );
                oc = onCleanup( @() delete( c ) );

            end % constructChart

        end % checkConstruction

    end % methods ( TestClassSetup )

    methods ( TestMethodSetup )

        function applyFigureFixture( testCase )

            % Apply the figure fixture and store a reference to the figure
            % for use in each test point.
            fixture = testCase.applyFixture( FigureFixture() );
            testCase.Figure = fixture.Figure;

        end % applyFigureFixture

        function createChart( testCase )

            % Create the chart.
            testCase.Chart = feval( testCase.ChartType, ...
                "Parent", testCase.Figure );

        end % createComponent

    end % methods ( TestMethodSetup )

    methods ( Test )

        function tChartConstructorReturnsScalarChartWithCorrectParent( ...
                testCase )

            % Check that we have a 1-by-1 ScatterFit chart with the
            % correct parent.
            testCase.verifyClass( testCase.Chart, testCase.ChartType, ...
                "The " + testCase.ChartType + " constructor did not" + ...
                " return an object of the expected type." )
            testCase.verifySize( testCase.Chart, [1, 1], ...
                "The " + testCase.ChartType + " constructor did not" + ...
                " return a scalar object." )
            testCase.verifySameHandle( testCase.Chart.Parent, ...
                testCase.Figure, ...
                "The " + testCase.ChartType + " constructor did not" + ...
                " set the parent of the chart to the correct figure." )

        end % tChartConstructorReturnsScalarChartWithCorrectParent

    end % methods ( Test )

end % classdef