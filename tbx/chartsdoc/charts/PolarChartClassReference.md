# `PolarChart`

Plot circular data on a polar chart.

## Description

The Polar`Chart` compares two line plots of cyclic data arranged around a circular (polar) axes. The chart data comprises:
- `AngularData` - an increasing numeric vector representing the independent variable.
- `RadialData` - a two-column matrix of data, each column of which is plotted against the `AngularData` around the circle.

## Syntax

```matlab
PolarChart()
PolarChart(name, value, ...)
PC = PolarChart(name, value, ...)
```

## Input Arguments

All `PolarChart` inputs are optional name-value arguments.

## Properties

| Name | Description | Type | Default Value | Access |
| --- | --- | --- | --- | --- |
| `AngularData` | Chart angular data. | `double` | none | public |
| `RadialData` | Chart radial data. | `double` | none | public |
| `LineWidth` | Width of the lines. | `double` | `1.5` | public |
| `MarkerSize` | Marker size. | `double` | `6` | public |

## Methods

| Name | Description |
| --- | --- |
| `axis` | Call `axis` on the chart. |
| `thetatickformat` | Call `thetatickformat` on the chart. |
| `thetaticklabels` | Call `thetaticklabels` on the chart. |
| `thetaticks` | Call `thetaticks` on the chart. |
| `rtickangle` | Call `rtickangle` on the chart. |
| `rtickformat` | Call `rtickformat` on the chart. |
| `rticklabels` | Call `rticklabels` on the chart. |
| `rticks` | Call `rticks` on the chart. |
| `legend` | Call `legend` on the chart. |
| `title` | Call `title` on the chart. |

## Examples

### Create sample chart data.

The angular data comprises the months of the year, and the radial data are the average monthly temperatures for two locations (Cambridge and Glasgow).

```matlab
months = 1:12;
meanMonthlyTemps = [4, 5, 6, 9, 12, 16, 17, 18, 15, 11, 7, 4;
    3, 4, 6, 8, 11, 13, 15, 15, 13, 10, 6, 4].';
```

### Create a figure for the chart.

```matlab
f = exampleFigure( "Name", "PolarChart Example" );
```

### Create the chart, specifying the parent and input data.

```matlab
PC = PolarChart( "Parent", f, ...
    "AngularData", months, ...
    "RadialData", meanMonthlyTemps );
```

### Annotate the chart.

Create and format the title.

```matlab
title( PC, "Mean Monthly Temperatures", "FontSize", 14 )
```

Define and customize the legend entries.

```matlab
legend( PC, ["Cambridge", "Glasgow"], ...
    "FontSize", 12, ...
    "Location", "northeastoutside" )
```

Customize the angular tick labels.

```matlab
monthNames = month( datetime( 2000, 1:12, 1 ), "shortname" );
thetaticklabels( PC, monthNames )
```

Customize the radial tick labels.

```matlab
rticklabels( PC, rticklabels( PC ) + (char( 176 ) + "C") )
```

### Customize the chart appearance.

```matlab
PC.MarkerSize = 25;
PC.LineWidth = 2;
```

### Change the underlying chart data.

First, compute the mean temperature in each quarter.

```matlab
meanQuarterlyTemps = mean( reshape( meanMonthlyTemps, 3, [] ) );
meanQuarterlyTemps = reshape( meanQuarterlyTemps, [], 2 );
```

Update the angular data.

```matlab
PC.AngularData = 1:4;
```

Update the radial data.

```matlab
PC.RadialData = meanQuarterlyTemps;
```

Update the annotations.

```matlab
drawnow()
thetaticklabels( PC, "Q" + thetaticklabels( PC ) )
title( PC, "Mean Quarterly Temperatures" )
```

## See Also

* [Polar Chart](PolarChart.md)
* [Source Code Listing](PolarChartSourceCode.md)
* [Unit Test Listing](PolarChartUnitTest.md)
* [Chart Reference](ChartsIndex.md)

