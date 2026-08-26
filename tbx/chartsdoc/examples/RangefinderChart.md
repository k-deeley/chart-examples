# Rangefinder Chart

## Overview

The `RangefinderChart` creates a visualization of bivariate scattered data together with horizontal and vertical lines representing marginal data statistics. Specifically, the chart comprises
- a 2D discrete plot containing the scattered $(x, y)$ data,
- a crosshair indicating the intersection of the marginal medians,
- vertical lines indicating the lower and upper adjacent values for the $x$ data,
- horizontal lines indicating the lower and upper adjacent values for the $y$ data.
The lengths of the lines are given by the marginal interquartile ranges. The *adjacent values* are the nearest data points inside the range determined by the lower and upper values. The *lower and upper values* are 1.5 interquartile ranges outside of the lower and upper quartiles, respectively.
The chart data comprises numeric vectors `XData` and `YData`.

![](./images/RangefinderChart.png)

## Documentation

- [`scatter`](https://www.mathworks.com/help/matlab/ref/scatter.html): Scatter plot
- [`line`](https://www.mathworks.com/help/matlab/ref/line.html): Create primitive line
- [`plot`](https://www.mathworks.com/help/matlab/ref/plot.html): 2-D line plot
- [`datatip`](https://www.mathworks.com/help/matlab/ref/datatip.html): Create data tip
- Martinez, W.L., Martinez, A.R. and Solka, J.L. 2011. \*Exploratory Data Analysis with MATLAB (Second Edition), \*Chapter 9, Section 9.5 (pp. 356-359). Boca Raton, Florida: Chapman and Hall/CRC Press, Taylor & Francis Group.

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
