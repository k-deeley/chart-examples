# Waterfall Chart

## Overview

The `WaterfallChart` visualizes the cumulative evolution of an initial value using floating bars to represent each change in the data. The final bar on the right-hand side of the chart represents the sum of the data values. At any given point on the $x$-axis, the chart shows the cumulative sum of the data values up to and including the current point.
The chart data comprises a numeric, real-valued vector `Data`.

![](./images/WaterfallChart.png)

## Documentation

- [`patch`](https://www.mathworks.com/help/matlab/ref/patch.html): create patches of colored polygons
- [`bar`](https://www.mathworks.com/help/matlab/ref/bar.html): bar graph
- [`line`](https://www.mathworks.com/help/matlab/ref/line.html): create primitive line
- [`text`](https://www.mathworks.com/help/matlab/ref/text.html): add text descriptions to data points

## Examples

### Create sample chart data.

```matlab
rng( "default" )
data = randi( [-6, 6], 10, 1 );
```

### Create a figure for the chart.

```matlab
f = exampleFigure( "Name", "WaterfallChart Example" );
```

### Create the chart.

```matlab
WC = WaterfallChart( "Parent", f, "Data", data );
```

### Annotate the chart.

```matlab
xlabel( WC, "x-data" )
ylabel( WC, "y-data" )
title( WC, "Waterfall Chart" )
grid( WC, "on" )
```

### Customize the chart's appearance.

Define distinct colors to distinguish positive and negative values.

```matlab
WC.BarFaceColor = "updown";
```

Customize the bar labels.

```matlab
WC.BarLabelFormat = "$%.2f";
```

Adjust the bar appearance.

```matlab
set( WC, "BarFaceAlpha", 0.75, "LineWidth", 2, "TotalBarFaceAlpha", 0.75 )
```

### Modify the chart's data.

Generate new data and update the bar colors.

```matlab
newData = randi( [-6, 6], 15, 1 );
WC.Data = newData;
```

### Select a subset of the chart data.

```matlab
WC.Data = WC.Data(1:5);
```

### Customize the base and target lines.

```matlab
set( WC, "BaseLineWidth", 2, ...
    "TargetLineVisible", "on", ...
    "TargetLineValue", 5, ...
    "TargetLineColor", "y", ...
    "TargetLineLabel", "Target", ...
    "TargetLineWidth", 2 )

```
