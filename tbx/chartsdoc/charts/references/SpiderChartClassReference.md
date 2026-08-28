# `SpiderChart`

Compare values from distinct measurements on a web.

## Overview

The `SpiderChart` manages the display of data measuring several distinct numeric variables recorded from one or more subjects. The chart backdrop is a "web" comprising a series of concentric regular polygons and angular rays.
The chart data comprises a numeric matrix `Data` of size $p\\times q$, where:
- $p$ is the number of numeric variables (equal to the number of vertices and edges in the polygons),
- $q$ is the number of subjects (equal to the number of data lines on the chart).
Each row of the chart data represents a variable, and each column represents a complete set of measurements for one subject. Each measured value lies between 0 and 1, which allows distinct variables to be compared easily. To display measured values not lying in the range $\[0, 1\]$, the input data matrix should be rescaled on a columnwise basis. For ease of comparison, the chart backdrop has 10 concentric polygons with radii $r=0.1, 0.2, \\dots, 0.9, 1$.
We impose the constraint $3\\leq p\\leq 20$ on the number of variables. The lower bound $p\\geq 3$ ensures that the chart backdrop has at least 3 nodes, i.e., that the web is at least triangular. The upper bound $p\\leq 20$ is purely for visual reasons and ensures that the chart backdrop has at most 20 nodes and does not become too cluttered. There is no restriction on the number of lines $q$, but in practice the chart becomes tricky to read if $q$ is too large.
There is also an additional chart data property `TargetData` of size $p\\times 1$. These values are plotted on the web using a separate line object, which can be toggled on or off as required. Visualizing the `TargetData` property allows the observed data measurements to be compared against their target values. As above, the target data should lie in the range $\[0, 1\]$.

![](../images/SpiderChart.png)

## Syntax

```matlab
SpiderChart()
SpiderChart(name, value, ...)
SC = SpiderChart(name, value, ...) 
```

## Input Arguments

All `SpiderChart` inputs are optional name-value arguments.

## Properties

| Name | Description | Type | Default Value | Access |
| --- | --- | --- | --- | --- |
| `WebLineWidth` | Web line width. | `double` | `1.5` | public |
| `Data` | Matrix of chart data: each row represents a distinct property | `double` | none | public |
| `TargetData` | Target data vector, containing the same number of | `double` | none | public |
| `LabelText` | Node labels. | `string` | none | public |
| `LineWidth` | Line width of the data lines. | `double` | `1.5` | public |
| `TargetVisible` | Visibility of the target line. | `matlab.lang.OnOffSwitchState` | `"off"` | public |
| `TargetColor` | Target line color. | not specified | `"k"` | public |
| `TargetLineWidth` | Target line width. | `double` | `1.5` | public |
| `TargetLineStyle` | Target line style. | `string` | `":"` | public |
| `LabelFontSize` | Node label font size. | `double` | `10` | public |
| `LabelFontAngle` | Node label font angle. | `string` | `"normal"` | public |
| `LabelFontWeight` | Node label font weight. | `string` | `"normal"` | public |
| `LineColors` | Line colors. | `double` | none | public |
| `NumNodes` | Number of nodes. | `double` | none | read-only |
| `NumLines` | Number of lines. | `double` | none | read-only |

## Methods

| Name | Description |
| --- | --- |
| `legend` | Call `legend` on the chart. |
| `title` | Call `title` on the chart. |

## Documentation

- [`line`](https://www.mathworks.com/help/matlab/ref/line.html): Create primitive line

## Examples

### Generate sample chart data for one subject.

Let's start with one subject and assume that there are five measured variables.

```matlab
rng( "default" )
data = rand( 5, 1 );
```

Define the node labels.

```matlab
labels = "Property " + (1:numel( data ));
```

### Create a figure for the chart.

```matlab
f = exampleFigure( "Name", "SpiderChart Example" );
```

### Create the chart.

```matlab
SC = SpiderChart( "Parent", f, ...
    "Data", data, ...
    "LabelText", labels );
```

### Annotate the chart.

The `Spider` chart has the `title` and `legend` methods for annotation.

```matlab
title( SC, "Spider Chart", "FontSize", 14 )
```

### Add target data and customize the appearance of the target line.

We can add a target data vector to the chart.

```matlab
SC.TargetData = 0.35 * ones( SC.NumNodes, 1 );
```

Customize the appearance of the target line.

```matlab
set( SC, "TargetVisible", "on", "TargetLineWidth", 2 )
```

### Hide the target line.

```matlab
SC.TargetVisible = "off";
```

### Decrease the number of observed variables.

```matlab
SC.Data = [0.1; 0.3; 0.5; 0.7];
```

### Increase the number of observed variables.

```matlab
rng( "default" )
SC.Data = rand( 8, 1 );
```

### Update the labels.

```matlab
SC.LabelText = ["A", "B", "C", "D", "E", "F", "G", "H"];
```

### Increase the number of subjects.

The number of subjects is defined by the number of columns in the chart data matrix.

```matlab
SC.Data = rand( 8, 4 );
```

### Decrease the number of observed variables.

```matlab
SC.Data = SC.Data(1:5, :);
```

### Add a legend.

```matlab
legend( SC, "Subject " + (1:SC.NumLines) )
```

### Update the target data.

```matlab
set( SC, "TargetData", 0.55 * ones( SC.NumNodes, 1 ), ...
    "TargetVisible", "on" )
```

### Customize the visual appearance of the chart.

```matlab
set( SC, "LineColors", hsv( SC.NumLines ), ...
    "LineWidth", 3, ...
    "LabelFontWeight", "bold", ...
    "LabelFontSize", 12, ...
    "LabelFontAngle", "italic" )
```

## See Also

* [Spider Chart](../landing/SpiderChart.md)
* [Source Code Listing](../source/SpiderChartSourceCode.md)
* [Test Code Listing](../tests/SpiderChartUnitTest.md)
* [Chart Reference](../ChartsIndex.md)

