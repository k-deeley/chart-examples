# `LineSelectorChart`

Display a collection of line plots and select one to highlight

## Overview

The `LineSelectorChart` manages multiple line plots, for which the *y*-data is on possibly different scales.The chart data comprises a numeric vector (`XData`) together with a numeric data matrix (`YData`). Each column of the `YData` is plotted against the `XData`, using a normalized scale so that all lines are visible together. Clicking on a line highlights it and shows its *y*-data on the true scale via *y*-axis limits and ticks. Clicking on another line changes the selection. Lines can be selected by clicking on the line itself, or programmatically by calling the `select` method of the chart.

![](../images/LineSelectorChart.png)

## Syntax

```matlab
LineSelectorChart()
LineSelectorChart(name, value, ...)
LSC = LineSelectorChart(name, value, ...) 
```

## Input Arguments

All `LineSelectorChart` inputs are optional name-value arguments.

## Properties

| Name | Description | Type | Default Value | Access |
| --- | --- | --- | --- | --- |
| `XData` | Chart x-data. | `double` | none | public |
| `YData` | Chart y-data. | `double` | none | public |
| `XGrid` | Axes x-grid. | `matlab.lang.OnOffSwitchState` | `"on"` | public |
| `YGrid` | Axes y-grid. | `matlab.lang.OnOffSwitchState` | `"on"` | public |
| `SelectedColor` | Color of the selected line. | not specified | `[0 0.447 0.741]` | public |
| `SelectedLineWidth` | Width of the selected line. | `double` | `3` | public |
| `TraceLineWidth` | Width of the unselected lines. | `double` | `1.5` | public |
| `TraceColor` | Color of the unselected line or lines. | not specified | none | public |

## Methods

| Name | Description |
| --- | --- |
| `deselect` | Deselect the selected line if one is selected. |
| `select` | Select a line. |
| `axis` | Call `axis` on the chart. |
| `ylim` | Call `ylim` on the chart. |
| `xlim` | Call `xlim` on the chart. |
| `legend` | Invoke legend on the axes. |
| `grid` | Invoke grid on the axes. |
| `title` | Call `title` on the chart. |
| `ylabel` | Call `ylabel` on the chart. |
| `xlabel` | Call `xlabel` on the chart. |

## Documentation

- [`line`](https://www.mathworks.com/help/matlab/ref/line.html): Create primitive line
See also:
- [`stackedplot`](https://www.mathworks.com/help/matlab/ref/stackedplot.html): Stacked plot of several variables with a common x-axis

## Examples

### Load and prepare the exchange rate data.

The data comprises a timetable of exchange rates (local currency per $US) for eight currencies.

```matlab
load( fullfile( chartsRoot(), "data", "Exchange.mat" ), "T" )
```

Create a numeric time vector, in fractional years, for use with the chart.

```matlab
startDate = min( T.Date );
yearStart = dateshift( startDate, "start", "year" );
yearEnd = dateshift( startDate, "end", "year" );
fracYear = days( startDate - yearStart ) / days( yearEnd - yearStart );
t = startDate.Year + fracYear + years( T.Date - startDate );
```

Extract the currency codes.

```matlab
codes = T.Properties.VariableNames;
```

### Create the chart, specifying the data, figure and legend entries.

```matlab
f = exampleFigure( "Name", "LineSelectorChart Example" );

LSC = LineSelectorChart( "Parent", f, ...
    "XData", t, ...
    "YData", T.Variables );
```

### Annotate the chart and customize its appearance.

```matlab
xlabel( LSC, "Year", "FontSize", 14 )
ylabel( LSC, "Exchange Rate (Local/$US)", "FontSize", 14 )
title( LSC, "Line Selector Chart", "FontSize", 16 )
xlim( LSC, [1979, 2000] )
legend( LSC, codes, "Location", "southoutside", ...
    "Orientation", "horizontal" )
```

### Change the chart data to show a particular decade.

```matlab
LSC.YData = LSC.YData(LSC.XData >= 1980 & LSC.XData < 1990, :);
xlim( LSC, [1979.5, 1990.5] )
```

### Show Australian and Canadian dollar exchange rates only.

```matlab
AUDCAD = ["AUD", "CAD"];
LSC.YData = LSC.YData(:, ismember( codes, AUDCAD ));
legend( LSC, AUDCAD, "Location", "northwest", ...
    "Orientation", "vertical" )
```

### Select a currency to highlight.

```matlab
select( LSC, 1 )
```

### Change the selection and highlight color.

```matlab
select( LSC, 2 )
LSC.SelectedColor = [1, 0.5, 0];
```

### Include more lines in the chart, update the legend text and set the x-axis limits automatically.

```matlab
set( LSC, "XData", t, "YData", T.Variables )
drawnow()
legend( LSC, codes, "Location", "eastoutside" )
xlim( LSC, [-Inf, Inf] )
```

### Select a currency and change the color of the unselected lines.

```matlab
select( LSC, 3 )
LSC.TraceColor = 0.95 * ones( 1, 3 );
```

### Deselect the line.

```matlab
deselect( LSC )
```

## See Also

* [Line Selector Chart](../landing/LineSelectorChart.md)
* [Source Code Listing](../source/LineSelectorChartSourceCode.md)
* [Test Code Listing](../tests/LineSelectorChartUnitTest.md)
* [Chart Reference](../ChartsIndex.md)

