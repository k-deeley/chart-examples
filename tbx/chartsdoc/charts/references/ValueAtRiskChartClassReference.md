# `ValueAtRiskChart`

Plot the distribution of a return series together with its value at risk metrics and a distribution fit

## Overview

The `ValueAtRiskChart` displays the distribution of a given return series using a histogram. The chart also displays a non-parametric kernel-smoothed probability density fit (computed using `fitdist`) and two vertical lines indicating the empirical value at risk and conditional value at risk.
- The $x$% value at risk is the $(100-x)$th percentile of the return series data. For example, the $95\\%$ value at risk can be computed by taking the $5$th percentile of the return series values `r` . In `MATLAB` code, `VaR = prctile( r, 5 )`.
- The $x$% conditional value at risk is the mean of the returns which are less than the $x%$ value at risk. For example, the $95\\%$ conditional value at risk can be computed as:  `CVaR = mean( r( r < VaR ) )`, where `VaR` is the $95\\%$ value at risk.

![](../images/ValueAtRiskChart.png)

The chart data comprises a numeric vector (`Data`). The value at risk threshold is set using the `VaRLevel` property of the chart (the default value is 0.95, corresponding to a $95\\%$ threshold).

## Syntax

```matlab
ValueAtRiskChart()
ValueAtRiskChart(name, value, ...)
VARC = ValueAtRiskChart(name, value, ...) 
```

## Input Arguments

All `ValueAtRiskChart` inputs are optional name-value arguments.

## Properties

| Name | Description | Type | Default Value | Access |
| --- | --- | --- | --- | --- |
| `Data` | Underlying data for the chart, typically a series of returns. | `double` | none | public |
| `VaRLevel` | Value at risk level, used for both the VaR and CVaR metrics. | `double` | none | public |
| `DistributionName` | Probability distribution name. | `string` | none | public |
| `XGrid` | Axes x-grid. | `matlab.lang.OnOffSwitchState` | `"on"` | public |
| `YGrid` | Axes y-grid. | `matlab.lang.OnOffSwitchState` | `"on"` | public |
| `FittedPDFVisible` | Visibility of the PDF of the distribution fit. | `matlab.lang.OnOffSwitchState` | none | public |
| `VaRLineVisible` | Visibility of the VaR line. | `matlab.lang.OnOffSwitchState` | none | public |
| `CVaRLineVisible` | Visibility of the CVaR line. | `matlab.lang.OnOffSwitchState` | none | public |
| `VaRLabelVisible` | Visibility of the VaR label. | `matlab.lang.OnOffSwitchState` | none | public |
| `CVaRLabelVisible` | Visibility of the CVaR label. | `matlab.lang.OnOffSwitchState` | none | public |
| `LineWidth` | Width of distribution fit curve and risk lines. | `double` | `2` | public |
| `EdgeAlpha` | Histogram edge transparency. | `double` | none | public |
| `EdgeColor` | Histogram edge color. | not specified | none | public |
| `FaceAlpha` | Histogram bar face transparency. | `double` | none | public |
| `FaceColor` | Histogram bar face color. | not specified | none | public |
| `Controls` | Visibility of the chart controls. | `matlab.lang.OnOffSwitchState` | none | public |
| `RiskMetrics` | VaR and CVaR risk metrics. | `double` | none | read-only |

## Methods

| Name | Description |
| --- | --- |
| `exportgraphics` | Call `exportgraphics` on the chart. |
| `axis` | Call `axis` on the chart. |
| `legend` | Call `legend` on the chart. |
| `grid` | Invoke grid on the axes. |
| `title` | Call `title` on the chart. |
| `ylabel` | Call `ylabel` on the chart. |
| `xlabel` | Call `xlabel` on the chart. |

## Documentation

- [`fitdist`](https://www.mathworks.com/help/stats/fitdist.html): fit a probability distribution object to a data set
- [`quantile`](https://www.mathworks.com/help/stats/quantile.html): quantiles of data set

## Examples

### Create sample return series data from a t-distribution for the chart.

```matlab
rng( "default" )
d = 0.02 * trnd(10, 2000, 1 );
```

### Create and label the chart.

```matlab
f = exampleFigure( "Name", "ValueAtRiskChart Example" );

VRC = ValueAtRiskChart( "Parent", f, "Data", d );
```

### Change the bar color and transparency.

```matlab
VRC.FaceColor = [0, 0.5, 1];
VRC.FaceAlpha = 0.5;
```

### Adjust the value at risk level.

```matlab
VRC.VaRLevel = 0.99;
```

### Update the chart data and value at risk level.

```matlab
newData = 0.20 * randn( 1000, 1 );
set( VRC, "Data", newData, "VaRLevel", 0.95 )
```

## See Also

* [Value At Risk Chart](../landing/ValueAtRiskChart.md)
* [Source Code Listing](../source/ValueAtRiskChartSourceCode.md)
* [Test Code Listing](../tests/ValueAtRiskChartUnitTest.md)
* [Chart Examples](../../ChartExamples.md)

