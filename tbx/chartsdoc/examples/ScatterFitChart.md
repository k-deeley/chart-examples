# Scatter Fit Chart

## Overview

The `ScatterFitChart` manages bivariate scattered data together with the associated best-fit trend line (regression line). The chart data comprises numeric vectors `XData` and `YData`. The `YData` is scattered against the `XData` and the best-fit line is computed using the `fitlm` function to perform linear regression.

![](./images/ScatterFitChart.png)

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

### Create a figure for the chart.

```matlab
f = exampleFigure( "Name", "ScatterFitChart Example" );
```

### Create the chart.

```matlab
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
