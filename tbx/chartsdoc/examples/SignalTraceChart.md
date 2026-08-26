# Signal Trace Chart

## Overview

The `SignalTraceChart` organizes the vertical display of multiple signal channels. The chart data comprises a numeric vector `Time` and a numeric matrix `SignalData`. Each column of `SignalData` is interpreted as a separate channel. To organize the vertical display of the signals, the chart normalizes each channel to have zero mean and unit standard deviation, then plots each signal against time in a vertical stack, leaving a small gap between each successive pair of signals. Signals may be inserted or removed from the chart by modifying the `SignalData` property. The time vector is changed by modifying the `Time` property.

![](./images/SignalTraceChart.png)

## Documentation

See also:
- [**`stackedplot`**](https://www.mathworks.com/help/matlab/ref/stackedplot.html): An existing MATLAB chart for creating a stacked plot of several variables with a common x-axis

## Examples

### Create data for the chart: time and signals.

First, define a time vector from 0 to $6\\pi$containing 5000 elements.

```matlab
t = linspace( 0, 6 * pi, 5000 ).';
```

Next, define various signals:
- $y\_1$ is a discrete signal taking values $0$, $-1$ and $1$;
- $y\_2$ is a sine wave;
- $y\_3$ is a cosine wave;
- $y\_4$ is the product of a sine wave and a cosine wave which have different frequencies.

```matlab
y1 = [zeros( 1000, 1 ); ones( 500, 1 );
    zeros( 500, 1 ); (-1) * ones( 500, 1 );
    ones( 1000, 1 ); zeros( 1000, 1 );
    ones( 500, 1 )];
y2 = sin( t );
y3 = cos( t );
y4 = 2 * sin( 2 * t ) .* cos( 3 * t );
```

Join the signals $y\_1$, $y\_2$, $y\_3$ and $y\_4$ into a matrix with four columns.

```matlab
signals = [y1, y2, y3, y4];
```

### Create a figure for the chart.

```matlab
f = exampleFigure( "Name", "SignalTraceChart Example" );
```

### Create the chart.

```matlab
STC = SignalTraceChart( "Parent", f, ...
    "Time", t, ...
    "SignalData", signals, ...
    "XAxisFontSize", 12 );
```

### Customize the chart appearance.

```matlab
xlabel( STC, "Time (s)", "FontSize", 14 )
ylabel( STC, "Traces", "FontSize", 14)
title( STC, "Signal Trace Chart", "FontSize", 16 )
```

### Change the chart data.

```matlab
STC.Time = 5 + STC.Time;
STC.SignalData = [y1, y3];
```
