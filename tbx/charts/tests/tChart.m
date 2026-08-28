classdef ( Abstract ) tChart < Testable
    %TCHART Common test infrastructure for testing charts and components.

    % Copyright 2025-2026 The MathWorks, Inc.

    properties ( GetAccess = protected, SetAccess = private )
        % Figure parent.
        Figure(:, 1) matlab.ui.Figure {mustBeScalarOrEmpty}
        % Class name of the chart/component under test.
        ChartType(1, 1) string
        % Chart/component under test.
        Chart(:, 1) {mustBeA( Chart, ...
            ["matlab.graphics.chartcontainer.ChartContainer", ...
            "matlab.ui.componentcontainer.ComponentContainer"] ), ...
            mustBeScalarOrEmpty} = ...
            matlab.graphics.chartcontainer.ChartContainer.empty( 0, 1 )
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

        function tChartCanBeReparented( testCase )

            newFigure = uifigure( "Visible", "off" );
            testCase.addTeardown( @() delete( newFigure ) )

            testCase.verifyWarningFree( ...
                @() setProperty( testCase.Chart, "Parent", ...
                newFigure ), ...
                "Reparenting the chart issued a warning." )
            testCase.verifySameHandle( testCase.Chart.Parent, ...
                newFigure, ...
                "The chart was not reparented to the expected figure." )

        end % tChartCanBeReparented

        function tChartVisiblePropertyRoundTrips( testCase )

            visibilityValues = ["off", "on"];
            for visibilityValue = visibilityValues
                testCase.verifyWarningFree( ...
                    @() setProperty( testCase.Chart, "Visible", ...
                    visibilityValue ), ...
                    "Setting the chart's 'Visible' property issued" + ...
                    " a warning." )
                expected = matlab.lang.OnOffSwitchState( ...
                    visibilityValue );
                testCase.verifyEqual( testCase.Chart.Visible, ...
                    expected, ...
                    "The chart's 'Visible' property did not " + ...
                    "round-trip correctly." )
            end % for

        end % tChartVisiblePropertyRoundTrips

        function tChartCommonPropertiesRoundTrip( testCase )

            propertyNames = [ ...
                "HandleVisibility"; ...
                "Units"; ...
                "Position"; ...
                "OuterPosition"; ...
                "Layout" ];

            for propertyName = propertyNames.'
                value = testCase.Chart.(propertyName);
                testCase.verifyWarningFree( ...
                    @() setProperty( testCase.Chart, propertyName, ...
                    value ), ...
                    "Setting the chart's '" + propertyName + ...
                    "' property to its current value issued a warning." )
            end % for

        end % tChartCommonPropertiesRoundTrip

    end % methods ( Test )

    methods ( Access = protected )

        function configureChartForPublicAPITests( ~ )
        end % configureChartForPublicAPITests

        function propertyNames = propertyAssignmentExclusions( ~ )

            propertyNames = strings( 0, 1 );

        end % propertyAssignmentExclusions

        function samples = chartSpecificPublicMethodCallSamples( ~ )

            samples = emptyPublicMethodCallSamples();

        end % chartSpecificPublicMethodCallSamples

        function sample = publicMethodCallSample( ~, methodName, inputs )

            if nargin < 3
                inputs = {};
            end % if
            sample = struct( "Name", methodName, "Inputs", {inputs} );

        end % publicMethodCallSample

        function verifyChartDefinedPublicAPI( testCase )

            testCase.configureChartForPublicAPITests()
            [propertyNames, settableProperties, methodNames] = ...
                chartDefinedPublicMembers( testCase.Chart );

            testCase.verifyPublicPropertiesAreReadable( propertyNames )
            testCase.verifyPublicPropertiesRoundTrip( ...
                settableProperties )
            testCase.verifyPublicMethodsAreCovered( methodNames )
            testCase.verifyPublicMethodsAreCallable()

        end % verifyChartDefinedPublicAPI

        function samples = publicMethodCallSamples( testCase )

            [~, ~, methodNames] = chartDefinedPublicMembers( ...
                testCase.Chart );
            samples = commonPublicMethodCallSamples( ...
                testCase, methodNames );
            samples = [samples; ...
                testCase.chartSpecificPublicMethodCallSamples()];

        end % publicMethodCallSamples

        function file = temporaryGraphicsFile( testCase )

            file = tempname() + ".png";
            testCase.addTeardown( @() deleteFile( file ) )

        end % temporaryGraphicsFile

    end % methods ( Access = protected )

    methods ( Access = private )

        function verifyPublicPropertiesAreReadable( testCase, ...
                propertyNames )

            for propertyName = propertyNames.'
                testCase.verifyWarningFree( ...
                    @() testCase.Chart.(propertyName), ...
                    "Reading the public property '" + propertyName + ...
                    "' issued a warning." )
            end % for

        end % verifyPublicPropertiesAreReadable

        function verifyPublicPropertiesRoundTrip( testCase, ...
                propertyNames )

            excluded = testCase.propertyAssignmentExclusions();
            for propertyName = setdiff( propertyNames, excluded ).'
                value = testCase.Chart.(propertyName);
                testCase.verifyWarningFree( ...
                    @() setProperty( testCase.Chart, propertyName, ...
                    value ), ...
                    "Setting the public property '" + propertyName + ...
                    "' to its current value issued a warning." )
            end % for

        end % verifyPublicPropertiesRoundTrip

        function verifyPublicMethodsAreCovered( testCase, methodNames )

            samples = testCase.publicMethodCallSamples();
            sampleNames = string( {samples.Name} ).';
            excluded = ["loadobj"; class( testCase.Chart )];
            missing = setdiff( methodNames, [sampleNames; excluded] );

            testCase.verifyEmpty( missing, ...
                "At least one chart-defined public method does not " + ...
                "have an invocation sample." )

        end % verifyPublicMethodsAreCovered

        function verifyPublicMethodsAreCallable( testCase )

            samples = testCase.publicMethodCallSamples();

            for sample = samples(:).'
                testCase.verifyWarningFree( ...
                    @() callPublicMethod( testCase.Chart, sample ), ...
                    "Calling the public method '" + sample.Name + ...
                    "' issued a warning." )
            end % for

        end % verifyPublicMethodsAreCallable

    end % methods ( Access = private )

