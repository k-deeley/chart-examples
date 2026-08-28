# `TernaryChart` Unit Test

Test file: [`tTernaryChart.m`](../../charts/tests/tTernaryChart.m).

````text
classdef tTernaryChart < tChart
    %TTERNARYCHART Tests for the TernaryChart class.


    methods ( Test )

        function tChartDefinedPublicAPIIsCoveredAndWarningFree( ...
                testCase )

            testCase.verifyChartDefinedPublicAPI()

        end % tChartDefinedPublicAPIIsCoveredAndWarningFree

    end % methods ( Test )
    methods ( Access = protected )

        function configureChartForPublicAPITests( testCase )

            a = [1; 0; 0; 0.5];
            b = [0; 1; 0; 0.25];
            c = [0; 0; 1; 0.25];
            z = [1; 2; 3; 4];
            testCase.Chart.Data = table( a, b, c, z, ...
                'VariableNames', {'A', 'B', 'C', 'Z'} );
            drawnow()

        end % configureChartForPublicAPITests

        function propertyNames = propertyAssignmentExclusions( ~ )

            propertyNames = ["Data"; "MarkerEdgeColor"; ...
                "ColorbarVisible"];

        end % propertyAssignmentExclusions

        function samples = publicMethodCallSamples( testCase )

            samples = publicMethodCallSamples@tChart( testCase );
            sampleNames = string( {samples.Name} ).';
            samples(sampleNames == "ylabel") = [];
            samples = [
                samples
                testCase.publicMethodCallSample( ...
                "ylabel", {"left", "Test label"} )
                testCase.publicMethodCallSample( "resetLabels" )
                testCase.publicMethodCallSample( "swapdata", {1, 2} )
                testCase.publicMethodCallSample( ...
                "rotate", {"clockwise"} ) ];

        end % publicMethodCallSamples

    end % methods ( Access = protected )

end % classdef

````

## See Also

* [Ternary Chart](TernaryChart.md)
* [Chart Reference](ChartsIndex.md)

