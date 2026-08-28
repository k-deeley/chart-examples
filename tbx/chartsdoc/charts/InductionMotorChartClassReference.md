# `InductionMotorChart`

Visualize induction motor characteristics.

## Description

The `InductionMotorChart` visualizes the performance of an induction motor in speed-torque coordinates. Thanks to Chris Armstrong for the idea behind this example.
The chart data comprises a scalar [`InductionMotorParameters`](../../charts/InductionMotorParameters.m) object, which has the following properties:
- `NormalRegion`: a rectangular region representing the normal operating regime of the motor.
- `BufferRegion`: two distinct rectangular regions, above and below the normal operating region, representing the buffer zone between the normal region and the overload region.
- `OverloadRegion`: two distinct trapezoidal regions, above and below the buffer regions, representing values where the motor is overloaded.
- `Bounds`: speed-torque coordinates of the bounds used for visualizing the motor performance; these bounds will be slightly more than the min/max motor performance values.
- `ReducedCurves`: a set of speed-torque curves bounding the acceptable operating points of the motor.
- `RatedCurves`: a set of speed-torque curves bounding the maximum rated operating points of the motor.
In addition to the motor parameters, the chart data comprises the operating point $(\\omega, \\tau)$ in speed-torque coordinates, where $\\omega$ is the motor speed (RPM) and $\\tau$ is the motor torque (Nm). The operating point can be moved freely by setting its value.
The chart also has an event (`AbnormalPerformanceDetected`) and an associated callback function (`AbnormalPerformanceDetectedFcn`). The event is notified when the operating point of the motor is not within the normal operating region.

## Syntax

```matlab
InductionMotorChart()
InductionMotorChart(name, value, ...)
IMC = InductionMotorChart(name, value, ...)
```

## Input Arguments

All `InductionMotorChart` inputs are optional name-value arguments.

## Properties

| Name | Description | Type | Default Value | Access |
| --- | --- | --- | --- | --- |
| `OperatingPoint` | Operating point of the motor. | `double` | `[0 0]` | public |
| `LineWidth` | Width of the rated and reduced curves. | `double` | `2` | public |
| `MarkerSize` | Operating point marker size. | `double` | `20` | public |
| `FaceAlpha` | Transparency of the patches. | `double` | `0.6` | public |
| `LegendVisible` | Visibility of the legend. | `matlab.lang.OnOffSwitchState` | `"on"` | public |
| `MotorParameters` | A set of induction motor parameters. | `InductionMotorParameters` | none | public |
| `AbnormalPerformanceDetectedFcn` | AbnormalPerformanceDetectedFcn is a generated callback property for the event: AbnormalPerformanceDetected | not specified | `""` | public |

## Methods

| Name | Description |
| --- | --- |
| `axis` | Call `axis` on the chart. |
| `grid` | Call `grid` on the chart. |
| `subtitle` | Call `subtitle` on the chart. |
| `title` | Call `title` on the chart. |
| `ylabel` | Call `ylabel` on the chart. |
| `xlabel` | Call `xlabel` on the chart. |

## Examples

### Import a set of induction motor parameters.

```matlab
motorParametersFolder = fullfile( chartsRoot(), "data", "MotorParameters" );
IMP = InductionMotorParameters( motorParametersFolder );
disp( IMP )
```

### Create a figure for the chart.

```matlab
f = exampleFigure( "Name", "InductionMotorChart Example" );
```

### Create the chart.

```matlab
IMC = InductionMotorChart( "Parent", f, "MotorParameters", IMP );
```

### Move the operating point.

```matlab
IMC.OperatingPoint = [2000, 200];
```

### Respond to abnormal performance using a callback function.

Define the callback function.

```matlab
IMC.AbnormalPerformanceDetectedFcn = @( s, e ) disp( "Abnormal performance detected!" );
```

Move the operating point to the buffer region.

```matlab
IMC.OperatingPoint = [2000, -450];
```

## See Also

* [Induction Motor Chart](InductionMotorChart.md)
* [Source Code Listing](InductionMotorChartSourceCode.md)
* [Unit Test Listing](InductionMotorChartUnitTest.md)
* [Chart Reference](ChartsIndex.md)

