# Cylinder Chart

## Overview

The `CylinderChart` creates three-dimensional stacked cylinders, similar to a stacked bar graph. The chart data comprises a nonnegative numeric 2-D matrix (`Data`). The number of stacks is equal to the number of rows of `Data`, and each stack is positioned on the $x$-axis of the chart. The number of cylinders within each stack is equal to the number of columns of `Data`. The heights of the cylinders within each stack correspond to the values contained in each row of `Data`.

![](./images/CylinderChart.png)

## Documentation

- [`cylinder`](https://www.mathworks.com/help/matlab/ref/cylinder.html): Create $x$, $y$ and $z$-coordinates for a cylinder
- [`surface`](https://www.mathworks.com/help/matlab/ref/surface.html): Primitive surface plot

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
