# `ScatterBoxChart`

Bivariate scatter plot with marginal boxplots

## Overview

The `ScatterBoxChart` manages a bivariate scatter plot with marginal boxplots. The chart data comprises two numeric vectors (`XData` and `YData`) . The `YData` is scattered against the `XData` on the main chart axes, and the marginal boxplots for the `XData` and `YData` are drawn on separate axes underneath and to the left of the main axes, respectively.

![](../images/ScatterBoxChart.png)

## Syntax

```matlab
ScatterBoxChart()
ScatterBoxChart(name, value, ...)
SBC = ScatterBoxChart(name, value, ...) 
```

## Input Arguments

All `ScatterBoxChart` inputs are optional name-value arguments.

## Properties

| Name | Description | Type | Default Value | Access |
| --- | --- | --- | --- | --- |
| `XData` | Chart x-data. | `double` | none | public |
| `YData` | Chart y-data. | `double` | none | public |
| `ScatterSizeData` | Size data for the scatter series. | `double` | none | public |
| `ScatterCData` | Color data for the scatter series. | `double` | none | public |
| `ScatterMarker` | Marker style for the scatter series. | `string` | none | public |
| `FilledScatterMarkers` | Filled marker state for the scatter series. | `matlab.lang.OnOffSwitchState` | none | public |
| `VariableSizeScatterMarkers` | Variable size marker state for the scatter series. | `matlab.lang.OnOffSwitchState` | none | public |
| `XGrid` | Axes x-grid. | `matlab.lang.OnOffSwitchState` | none | public |
| `YGrid` | Axes y-grid. | `matlab.lang.OnOffSwitchState` | none | public |
| `Controls` | Visibility of the chart controls. | `matlab.lang.OnOffSwitchState` | none | public |
| `BoxFaceColor` | Boxchart face color. | not specified | none | public |
| `WhiskerLineStyle` | Boxchart whisker line style. | `string` | none | public |
| `WhiskerLineColor` | Boxchart whisker line color. | not specified | none | public |
| `BoxMarkerColor` | Boxchart marker color. | not specified | none | public |
| `BoxMarkerSize` | Boxchart marker size. | `double` | none | public |
| `BoxMarker` | Boxchart marker. | `string` | none | public |
| `BoxLineWidth` | Boxchart line width. | `double` | none | public |

## Methods

| Name | Description |
| --- | --- |
| `exportgraphics` | Call `exportgraphics` on the chart. |
| `axis` | Call `axis` on the chart. |
| `grid` | Invoke grid on the axes. |
| `legend` | Call `legend` on the chart. |
| `title` | Call `title` on the chart. |
| `ylabel` | Call `ylabel` on the chart. |
| `xlabel` | Call `xlabel` on the chart. |

## Documentation

- [`scatter`](https://www.mathworks.com/help/matlab/ref/scatter.html): create a scatter plot with variable marker color and size
- [`boxchart`](https://www.mathworks.com/help/matlab/ref/boxchart.html): create a boxchart with variable properties

## Examples

### Create sample x and y data for the chart.

```matlab
rng( "default" )
x = randn( 1000, 1 );
y = 2 * x + 1 + 3 * randn( size( x ) );
```

### Create the chart, specifying the parent, position and input data.

```matlab
f = exampleFigure( "Name", "ScatterBoxChart Example" );

SBC = ScatterBoxChart( "Parent", f, ...
    "XData", x, ...
    "YData", y );
```

### Annotate the chart.

```matlab
xlabel( SBC, "x-data", "FontSize", 14 )
ylabel( SBC, "y-data", "FontSize", 14 )
title( SBC, "Scatter Boxchart", "FontSize", 16 )
legend( SBC, "(x, y) data" )
grid( SBC, "on" )
```

### Customize the scatter plot appearance.

First, change the marker used for the scatter plot.

```matlab
SBC.ScatterMarker = "square";
```

### Next, specify that the scatter plot should have filled markers.

```matlab
SBC.FilledScatterMarkers = true;
```

### The marker size in the scatter plot is uniform by default.

We can set a uniform, constant value for the `ScatterSizeData` property.

```matlab
SBC.ScatterSizeData = 6;
```

### We can also use variable size markers for the scatter plot.

Let's create a regularly-spaced vector of marker size values.

```matlab
variableMarkerSizes = linspace( 1, 50, numel( SBC.XData ) );
```

Update the chart to use these sizes for the scattered data points.

```matlab
SBC.ScatterSizeData = variableMarkerSizes;
```

### Similarly, the scatter plot color is uniform by default.

We can set a uniform, constant value for the `ScatterCData` property.

```matlab
SBC.ScatterCData = [1, 0.5, 0];
```

### We can also use variable colors for the scatter plot.

Let's apply a color gradient to the scatter series based on each point's distance from the origin (0, 0).
First, create the color scheme by indexing into a predefined MATLAB colormap.

```matlab
d = sqrt( x.^2 + y.^2 );
n = numel( x );
d = round( 1 + ( n - 1 ) * rescale( d ) );
map = cool( n );
colorGradient = map(d, :);
```

Apply the color gradient to the chart's scatter series.

```matlab
SBC.ScatterCData = colorGradient;
```

### Customize the marginal boxplots.

As well as having the flexibility to customize the scatter plot representing the joint density of the $(x, y)$ data, we can also adjust the appearance of the marginal $x$- and $y$-boxplots. When modifying these properties, all changes apply to both marginal boxplots.
For example, we can change the boxcharts' box color.

```matlab
SBC.BoxFaceColor = "magenta";
```

### Adjust the boxcharts' whiskers and box appearance.

Change the whisker line style.

```matlab
SBC.WhiskerLineStyle = ":";
```

Change the whisker line color.

```matlab
SBC.WhiskerLineColor = [0, 0.5, 1];
```

Change the whisker line width and the width of the lines used to display the box.

```matlab
SBC.BoxLineWidth = 2;
```

### Modify the boxcharts' outlier appearance.

We use the [set](https://www.mathworks.com/help/matlab/ref/set.html) function to assign multiple chart properties in one command.

```matlab
set( SBC, "BoxMarker", ".", ...
    "BoxMarkerSize", 20, ...
    "BoxMarkerColor", [0.8, 0.3, 0] )
```

### Change the x-data of the chart.

The chart supports individual or simultaneous changes to its $x$-data and $y$-data, including changes in the length of the data.

```matlab
SBC.XData = x(1:500);
```

### Change the y-data of the chart.

```matlab
SBC.YData = (-1) * SBC.XData + randn( size( SBC.XData ) );
```

## See Also

* [Scatter Box Chart](../landing/ScatterBoxChart.md)
* [Source Code Listing](../source/ScatterBoxChartSourceCode.md)
* [Test Code Listing](../tests/ScatterBoxChartUnitTest.md)
* [Chart Examples](../../ChartExamples.md)

