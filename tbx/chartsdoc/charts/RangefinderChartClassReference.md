# `RangefinderChart`

Show median crossover and marginal adjacent values.

## Description

The `RangefinderChart` creates a visualization of bivariate scattered data together with horizontal and vertical lines representing marginal data statistics. Specifically, the chart comprises
- a 2D discrete plot containing the scattered $(x, y)$ data,
- a crosshair indicating the intersection of the marginal medians,
- vertical lines indicating the lower and upper adjacent values for the $x$ data,
- horizontal lines indicating the lower and upper adjacent values for the $y$ data.
The lengths of the lines are given by the marginal interquartile ranges. The *adjacent values* are the nearest data points inside the range determined by the lower and upper values. The *lower and upper values* are 1.5 interquartile ranges outside of the lower and upper quartiles, respectively.
The chart data comprises numeric vectors `XData` and `YData`.

## Syntax

```matlab
RangefinderChart()
RangefinderChart(name, value, ...)
RFC = RangefinderChart(name, value, ...)
```

## Input Arguments

All `RangefinderChart` inputs are optional name-value arguments.

## Properties

| Name | Description | Type | Default Value | Access |
| --- | --- | --- | --- | --- |
| `XData` | Chart x-data. | `double` | none | public |
| `YData` | Chart y-data. | `double` | none | public |
| `Marker` | for the discrete plot. | `string` | `"o"` | public |
| `SizeData` | Size data for the discrete plot. | `double` | `36` | public |
| `CData` | Color of the discrete plot. | `double` | `[0 0.447 0.741]` | public |
| `XGrid` | Axes x-grid. | `matlab.lang.OnOffSwitchState` | `"on"` | public |
| `YGrid` | Axes y-grid. | `matlab.lang.OnOffSwitchState` | `"on"` | public |
| `LineWidth` | Width of the adjacent lines. | `double` | `3` | public |

## Methods

| Name | Description |
| --- | --- |
| `axis` | Call `axis` on the chart. |
| `title` | Call `title` on the chart. |
| `ylabel` | Call `ylabel` on the chart. |
| `xlabel` | Call `xlabel` on the chart. |

## Examples

### Create sample chart data.

We start by defining sample $x$ and $y$ data vectors for the chart.

```matlab
numPoints = 1000;
rng( "default" )
x = 2 * randn( numPoints, 1 );
y = 2 * x + 1 + 2 * randn( numPoints, 1 );
```

### Create a figure for the chart.

```matlab
f = exampleFigure( "Name", "RangefinderChart Example" );
```

### Create the chart, specifying the parent and input data.

```matlab
RFC = RangefinderChart( "Parent", f, ...
    "XData", x, ...
    "YData", y );
```

### Annotate the chart.

```matlab
xlabel( RFC, "x" )
ylabel( RFC, "y" )
title( RFC, "Rangefinder Chart" )
```

### Truncate the $x$-data of the chart.

```matlab
RFC.XData = RFC.XData(1:round(numPoints/10));
```

### Reinstate the original chart data.

```matlab
RFC.XData = x;
RFC.YData = y;
```

### Modify the $y$ data of the chart.

```matlab
RFC.YData = (-1) * RFC.YData;
```

### Translate the chart data.

```matlab
RFC.XData = 5 + RFC.XData;
RFC.YData = -5 + RFC.YData;
```

### Customize the chart appearance.

```matlab
RFC.Marker = ".";
RFC.SizeData = 64;
RFC.CData = [1, 0.2, 0];
```

## See Also

* [Rangefinder Chart](RangefinderChart.md)
* [Source Code Listing](RangefinderChartSourceCode.md)
* [Unit Test Listing](RangefinderChartUnitTest.md)
* [Chart Reference](ChartsIndex.md)

