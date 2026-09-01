# `SankeyChart`

Illustrate the flow between different states

## Overview

The `SankeyChart` comprises nodes and links. The links represent flow from one node to another, and the size of the link is proportional to the flow rate.
Clicking on a link provides more detailed information about the source and target nodes as well as the flow rate. Clicking on a node will highlight all incoming and outgoing links.

![](../images/SankeyChart.png)

## Syntax

```matlab
SankeyChart()
SankeyChart(name, value, ...)
SC = SankeyChart(name, value, ...) 
```

## Input Arguments

All `SankeyChart` inputs are optional name-value arguments.

## Properties

| Name | Description | Type | Default Value | Access |
| --- | --- | --- | --- | --- |
| `GraphData` | Directed graph representing the Sankey diagram. | `digraph` | none | public |
| `LabelAlignment` | Node label alignment. | `string` | none | public |
| `LabelIncludeTotal` | Flag to display totals. | `matlab.lang.OnOffSwitchState` | none | public |
| `LinkColor` | Link color. | not specified | none | public |
| `LinkType` | Curve type. | `string` | none | public |
| `NodeColor` | Node color. | not specified | none | public |
| `NodePadRatio` | Vertical space between nodes. | `double` | none | public |
| `NodeWidth` | Node width. | `double` | none | public |
| `XNodeData` | Node x-coordinates. | `double` | none | public |
| `YNodeData` | Node y-coordinates. | `double` | none | public |
| `LinkAlpha` | Link transparency. | `double` | `0.5` | public |
| `LinkEdgeColor` | Link edge color. | not specified | `"black"` | public |
| `LinkEdgeStyle` | Link edge style. | `string` | `"none"` | public |
| `LinkEdgeWidth` | Link edge width. | `double` | `0.5` | public |
| `LinkFontSize` | Font size for link annotations. | `double` | `10` | public |
| `NodeAlpha` | Node transparency. | `double` | `1` | public |
| `NodeEdgeColor` | Node edge color. | not specified | `"black"` | public |
| `NodeEdgeStyle` | Node edge line style. | `string` | `"-"` | public |
| `NodeEdgeWidth` | Node edge width. | `double` | `0.5` | public |
| `NodeFontSize` | Node label font size. | `double` | `10` | public |
| `NodeLabelInterpreter` | Node label interpreter. | `string` | `"tex"` | public |
| `NodeLabelVisible` | Node label visibility. | `matlab.lang.OnOffSwitchState` | `"on"` | public |
| `NodeLabelClickedFcn` | NodeLabelClickedFcn is a generated callback property for the event: NodeLabelClicked | not specified | `""` | public |

## Methods

| Name | Description |
| --- | --- |
| `title` | Call `title` on the chart. |

## Documentation

- [`digraph`](https://www.mathworks.com/help/matlab/ref/digraph.html): Graph with directed links
- [`patch`](https://www.mathworks.com/help/matlab/ref/patch.html): Create patches of colored polygons

## Examples

### Define the chart data.

The chart data is specified using a directed graph. The links represent the flow between two nodes, using the weight to specify the flow rate.

```matlab
sourceNodes = [1, 1, 2, 2, 3, 4, 5];
sinkNodes = [3, 4, 4, 5, 6, 6, 7];
flowRates = [4, 2, 3, 1, 4, 5, 1];
nodeLabels = ["A", "B", "C", "D", "E", "F", "G"];
DG = digraph( sourceNodes, sinkNodes, flowRates, nodeLabels );
```

Visualize the chart data using a directed graph plot.

```matlab
figure
plot( DG, "EdgeLabel", DG.Edges.Weight )
title( "Directed Graph" )
```

### Create the chart.

Next, create the chart object, specifying the `Parent` and `GraphData` properties.

```matlab
f = exampleFigure( "Name", "SankeyChart Example" );

SC = SankeyChart( "Parent", f, "GraphData", DG );
```

### Change link properties.

### Color

The links' color can be specified as a single color, or can be connected to the nodes via the **`"source"`**, **`"target"`** and **`"gradient"`** options.

```matlab
SC.LinkColor = "gradient";
```

### Type

We can adjust the shape of the chart's links. Options starting with "v" will have a constant vertical cross section while others have a constant perpendicular cross section.

```matlab
SC.LinkType = "vtanh";
```

### Change node properties.

### Color

We can modify the nodes' color using RGB triples.

```matlab
SC.NodeColor(1,:) = [1, 0, 0];
```

### Vertical spacing

We can modify the vertical spacing as a percentage of the nodes' total height.

```matlab
SC.NodePadRatio = 0.25;
```

### Width

Modify the nodes' width.

```matlab
SC.NodeWidth = 0.2;
```

### Position

Reposition the nodes by specifying their $x$ and $y$ coordinates.

```matlab
SC.XNodeData(end) = 3.5;
SC.YNodeData([3,4]) = SC.YNodeData([3,4]) + 2;
```

### Label position

Modify the label position relative to the node.

```matlab
SC.LabelAlignment = "bottom";
```

### Label content

Modify the label content to display the total flow or not.

```matlab
SC.LabelIncludeTotal = "on";
```

For nodes that have different incoming and outgoing flows, the label will show the difference in the form: $\\left\\lbrace \\textrm{in}\\right\\rbrace \\longrightarrow \\left\\lbrace \\textrm{out}\\right\\rbrace$.

### Modify the chart data.

Let's display a more complex graph representing an energy flow diagram.
Load sample chart data, obtained from figure 1 in:
- Hay, B. & Hameury, Jacques & Scoarnec, V & DavÃƒÂ©e, G & Grelard, M. (2011). *The Contribution of the Metrology of Thermophysical Properties of Materials in Automotive Design.*

```matlab
load( fullfile( chartsRoot(), "data", "Graph.mat" ) )
disp( linkData )
```

Create a graph from the link table.

```matlab
DG = digraph( linkData );
```

Modify the data in the chart.

```matlab
SC.GraphData = DG;
```

Adjust the node position.

```matlab
SC.YNodeData(13:end) = SC.YNodeData(13:end) - 50;
```

### Annotate the chart.

```matlab
title( SC, "Diesel Engine Energy Flow" )
```

## See Also

* [Sankey Chart](../landing/SankeyChart.md)
* [Source Code Listing](../source/SankeyChartSourceCode.md)
* [Test Code Listing](../tests/SankeyChartUnitTest.md)
* [Chart Examples](../../ChartExamples.md)

