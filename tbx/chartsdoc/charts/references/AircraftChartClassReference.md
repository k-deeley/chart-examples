# `AircraftChart`

Visualize an aircraft and modify its roll, pitch, and yaw.

## Overview

The `AircraftChart` displays a triangulated surface representing an aircraft. The chart data comprises a triangulation object, such as that returned by the [`stlread`](https://www.mathworks.com/help/matlab/ref/stlread.html) function. The chart places the surface within a transform object (using [`hgtransform`](https://www.mathworks.com/help/matlab/ref/hgtransform.html)), which makes it straightforward to rotate the aircraft by specifying the required angle. The chart is equipped with the following methods for adjusting the aircraft's attitude:
- `roll`
- `pitch`
- `yaw`
- `reset`

![](../images/AircraftChart.png)

## Syntax

```matlab
AircraftChart()
AircraftChart(name, value, ...)
AC = AircraftChart(name, value, ...) 
```

## Input Arguments

All `AircraftChart` inputs are optional name-value arguments.

## Properties

| Name | Description | Type | Default Value | Access |
| --- | --- | --- | --- | --- |
| `Triangulation` | Aircraft triangulation coordinate data. | `triangulation` | `triangulation object` | public |

## Methods

| Name | Description |
| --- | --- |
| `axis` | Set axis limits and aspect ratios. |
| `view` | Camera line of sight. |
| `box` | Control chart axes box. |
| `title` | Add the specified title to the aircraft chart. |
| `reset` | Restore the original aircraft pose. |
| `yaw` | Yaw the aircraft by theta degrees. |
| `pitch` | Pitch the aircraft by theta degrees. |
| `roll` | Roll the aircraft by theta degrees. |

## Documentation

- [`stlread`](https://www.mathworks.com/help/matlab/ref/stlread.html): Create triangulation from STL file
- [`hgtransform`](https://www.mathworks.com/help/matlab/ref/hgtransform.html): Transform graphics objects
- [`trisurf`](https://www.mathworks.com/help/matlab/ref/trisurf.html): Triangular surface plot
- [`weboptions`](https://www.mathworks.com/help/matlab/ref/weboptions.html): Specify parameters for RESTful web service
- [`webread`](https://www.mathworks.com/help/matlab/ref/webread.html): Read content from RESTful web service

## Examples

### Create a figure for the chart.

```matlab
f = exampleFigure( "Name", "AircraftChart Example" );
```

### Create the chart.

Create the chart, using the default triangulation.
**Reference**: Airplane by Yorchmur, [`https://www.printables.com/model/34767-airplane`](https://www.printables.com/model/34767-airplane), licensed under the Creative Commons Attribution 4.0 International License.

```matlab
AC = AircraftChart( "Parent", f );
```

### Adjust the aircraft's attitude.

```matlab
AC.pitch( 5 )
AC.roll( 30 )
```

### Reset the aircraft.

```matlab
AC.reset()
```

## See Also

* [Aircraft Chart](../landing/AircraftChart.md)
* [Source Code Listing](../source/AircraftChartSourceCode.md)
* [Test Code Listing](../tests/AircraftChartUnitTest.md)
* [Chart Reference](../ChartsIndex.md)

