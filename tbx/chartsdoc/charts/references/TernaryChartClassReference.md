# `TernaryChart`

Plot three variables that sum to a constant.

## Overview

The `TernaryChart` manages a barycentric plot of three variables $A$, $B$ and $C$ that sum to a constant. The chart provides a smooth, interpolated surface for the observed data $Z$. The chart data comprises a table of numeric data containing the three input variables $A$, $B$, $C$ together with the response (output) variable $Z$. For each data point $(A\_i, B\_i, C\_i, Z\_i)$ we have $A\_i + B\_i + C\_i=1$. The chart is equipped with a control panel and contains interactive information on the data composition at each specific point via data tips.

![](../images/TernaryChart.png)

## Syntax

```matlab
TernaryChart()
TernaryChart(name, value, ...)
TC = TernaryChart(name, value, ...) 
```

## Input Arguments

All `TernaryChart` inputs are optional name-value arguments.

## Properties

| Name | Description | Type | Default Value | Access |
| --- | --- | --- | --- | --- |
| `Data` | Table of data: columns 1-3 are inputs and column 4 is the output. | `table` | none | public |
| `GridResolution` | Resolution of the grid. | `double` | none | public |
| `TickRate` | Tick rate. | `double` | none | public |
| `Direction` | of the ternary plot. | `string` | none | public |
| `Marker` | Scatter series marker. | `string` | `"."` | public |
| `MarkerSize` | Scatter series marker size. | `double` | `36` | public |
| `MarkerEdgeColor` | Scatter series marker edge color. | not specified | `"flat"` | public |
| `MarkerFaceColor` | Scatter series marker face color. | not specified | `"none"` | public |
| `FaceColor` | Surface face color. | not specified | `"flat"` | public |
| `EdgeColor` | Surface edge color. | not specified | `[0 0 0]` | public |
| `FaceAlpha` | Surface face alpha. | `double` | `1` | public |
| `EdgeAlpha` | Surface edge alpha. | `double` | `1` | public |
| `LineStyle` | Surface line style. | `string` | `"-"` | public |
| `LineWidth` | Surface line width. | `double` | `0.5` | public |
| `FaceLighting` | Surface face lighting. | `string` | `"flat"` | public |
| `EdgeLighting` | Surface edge lighting. | `string` | `"none"` | public |
| `ShowTicks` | Tick visibility. | `matlab.lang.OnOffSwitchState` | `"on"` | public |
| `AxisLineWidth` | Axis line width. | `double` | none | public |
| `GridVisible` | Grid visibility. | `matlab.lang.OnOffSwitchState` | none | public |
| `GridLineWidth` | Grid line width. | `double` | none | public |
| `ScatterVisible` | Scatter series visibility. | `matlab.lang.OnOffSwitchState` | none | public |
| `ColorbarVisible` | Colorbar visibility. | `matlab.lang.OnOffSwitchState` | none | public |
| `Controls` | Visibility of the chart controls. | `matlab.lang.OnOffSwitchState` | none | public |
| `SurfaceType` | Surface type. | `string` | none | public |
| `InterpolationMethod` | Surface interpolation method. | `string` | none | public |

## Methods

| Name | Description |
| --- | --- |
| `exportgraphics` | Call `exportgraphics` on the chart. |
| `resetLabels` | Modify the labels to match the table headers |
| `swapdata` | Interchange two chart data variables. |
| `rotate` | Rotate the chart in the specified direction. |
| `view` | Call `view` on the chart. |
| `colormap` | Call `colormap` on the chart. |
| `colorbar` | Call the colorbar function on the chart's axes. |
| `title` | Call `title` on the chart. |
| `zlabel` | Add a z-label to the chart. |
| `ylabel` | Add left/right y-labels to the chart. |
| `xlabel` | Add an x-label to the chart. |

## Documentation

- [`patch`](https://www.mathworks.com/help/matlab/ref/patch.html): create a surface plot with variable geometric shapes
- [`line`](https://www.mathworks.com/help/matlab/ref/line.html): create a line with variable properties (used for the discrete points)

## Examples

### Load sample data for the chart.

This data set comprises three chemicals (methanol, acetone and chloroform) together with the bubble point of the ternary mixture at a fixed pressure.

```matlab
load( fullfile( chartsRoot(), "data", "Chemicals.mat" ) )
disp( T )
```

### Create a figure for the chart.

```matlab
f = exampleFigure( "Name", "TernaryChart Example" );
```

### Create the chart.

```matlab
TC = TernaryChart( "Parent", f, ...
    "Data", T );
```

### Annotate the chart.

```matlab
xlabel( TC, "Methanol", "FontSize", 12 )
ylabel( TC, "left", "Acetone", "FontSize", 12 )
ylabel( TC, "right", "Chloroform", "FontSize", 12 )
zlabel( TC, ...
    "Ternary mixture bubble point at 101.325 kPa (" + char( 176 ) + "C)", ...
    "FontSize", 12, "FontWeight", "bold" )
colormap( TC, cool() )
colorbar( TC )
```

### Customize the chart's appearance.

First, adjust the marker size of the discrete data points.

```matlab
TC.MarkerSize = 20;
```

Modify the transparency of the surface.

```matlab
TC.FaceAlpha = 0.75;
```

By default, when the `SurfaceType` is `"surface"`, the `EdgeColor` is `[0, 0, 0]`.

```matlab
TC.EdgeColor = "flat";
```

### Modify the chart's surface type.

The ternary chart supports both the surface and mesh types.

```matlab
TC.SurfaceType = "mesh";
TC.LineWidth = 3;
```

### Modify the chart's grid and ticks.

We can set a new value for the `GridResolution` property.

```matlab
TC.GridResolution = 20;
```

The `TickRate` property controls the number of axes ticks.

```matlab
TC.TickRate = 2;
```

### Adjust the chart's view.

The ternary chart has the view method for adjusting the camera angle. This method has the same syntax as the usual axes [view](https://www.mathworks.com/help/matlab/ref/view.html) function.

```matlab
view( TC, [-2, 55] )
set( TC, "GridResolution", 5, "TickRate", 1 )
```

### Rotate the chart.

We can use the `rotate` method to rotate the chart clockwise or counter-clockwise by 120 degrees.

```matlab
TC.rotate( "clockwise" )
```

### Enable the chart's control panel.

```matlab
TC.Controls = "on";
colorbar( TC, "off" )
```

## See Also

* [Ternary Chart](../landing/TernaryChart.md)
* [Source Code Listing](../source/TernaryChartSourceCode.md)
* [Test Code Listing](../tests/TernaryChartUnitTest.md)
* [Chart Reference](../ChartsIndex.md)