end % classdef

function samples = emptyPublicMethodCallSamples()
%EMPTYPUBLICMETHODCALLSAMPLES Create an empty method sample array.

samples = repmat( struct( "Name", "", "Inputs", {{}} ), 0, 1 );

end % emptyPublicMethodCallSamples

function samples = commonPublicMethodCallSamples( testCase, methodNames )
%COMMONPUBLICMETHODCALLSAMPLES Samples for shared public method names.

samples = emptyPublicMethodCallSamples();
for methodName = methodNames(:).'
    [covered, inputs] = commonPublicMethodInputs( methodName );
    if covered
        if methodName == "exportgraphics"
            inputs = {testCase.temporaryGraphicsFile()};
        end % if
        samples(end+1, 1) = struct( ...
            "Name", methodName, ...
            "Inputs", {inputs} ); %#ok<AGROW>
    end % if
end % for

end % commonPublicMethodCallSamples

function [covered, inputs] = commonPublicMethodInputs( methodName )
%COMMONPUBLICMETHODINPUTS Inputs for chart-agnostic method names.

covered = true;
inputs = {};
switch methodName
    case {"title", "xlabel", "ylabel", "zlabel", "subtitle", ...
            "thetalabel", "rlabel"}
        inputs = {"Test label"};
    case "legend"
        inputs = {"show"};
    case {"grid", "box"}
        inputs = {"on"};
    case "axis"
        inputs = {"auto"};
    case "view"
        inputs = {[30, 20]};
    case "colorbar"
        inputs = {};
    case "colormap"
        inputs = {parula( 8 )};
    case "colororder"
        inputs = {[1, 0, 0; 0, 1, 0; 0, 0, 1]};
    case {"xlim", "ylim"}
        inputs = {[-1, 1]};
    case {"xticks", "yticks", "rticks"}
        inputs = {0:3};
    case {"xticklabels", "yticklabels", "rticklabels"}
        inputs = {["A", "B", "C", "D"]};
    case "thetaticks"
        inputs = {0:90:270};
    case "thetaticklabels"
        inputs = {["N", "E", "S", "W"]};
    case "rtickformat"
        inputs = {"%.1f"};
    case "thetatickformat"
        inputs = {"degrees"};
    case {"rtickangle", "xtickangle"}
        inputs = {45};
    case "exportgraphics"
        inputs = {};
    otherwise
        covered = false;
end % switch

end % commonPublicMethodInputs

function callPublicMethod( chart, sample )
%CALLPUBLICMETHOD Call a public method sample.

if sample.Name == "exportgraphics"
    exportgraphics( chart, sample.Inputs{:} )
else
    feval( sample.Name, chart, sample.Inputs{:} )
end % if
drawnow()

end % callPublicMethod

function setProperty( chart, propertyName, value )
%SETPROPERTY Set a property by name.

chart.(propertyName) = value;
drawnow()

end % setProperty

function deleteFile( file )
%DELETEFILE Delete a temporary file if it exists.

if isfile( file )
    delete( file )
end % if

end % deleteFile
