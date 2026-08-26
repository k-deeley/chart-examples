# Graphics Hierarchy Chart

## Overview

The `GraphicsHierarchyChart` visualizes the MATLAB graphics hierarchy descending from a given graphics object using a [`graph`](https://www.mathworks.com/help/matlab/ref/graph.html) plot. This chart is useful when debugging more complex visualizations or application components.
The chart uses a recursive algorithm ([`kids2graph`](../../charts/kids2graph.m)) to find the descendants of the given graphics object representing the root node of the tree. The chart also provides an option to include graphics objects with hidden handles. By default, only descendants with visible handles are shown.
We can use the convenience function [`plotkids`](../../charts/plotkids.m) to create the chart.

![](./images/GraphicsHierarchyChart.png)

## Documentation

- [`graph`](https://www.mathworks.com/help/matlab/ref/graph.html): Graph with undirected edges
- [`plot`](https://www.mathworks.com/help/matlab/ref/graph.plot.html): Plot graph nodes and edges
- [`plotkids`](../../charts/plotkids.m): Convenience function for creating a graphics hierarchy chart
- [`kids2graph`](../../charts/kids2graph.m): Construct a graph listing the descendants of the given graphics object

## Examples

### Visualize data using a scatter plot.

Generate random data.

```matlab
rng( "default" )
n = 100;
x = rand( n, 1 );
y = rand( n, 2 );
```

Create the scatter plot.

```matlab
f = figure;
scatter( x, y, "filled" )
legend( "A", "B" )
```

### Visualize the graphics hierarchy under the figure.

```matlab
fchart = exampleFigure( "Name", "GraphicsHierarchyChart Example" );
GHC = plotkids( f, "Parent", fchart );
```
