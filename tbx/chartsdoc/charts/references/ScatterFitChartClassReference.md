# `ScatterFitChart`

Manage bivariate scattered data together with the line of best fit

## Overview

The `ScatterFitChart` manages bivariate scattered data together with the associated best-fit trend line (regression line). The chart data comprises numeric vectors `XData` and `YData`. The `YData` is scattered against the `XData` and the best-fit line is computed using the `fitlm` function to perform linear regression.

![](../images/ScatterFitChart.png)

## Syntax

```matlab
ScatterFitChart()
ScatterFitChart(name, value, ...)
SFC = ScatterFitChart(name, value, ...) 
```

## Input Arguments

All `ScatterFitChart` inputs are optional name-value arguments.

## Properties

| Name | Description | Type | Default Value | Access |
| --- | --- | --- | --- | --- |
| `XData` | Chart x-data. | `double` | none | public |
| `YData` | Chart y-data. | `double` | none | public |
| `SizeData` | Size data for the scatter series. | `double` | `36` | public |
| `CData` | Color data for the scatter series. | `double` | `[0 0.447 0.741]` | public |
| `LineVisible` | Visibility of the best-fit line. | `matlab.lang.OnOffSwitchState` | none | public |
| `LineWidth` | Width of the best-fit line. | `double` | none | public |
| `LineStyle` | Style of the best-fit line. | `string` | none | public |
| `Marker` | Scatter series marker. | `string` | none | public |
| `LineColor` | Color of the best-fit line. | not specified | none | public |
| `XGrid` | Axes x-grid. | `matlab.lang.OnOffSwitchState` | none | public |
| `YGrid` | Axes y-grid. | `matlab.lang.OnOffSwitchState` | none | public |
| `Controls` | Visibility of the chart controls. | `matlab.lang.OnOffSwitchState` | none | public |

## Methods

| Name | Description |
| --- | --- |
| `exportgraphics` | Call `exportgraphics` on the chart. |
| `axis` | Call `axis` on the chart. |
| `legend` | Call `legend` on the chart. |
| `grid` | Invoke grid on the axes. |
| `title` | Call `title` on the chart. |
| `ylabel` | Call `ylabel` on the chart. |
| `xlabel` | Call `xlabel` on the chart. |

## Documentation

- [`scatter`](https://www.mathworks.com/help/matlab/ref/scatter.html): create a scatter plot with variable marker color and size
- [`fitlm`](https://www.mathworks.com/help/stats/fitlm.html): fit a linear regression model

## Examples

### Create sample x and y data for the chart.

```matlab
rng( "default" )
x = randn( 1000, 1 );
y = 2 * x + 1 + 2 * randn( size( x ) );
```

### Create the chart.

```matlab
f = exampleFigure( "Name", "ScatterFitChart Example" );

SFC = ScatterFitChart( "Parent", f, ...
    "XData", x, ...
    "YData", y );
```

### Annotate the chart.

```matlab
xlabel( SFC, "x-data", "FontSize", 14 )
ylabel( SFC, "y-data", "FontSize", 14 )
title( SFC, "2D Scatter Plot with Fit", "FontSize", 14 )
grid( SFC, "on" )
legend( SFC, "Location", "northwest" );
```

### Customize the chart by adjusting its graphics properties.

```matlab
SFC.LineColor = [1, 0.5, 0];
SFC.LineWidth = 3;
SFC.CData = [0, 0.5, 0.5];
SFC.SizeData = 100;
SFC.Controls = "off";
```

### Update the chart data.

```matlab
SFC.XData = randn( 750, 1 );
SFC.YData = (-1) * SFC.XData + 2 + 2 * randn( size( SFC.XData ) );
```

## See Also

* [Scatter Fit Chart](../landing/ScatterFitChart.md)
* [Source Code Listing](../source/ScatterFitChartSourceCode.md)
* [Test Code Listing](../tests/ScatterFitChartUnitTest.md)
* [Chart Reference](../ChartsIndex.md)

