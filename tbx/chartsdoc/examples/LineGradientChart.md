# Line Gradient Chart

## Overview

The `LineGradientChart` manages a line plot which has an associated color gradient. The chart data comprises an increasing `datetime` vector (`XData`) together with a numeric data vector (`YData`). The `YData` is plotted against the `XData` and the color gradient corresponds to the values contained in `YData`.

![](./images/LineGradientChart.png)

## Documentation

- [`surface`](https://www.mathworks.com/help/matlab/ref/surface.html): creates a primitive, three-dimensional surface plot.

## Examples

### Create data for the chart: dates and a random walk.

```matlab
dates = datetime( 1970, 1, 1 ) : datetime( 1980, 1, 1 );
rng( "default" )
steps = [0, randn( size( dates(1:end-1) ) )];
walk = cumsum( steps );
```

### Create a figure for the chart.

```matlab
f = exampleFigure( "Name", "LineGradientChart Example" );
```

### Create the chart, specifying the data and figure.

```matlab
LGC = LineGradientChart( "Parent", f, ...
    "XData", dates, ...
    "YData", walk );
```

### Annotate the chart and customize its appearance.

```matlab
xlabel( LGC, "Date", "FontSize", 14 )
ylabel( LGC, "Value", "FontSize", 14 )
title( LGC, "Line Gradient Chart", "FontSize", 16 )
```

### Adjust the width of the line.

```matlab
LGC.LineWidth = 1.5;
```

### Change the colormap.

```matlab
colormap( LGC, cool() )
```

### Change the x-data of the chart to the first 1000 dates.

```matlab
LGC.XData = LGC.XData(1:1000);
```

### Change the dates by translating by 10 calendar years.

```matlab
LGC.XData = LGC.XData + calyears( 10 );
```

### Change the y-data of the chart to a new random walk.

```matlab
LGC.YData = cumsum( randn( size( LGC.XData ) ) );
```
