classdef tWaterfallChart < tChart
    %TWATERFALLCHART Tests for the WaterfallChart class.
    %
    % See also WaterfallChart, tChart

    % Copyright 2025-2026 The MathWorks, Inc.

    properties ( TestParameter )
        % Tick/tick label methods.
        TickMethod = struct( "xticks", "xticks", ...
            "yticks", "yticks", ...
            "xticklabels", "xticklabels", ...
            "yticklabels", "yticklabels" )
        % Annotation methods and corresponding axes property names.
        AnnotationMethod = struct( "xlabel", ["xlabel", "XLabel"], ...
            "ylabel", ["ylabel", "YLabel"], ...
            "title", ["title", "Title"], ...
            "subtitle", ["subtitle", "Subtitle"] )
        % Limit methods and corresponding axes property names.
        LimitMethod = struct( "xlim", ["xlim", "XLim"], ...
            "ylim", ["ylim", "YLim"] )
    end % properties ( TestParameter )

    methods ( Test )

        function tSettingDataShowsCorrectValue( testCase )

            % Set a nonempty data vector.
            data = -2:2;
            expectedTotal = sum( data );
            testCase.Chart.Data = data;
            drawnow()
            testCase.verifyEqual( testCase.Chart.Bar.YData, ...
                expectedTotal, "The y-data of the " + ...
                "cumulative bar was not correct when the " + ...
                "chart data was set to a nonempty vector." )

            % Repeat for the empty case.
            expectedTotal = NaN;
            testCase.Chart.Data = [];
            drawnow()
            testCase.verifyEqual( testCase.Chart.Bar.YData, ...
                expectedTotal, "The y-data of the " + ...
                "cumulative bar was not NaN " + ...
                "when the chart data was set to an empty vector." )

        end % tSettingDataShowsCorrectValue

        function tReducingDataLengthShowsCorrectValue( testCase )

            % Set a nonempty vector.
            initialVector = -5:5;
            testCase.Chart.Data = initialVector;
            drawnow()

            % Set a shorter vector.
            idx = 1:6;
            testCase.Chart.Data = testCase.Chart.Data(idx);
            drawnow()

            % Check that the new total is correct.
            expectedTotal = sum( initialVector(idx) );
            testCase.verifyEqual( testCase.Chart.Bar.YData, ...
                expectedTotal, "After reducing the data length, " + ...
                "the y-data of the cumulative bar was not correct." )

        end % tReducingDataLengthShowsCorrectValue

        function tIncreasingDataLengthShowsCorrectValue( testCase )

            % Set a longer vector.
            newVector = -10:10;
            testCase.Chart.Data = newVector;
            drawnow()

            % Check that the new total is correct.
            expectedTotal = sum( newVector );
            testCase.verifyEqual( testCase.Chart.Bar.YData, ...
                expectedTotal, "After increasing the data length, " + ...
                "the y-data of the cumulative bar was not correct." )

        end % tIncreasingDataLengthShowsCorrectValue

        function tAnnotationMethodSetsCorrectText( testCase, ...
                AnnotationMethod )

            % Unpack.
            methodName = AnnotationMethod(1);
            axesPropertyName = AnnotationMethod(2);

            % Set a specific label.
            expected = "A";
            feval( methodName, testCase.Chart, expected )
            drawnow()

            % Verify that the text was set correctly.
            actual = testCase.Chart.Axes.(axesPropertyName).String;
            testCase.verifyThat( actual, IsEquivalentText( expected ), ...
                "Calling the chart's " + methodName + " method " + ...
                "did not set the specified value correctly." )

        end % tAnnotationMethodSetsCorrectText

        function tTickMethodSetsCorrectText( testCase, TickMethod )

            % Call the given method.
            expected = (1:20).';
            feval( TickMethod, testCase.Chart, expected )
            drawnow()

            % Verify that the value has been set correctly.
            actual = feval( TickMethod, testCase.Chart );
            if endsWith( TickMethod, "labels" )
                constraint = IsEquivalentText( compose( "%d", expected ) );
            else
                constraint = IsEqualVector( expected );
            end % if
            testCase.verifyThat( actual, constraint, ...
                "Calling the chart's " + TickMethod + " method " + ...
                "did not set the specified values correctly." )

        end % tTickMethodSetsCorrectText

        function tLimitMethodSetsCorrectValue( testCase, LimitMethod )

            % Unpack.
            methodName = LimitMethod(1);
            axesPropertyName = LimitMethod(2);

            % Set the limits.
            expected = [-5, 5];
            feval( methodName, testCase.Chart, expected )
            drawnow()

            % Verify that the limits are correct.
            actual = testCase.Chart.Axes.(axesPropertyName);
            testCase.verifyEqual( actual, expected, ...
                "Calling the chart's " + methodName + " method " + ...
                "did not set the specified values correctly." )

        end % tLimitMethodSetsCorrectValue

        function tGridMethodSetsAxesProperties( testCase )

            % Try both "on" and "off" values when calling grid().
            gridValues = ["on", "off"];
            for k = 1 : numel( gridValues )
                grid( testCase.Chart, gridValues(k) )
                actual = {testCase.Chart.Axes.XGrid, ...
                    testCase.Chart.Axes.YGrid};
                expected = repmat( ...
                    matlab.lang.OnOffSwitchState( gridValues(k) ), 1, 2 );
                testCase.verifyEqual( [actual{:}], expected, ...
                    "Calling the chart's grid() method with the " + ...
                    "value '" + gridValues(k) + "' did not update" + ...
                    " the axes' 'XGrid' and 'YGrid' properties." )
            end % for

        end % tGridMethodSetsAxesProperties

        function tBoxMethodSetsAxesProperties( testCase )

            % Try both "on" and "off" values when calling box().
            boxValues = ["on", "off"];
            for k = 1 : numel( boxValues )
                box( testCase.Chart, boxValues(k) )
                actual = testCase.Chart.Axes.Box;
                expected = matlab.lang.OnOffSwitchState( boxValues(k) );
                testCase.verifyEqual( actual, expected, ...
                    "Calling the chart's box() method with the " + ...
                    "value '" + boxValues(k) + "' did not update" + ...
                    " the axes' 'Box' property." )
            end % for

        end % tBoxMethodSetsAxesProperties

        function tColororderMethodThrowsExceptionForInvalidColors( ...
                testCase )

            % Attempt to set an unknown color.
            f = @() colororder( testCase.Chart, "o" );
            expected = "MATLAB:graphics:validatecolor:InvalidColorString";
            testCase.verifyError( f, expected, ...
                "The colororder() method did not throw the expected" + ...
                " exception when passed an invalid color." )

        end % tColororderMethodThrowsExceptionForInvalidColors

        function tColororderMethodSetsColorOrderProperty( testCase )

            % Verify that named colors are stored as numeric values.
            expected = [1, 0, 0; 0, 1, 0; 0, 0, 1];
            colororder( testCase.Chart, ["r"; "g"; "b"] )
            actual = testCase.Chart.ColorOrder;
            testCase.verifyEqual( actual, expected, ...
                "The colororder() method did not set the correct " + ...
                "value for the 'ColorOrder' property." )

        end % tColororderMethodSetsColorOrderProperty

        function tAxisMethodSetsAxesLimits( testCase )

            % Call axis() and check the XLim, YLim properties.
            expected = [-5, 5, -5, 5];
            axis( testCase.Chart, expected )
            actualx = testCase.Chart.Axes.XLim;
            actualy = testCase.Chart.Axes.YLim;
            testCase.verifyEqual( actualx, expected(1:2), ...
                "The axis() method did not set the axes' 'XLim' " + ...
                "property correctly." )
            testCase.verifyEqual( actualy, expected(3:4), ...
                "The axis() method did not set the axes' 'YLim' " + ...
                "property correctly." )

        end % tAxisMethodSetsAxesLimits

        function tSettingSingleFaceColorUpdatesPatch( testCase )

            % Set 'BarFaceColor' to a single color.
            expected = [1, 0, 0];
            testCase.Chart.BarFaceColor = expected;
            actual = reshape( testCase.Chart.Patch.CData, 1, [] );
            diagnostic = "Setting a single color using the " + ...
                "'BarFaceColor' did not update the patch object's " + ...
                "'CData' property.";
            testCase.verifyEqual( actual, expected, diagnostic )

            % Repeat for a text value.
            testCase.Chart.BarFaceColor = "r";
            actual = reshape( testCase.Chart.Patch.CData, 1, [] );
            testCase.verifyEqual( actual, expected, diagnostic )

            % Repeat again.
            testCase.Chart.BarFaceColor = 'r';
            actual = reshape( testCase.Chart.Patch.CData, 1, [] );
            testCase.verifyEqual( actual, expected, diagnostic )

        end % tSettingSingleFaceColorUpdatesPatch

        function tSettingUpDownFaceColorUpdatesPatch( testCase )

            % Set the chart's data.
            testCase.Chart.Data = [1, -1, 0];

            % Specify 'BarFaceColor' as 'updown'.
            testCase.Chart.BarFaceColor = "updown";

            % Verify that the patch color data is as expected.
            expected = [1; 2; 1];
            actual = testCase.Chart.Patch.CData;
            testCase.verifyEqual( actual, expected, ...
                "The patch object's 'CData' property did not have " + ...
                "the correct value after setting the 'BarFaceColor'" + ...
                " property of the chart to 'updown'." )

            % Verify that the chart's ColorData property is correct.
            expected = [0.2310, 0.6660, 0.1960; 0.8660, 0.3290, 0];
            actual = testCase.Chart.ColorOrder;
            testCase.verifyEqual( actual, expected, "The chart's " + ...
                "'ColorOrder' property was not as expected after " + ...
                "setting the 'BarFaceColor' property to 'updown'.", ...
                "AbsTol", 1e-6 )

        end % tSettingUpDownFaceColorUpdatesPatch

        function tSettingTotalBarFaceColorAcceptsValidValues( testCase )

            % Test with the "none" option.
            expected = "none";
            testCase.Chart.TotalBarFaceColor = expected;
            drawnow()
            actual = testCase.Chart.Bar.FaceColor;
            constraint = IsEquivalentText( expected );
            testCase.verifyThat( actual, constraint, ...
                "Setting the chart's 'TotalBarFaceColor' to 'none' " + ...
                "did not update the bar's 'FaceColor' property." )

            % Repeat with a single color.
            expected = [1, 0, 0];
            testCase.Chart.TotalBarFaceColor = "r";
            drawnow()
            actual = testCase.Chart.Bar.FaceColor;
            testCase.verifyEqual( actual, expected, ...
                "Setting the chart's 'TotalBarFaceColor' to 'none' " + ...
                "did not update the bar's 'FaceColor' property." )

        end % tSettingTotalBarFaceColorAcceptsValidValues

        function tChangingDataLengthUpdatesColorData( testCase )

            % Set the initial chart data.
            data = 1:5;
            testCase.Chart.Data = data;
            drawnow()

            % Verify the chart state.
            testCase.verifyEqual( testCase.Chart.BarFaceColor, ...
                "updown", "The 'BarFaceColor' property of the chart" + ...
                " was not set to 'updown' by default." )
            constraint = IsEqualVector( ones( size( data ) ) );
            testCase.verifyThat( testCase.Chart.ColorData, ...
                constraint, "The 'ColorData' property " + ...
                "of the chart was not correct after setting the " + ...
                "'Data' property to " + mat2str( data ) + "." )

            % Decrease the data length.
            newData = -3:0;
            testCase.Chart.Data = newData;
            drawnow()

            % Verify the chart state.
            constraint = IsEqualVector( [2; 2; 2; 1] );
            testCase.verifyThat( testCase.Chart.ColorData, ...
                constraint, "The 'ColorData' property of the " + ...
                "chart was not correct after setting the 'Data' " + ...
                "property to " + mat2str( newData ) + "." )

            % Empty the data.
            newData = [];
            testCase.Chart.Data = newData;
            drawnow()

            % Verify the chart state.
            testCase.verifyEmpty( testCase.Chart.ColorData, ...
                "The 'ColorData' property of the chart was not " + ...
                "empty after setting the 'Data' property to []." )

            % Increase the data length.
            newData = -3:3;
            testCase.Chart.Data = newData;
            drawnow()

            % Verify the chart state.
            constraint = IsEqualVector( [2; 2; 2; ones( 4, 1 )] );
            actual = testCase.Chart.ColorData;
            testCase.verifyThat( actual, constraint, ...
                "The 'ColorData' property of the chart was not " + ...
                "correct after setting the 'Data' property to " + ...
                mat2str( newData ) + "." )

        end % tChangingDataLengthUpdatesColorData

        function tChangingDataUpdatesColorDataForFlatFaceColor( testCase )

            % Set the initial chart data and state.
            data = -2:2;
            set( testCase.Chart, "Data", data, "BarFaceColor", "flat" )
            drawnow()

            % Check the 'ColorData' property.
            expected = [2; 2; 1; 1; 1];
            constraint = IsEqualVector( expected );
            actual = testCase.Chart.ColorData;
            testCase.verifyThat( actual, constraint, ...
                "The 'ColorData' property was not an array of " + ...
                "ones when the 'BarFaceColor' was initially set to " + ...
                "'flat'." )

            % Increase the data length.
            newData = -3:3;
            testCase.Chart.Data = newData;
            drawnow()
            expected = [2; 2; 1; 1; 1; 1; 1];
            constraint = IsEqualVector( expected );
            actual = testCase.Chart.ColorData;
            testCase.verifyThat( actual, constraint, ...
                "The 'ColorData' property was not updated correctly" + ...
                " when the data length was increased." )

            % Decrease the data length.
            testCase.Chart.Data = newData(1:2);
            drawnow()
            expected = [2; 2];
            constraint = IsEqualVector( expected );
            actual = testCase.Chart.ColorData;
            testCase.verifyThat( actual, constraint, ...
                "The 'ColorData' property was not updated correctly" + ...
                " when the data length was decreased." )

        end % tChangingDataUpdatesColorDataForFlatFaceColor

        function tChangingDataFixesColorDataForSingleFaceColor( testCase )

            % Set the initial chart data and state.
            data = -2:2;
            set( testCase.Chart, "Data", data, "BarFaceColor", "r" )
            drawnow()

            % Check the 'CData' property of the patch.
            expected = [1, 0, 0];
            actual = reshape( testCase.Chart.Patch.CData, 1, [] );
            testCase.verifyEqual( actual, expected, ...
                "The 'CData' property of the patch was not correct " + ...
                "after setting a fixed color for the 'BarFaceColor'" + ...
                " property." )

            % Increase the data length.
            newData = -3:3;
            testCase.Chart.Data = newData;
            drawnow()
            actual = reshape( testCase.Chart.Patch.CData, 1, [] );
            testCase.verifyEqual( actual, expected, ...
                "The 'CData' property of the patch was not correct " + ...
                "after setting a fixed color for the 'BarFaceColor'" + ...
                " property." )

            % Decrease the data length.
            testCase.Chart.Data = newData(1:2);
            drawnow()
            actual = reshape( testCase.Chart.Patch.CData, 1, [] );
            testCase.verifyEqual( actual, expected, ...
                "The 'CData' property of the patch was not correct " + ...
                "after setting a fixed color for the 'BarFaceColor'" + ...
                " property." )

        end % tChangingDataFixesColorDataForSingleFaceColor

        function tSettingColorDataUpdatesFaceColor( testCase )

            % Set the chart's data.
            data = -2:2;
            testCase.Chart.Data = data;
            drawnow()

            % Set a scalar value for the 'ColorData' property, and verify
            % that scalar expansion has occurred.
            testCase.Chart.ColorData = 1;
            drawnow()
            actual = testCase.Chart.ColorData;
            expected = ones( size( data ) );
            constraint = IsEqualVector( expected );
            testCase.verifyThat( actual, constraint, ...
                "The 'ColorData' property was not expanded to a " + ...
                "vector when a scalar value was set." )

            % Verify that we get an error when the number of values is
            % incorrect.
            f = @() set( testCase.Chart, "ColorData", [1, 2] );
            testCase.verifyError( f, ...
                "WaterfallChart:ColorDataSizeMismatch", ...
                "Using an incorrect size for the 'ColorData' " + ...
                "property did not issue the correct error." )

            % Verify that 'BarFaceColor' is 'flat'.
            expected = "flat";
            actual = testCase.Chart.BarFaceColor;
            constraint = IsEquivalentText( expected );
            testCase.verifyThat( actual, constraint, ...
                "The 'BarFaceColor' property was not 'flat' after " + ...
                "manually setting the 'ColorData' property." )

            % Verify that the patch 'CData' has been updated.
            expected = ones( size( testCase.Chart.Data ) );
            actual = testCase.Chart.Patch.CData;
            constraint = IsEqualVector( expected, "AbsTol", 1e-6 );
            testCase.verifyThat( actual, constraint, ...
                "The patch's 'CData' property was not updated " + ...
                "correctly after setting the 'ColorData' property." )

        end % tSettingColorDataUpdatesFaceColor

        function tGlobalLineWidthRelatesToIndividualLineWidths( testCase )

            % Verify the initial state is correct.
            expected = testCase.Chart.BarLineWidth;
            actual = testCase.Chart.LineWidth;
            testCase.verifyEqual( actual, expected, ...
                "Initially, the 'LineWidth' property was not equal " + ...
                "to the chart's 'BarLineWidth' property value." )

            % Set the global line width.
            expected = 3;
            testCase.Chart.LineWidth = expected;
            drawnow()

            % Verify that all the individual line widths have been updated.
            linewidths = [testCase.Chart.BarLineWidth, ...
                testCase.Chart.BaseLineWidth, ...
                testCase.Chart.TargetLineWidth, ...
                testCase.Chart.TotalBarLineWidth, ...
                testCase.Chart.ConnectingLineWidth];
            expected = expected * ones( size( linewidths ) );
            testCase.verifyEqual( linewidths, expected, ...
                "After setting the 'LineWidth' property, at least " + ...
                "one individual line width was not updated." )

        end % tGlobalLineWidthRelatesToIndividualLineWidths

        function tSettingBarWidthUpdatesPatch( testCase )

            % Set one data point in the chart.
            testCase.Chart.Data = 1;

            % Set the 'BarWidth' property.
            testCase.Chart.BarWidth = 1;
            drawnow()

            % Verify the patch coordinates.
            actual = testCase.Chart.Patch.XData;
            expected = [1.5, 1.5, 0.5, 0.5];
            constraint = IsEqualVector( expected );
            testCase.verifyThat( actual, constraint, ...
                "Setting the 'BarWidth' property did not update " + ...
                "the patch's 'XData' property correctly." )

            % Repeat for a different bar width.
            testCase.Chart.BarWidth = 0.5;
            drawnow()
            actual = testCase.Chart.Patch.XData;
            expected = [1.25, 1.25, 0.75, 0.75];
            constraint = IsEqualVector( expected );
            testCase.verifyThat( actual, constraint, ...
                "Setting the 'BarWidth' property did not update " + ...
                "the patch's 'XData' property correctly." )

        end % tSettingBarWidthUpdatesPatch

        function tSwitchingOffBarLabelVisibleUsesEmptyString( testCase )

            % Set 'BarLabelVisible' to 'off'.
            testCase.Chart.BarLabelVisible = "off";
            drawnow()

            actual = testCase.Chart.Bar.Labels;
            testCase.verifyEqual( actual, "", ...
                "Setting 'BarLabelVisible' to 'off' did not " + ...
                "set the 'Labels' property of the total bar to """"." )

        end % tSwitchingOffBarLabelVisibleUsesEmptyString

        function tTurningOffInteractionsDisablesToolbar( testCase )

            testCase.Chart.Interactions = "off";
            drawnow()
            testCase.verifyEmpty( testCase.Chart.Axes.Toolbar, ...
                "Setting 'Interactions' to 'off' did not remove " + ...
                "the axes toolbar." )

        end % tTurningOffInteractionsDisablesToolbar

    end % methods ( Test )

end % classdef
