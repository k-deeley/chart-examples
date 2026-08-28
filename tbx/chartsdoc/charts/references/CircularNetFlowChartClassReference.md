# `CircularNetFlowChart`

Show directed to/from relationships between pairs of categories

## Overview

The `CircularNetFlowChart` creates a circular chart representing the net flow between pairs of categories. There are finitely many categories arranged around the circle. The outer ring of the chart contains circular arcs with size representing the net flow from each category. The inner component of the chart contains nodes with size representing the net flow received by each category. The chart data comprises a table `LinkData`, with the following specifications.
- The table contents `A = LinkData{:, :}` is a square, nonnegative numeric 2-D matrix in which `A(i, j)` contains the (gross) flow from category `i` to category `j`. The number of rows and columns of `A` is equal to the number of categories. The diagonal elements of `A` are all zero, indicating that there is no self-flow from a category to itself.
- The variable names of the table are the names of the categories.
The chart computes the net flow between each pair of categories from the table `LinkData`, before using the net flow data to update the graphics.

![](../images/CircularNetFlowChart.png)

## Syntax

```matlab
CircularNetFlowChart()
CircularNetFlowChart(name, value, ...)
CNFC = CircularNetFlowChart(name, value, ...) 
```

## Input Arguments

All `CircularNetFlowChart` inputs are optional name-value arguments.

## Properties

| Name | Description | Type | Default Value | Access |
| --- | --- | --- | --- | --- |
| `LinkData` | Chart data table. | `table` | none | public |
| `OuterLabelOffset` | Offset for the outer labels. | `double` | none | public |
| `FaceAlpha` | Transparency of the link patches. | `double` | `0.5` | public |
| `ShowLabels` | Visibility of the text labels. | `matlab.lang.OnOffSwitchState` | `"on"` | public |
| `NetFlow` | Derived net flow, presented as a table. | `table` | none | read-only |
| `NetSent` | Net amounts sent. | `table` | none | read-only |
| `NetReceived` | Net amounts received. | `table` | none | read-only |
| `Labels` | Chart data labels. | `string` | none | read-only |

## Methods

| Name | Description |
| --- | --- |
| `title` | Call `title` on the chart. |

## Documentation

- [`patch`](https://www.mathworks.com/help/matlab/ref/patch.html): Plot one or more filled polygonal regions

## Examples

### Create sample chart data.

Each row of the matrix represents a source ("from") category, and each column represents a sink ("to") category. The matrix element `(i, j)` contains the (gross) flow from category `i` to category `j`. The diagonal elements of the matrix are zero, indicating no self-flow.

```matlab
n = 6;
linkdata = magic( n );
linkdata(1:n+1:end) = 0;
```

Create a list of text labels, representing the names of the categories.

```matlab
labels = ["A", "B", "C", "D", "E", "F"];
```

Tabulate the link data.

```matlab
linkdata = array2table( linkdata, "VariableNames", labels );
```

### Create the chart, specifying the parent and input data.

```matlab
f = exampleFigure( "Name", "CircularNetFlowChart Example" );

CNFC = CircularNetFlowChart( "Parent", f, ...
    "LinkData", linkdata );
```

### Adjust the chart title.

```matlab
title( CNFC, "CircularNetFlow Chart", "Position", [50, 120, 0] )
```

### Display the net flow and net sent/received amounts.

```matlab
disp( CNFC.NetFlow )
disp( "Net amounts sent:" )
disp( CNFC.NetSent )
disp( "Net amounts received: " )
disp( CNFC.NetReceived )
```

### Adjust the transparency of the chart.

```matlab
CNFC.FaceAlpha = 0.25;
```

## See Also

* [Circular Net Flow Chart](../landing/CircularNetFlowChart.md)
* [Source Code Listing](../source/CircularNetFlowChartSourceCode.md)
* [Test Code Listing](../tests/CircularNetFlowChartUnitTest.md)
* [Chart Reference](../ChartsIndex.md)

