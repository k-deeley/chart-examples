# `CylinderChart`

Plot data using stacked cylinders.

## Description

The `CylinderChart` creates three-dimensional stacked cylinders, similar to a stacked bar graph. The chart data comprises a nonnegative numeric 2-D matrix (`Data`). The number of stacks is equal to the number of rows of `Data`, and each stack is positioned on the $x$-axis of the chart. The number of cylinders within each stack is equal to the number of columns of `Data`. The heights of the cylinders within each stack correspond to the values contained in each row of `Data`.

## Syntax

```matlab
CylinderChart()
CylinderChart(name, value, ...)
CC = CylinderChart(name, value, ...)
```

## Input Arguments

All `CylinderChart` inputs are optional name-value arguments.

## Properties

| Name | Description | Type | Default Value | Access |
| --- | --- | --- | --- | --- |
| `Data` | Chart data. | `double` | none | public |
| `View` | Axes view (azimuth, elevation). | `double` | `[-16 12]` | public |
| `FaceColors` | Three-column numeric matrix of cylinder face colors. | not specified | none | public |
| `NumStacks` | Number of cylindrical stacks. | `double` | none | read-only |
| `NumLayers` | Number of layers within each cylindrical stack. | `double` | none | read-only |

## Methods

| Name | Description |
| --- | --- |
| `axis` | Call `axis` on the chart. |
| `xtickangle` | Call `xtickangle` on the chart. |
| `xticklabels` | Call `xticklabels` on the chart. |
| `legend` | Call `legend` on the chart. |
| `title` | Call `title` on the chart. |
| `zlabel` | Call `zlabel` on the chart. |
| `xlabel` | Call `xlabel` on the chart. |

## Examples

### Create sample chart data.

The data in each row corresponds to a single stack, and the data in each column corresponds to the heights of the individual cylinders within the stack.

```matlab
Y = [2, 2, 3;
    2, 5, 6;
    2, 8, 9;
    2, 11, 12];
```

### Create a figure for the chart.

```matlab
f = exampleFigure( "Name", "CylinderChart Example" );
```

### Create the chart, specifying the parent and input data.

```matlab
CC = CylinderChart( "Parent", f, "Data", Y );
```

### Annotate the chart.

```matlab
xlabel( CC, "Stacks", "FontSize", 14 )
zlabel( CC, "Values", "FontSize", 14 )
title( CC, "Cylinder Chart", "FontSize", 14 )
xticklabels( CC, ["A", "B", "C", "D"] )
```

### Change the cylinder face colors.

```matlab
CC.FaceColors = copper( 3 );
```

### Truncate the current chart data by removing a stack.

```matlab
CC.Data = CC.Data(1:3, :);
```

### Extend the current chart data by creating multiple stacks.

```matlab
CC.Data = [CC.Data; CC.Data];
```

### Change the data by increasing the number of layers.

```matlab
CC.Data = [ones( height( CC.Data ), 1 ), CC.Data];
```

### Modify the axis tick labels and truncate the chart data.

```matlab
xticklabels( CC, ["X", "Y", "Z", "A", "B", "C"] )
CC.Data = CC.Data(1:end-1, :);
```

### Remove the top layer of chart data.

```matlab
CC.Data = CC.Data(:, 1:end-1);
```

### Change the chart view and face colors.

```matlab
set( CC, "View", [-14, 12], "FaceColors", hsv( 3 ) )
```

## See Also

* [`CylinderChart`](CylinderChart.md)
* [Source Code Listing](CylinderChartSourceCode.md)
* [Chart Reference](ChartsIndex.md)

