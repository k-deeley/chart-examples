# `ClockChart`

Display an analog clock with scheduled updates.

## Description

The `ClockChart` creates an analog clock backed by a MATLAB `timer` object for timekeeping. This chart illustrates the use of timer objects to schedule chart updates. The timer's callback property **`TimerFcn`** is implemented as a private chart method. The chart also needs to manage the lifecycle of the timer by deleting it when the chart is deleted. We do not have direct access to the chart's destructor method, so the approach is to create a listener to the chart event `ObjectBeingDestroyed`.
```matlabCodeExample
weakObj = matlab.lang.WeakReference( obj );
callback = @( varargin ) weakObj.Handle.onChartDeleted( varargin{:} );
obj.DestructionListener = listener( obj, "ObjectBeingDestroyed", callback );
```
The listener callback **`onChartDeleted`** is implemented as a private chart method, and is responsible for safely disposing of the timer.
```matlabCodeExample
function onChartDeleted( obj, ~, ~ )
%ONCHARTDELETED Respond to the destruction of the chart by
%tidying up the timer object.

## Syntax

```matlab
ClockChart()
ClockChart(name, value, ...)
CC = ClockChart(name, value, ...)
```

## Input Arguments

All `ClockChart` inputs are optional name-value arguments.

## Properties

| Name | Description | Type | Default Value | Access |
| --- | --- | --- | --- | --- |
| `ShowNumbers` | No description available. | `matlab.lang.OnOffSwitchState` | `"on"` | public |

## Methods

| Name | Description |
| --- | --- |
| none | none |

## Examples

### Create a figure for the chart.

```matlab
f = exampleFigure( "Name", "ClockChart Example", ...
    "Position", [0.25, 0.25, 0.5, 0.5] );
```

### Create the chart, specifying the parent.

```matlab
CC = ClockChart( "Parent", f );
```

## See Also

* [Clock Chart](ClockChart.md)
* [Source Code Listing](ClockChartSourceCode.md)
* [Unit Test Listing](ClockChartUnitTest.md)
* [Chart Reference](ChartsIndex.md)

