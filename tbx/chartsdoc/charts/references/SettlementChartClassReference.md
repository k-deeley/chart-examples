# `SettlementChart`

Plot in the money option prices against strike prices

## Overview

The `SettlementChart` displays the option prices against strike price. The option prices comprise put prices below the at-the-money (ATM) price, and call prices above the ATM price. The ATM price, i.e., where the call and put prices are equal, is highlighted by the call-put parity line.
The chart data are:
- `Price`, $S$: the current price of the underlying asset.
- `Strike`, $K$: the strike (i.e., exercise) price of the option, expressed as an increasing vector.
- `Rate`, $r$: the annualized continuously compounded risk-free rate of return over the life of the option, expressed as a positive decimal number.
- `Time`, $T$: the time to expiry of the option, expressed in years.
- `Volatility`, $\\sigma$: the annualized asset price volatility (i.e., the annualized standard deviation of the continuously compounded asset return), expressed as a positive decimal number.
- `Yield`**, **$q$: the annualized continuously compounded yield of the underlying asset over the life of the option, expressed as a decimal number.
These inputs are then used to compute the values of the *European put and call option prices* using the Black-Scholes model, given by the following equations:
where $\\Phi$ is the cumulative distribution function for the standard normal distribution ([**`normcdf`**](https://www.mathworks.com/help/stats/normcdf.html)) and:
Note that any of the inputs listed above can be omitted. This will result in the use of default values, which are defined as:
- *Strike*: 85 to 115 with spacing of 1
- *Underlying asset price*: 100
- *Rate*: 0.05
- *Time*: 0.25 years
- *Volatility*: 0.5
- *Yield*: 0

![](../images/SettlementChart.png)

## Syntax

```matlab
SettlementChart()
SettlementChart(name, value, ...)
SC = SettlementChart(name, value, ...) 
```

## Input Arguments

All `SettlementChart` inputs are optional name-value arguments.

## Properties

| Name | Description | Type | Default Value | Access |
| --- | --- | --- | --- | --- |
| `Strike` | The strike (i.e., exercise) price of the option. | `double` | none | public |
| `Price` | The price of the underlying asset, in currency units. | `double` | none | public |
| `Rate` | Annualized continuously compounded risk-free rate of return | `double` | none | public |
| `Time` | The time to expiray of the option, expressed in years. | `double` | none | public |
| `Volatility` | Annualized asset price volatility. | `double` | none | public |
| `Yield` | Annualized continuously compounded yield of the underlying asset | `double` | none | public |
| `OptionPrices` | Call and put prices computed using the Black-Scholes model. | `double` | none | read-only |
| `AtTheMoneyPrice` | At-the-money price (call-put parity price). | `double` | none | read-only |
| `CallColor` | Call curve color. | not specified | `[0 0.447 0.741]` | public |
| `CallLineStyle` | Call curve line style. | `string` | `"-"` | public |
| `CallLineWidth` | Call curve line width. | `double` | `1.5` | public |
| `CallMarker` | Call curve marker. | `string` | `"."` | public |
| `CallMarkerSize` | Call curve marker size. | `double` | `12` | public |
| `PutColor` | Put curve color. | not specified | `[0.85 0.325 0.098]` | public |
| `PutLineStyle` | Put curve line style. | `string` | `"-"` | public |
| `PutLineWidth` | Put curve line width. | `double` | `1.5` | public |
| `PutMarker` | Put curve marker. | `string` | `"."` | public |
| `PutMarkerSize` | Put curve marker size. | `double` | `12` | public |
| `AtTheMoneyColor` | Call-put parity line color. | not specified | `[0.5 0.5 0.5]` | public |
| `AtTheMoneyLineStyle` | Call-put parity line line style. | `string` | `"-"` | public |
| `AtTheMoneyLineWidth` | Call-put parity line line width. | `double` | `2` | public |
| `AtTheMoneyLabel` | Call-put parity line label. | `string` | `""` | public |
| `Controls` | Visibility of the chart controls. | `matlab.lang.OnOffSwitchState` | none | public |

## Methods

| Name | Description |
| --- | --- |
| `reset` | Set the default chart data. |
| `exportgraphics` | Call `exportgraphics` on the chart. |
| `axis` | Call `axis` on the chart. |
| `legend` | Call `legend` on the chart. |
| `grid` | Invoke grid on the axes. |
| `title` | Call `title` on the chart. |
| `ylabel` | Call `ylabel` on the chart. |
| `xlabel` | Call `xlabel` on the chart. |

## Documentation

- [`blsprice`](https://www.mathworks.com/help/finance/blsprice.html): Black-Scholes call and put option pricing
- [`normcdf`](https://www.mathworks.com/help/stats/normcdf.html): Normal cumulative distribution function

## Examples

### Define input data for the chart.

Strike prices, defined in currency units, e.g., $US.

```matlab
Strike = (85:0.1:115).';
```

The price of the underlying asset, defined in currency units.

```matlab
Price = 100;
```

Risk-free interest rate, expressed as a decimal number between 0 and 1.

```matlab
Rate = 0.04;
```

Time to expiry, expressed in years.

```matlab
Time = 0.25;
```

Volatility, expressed as a decimal number between 0 and 1.

```matlab
Volatility = 0.45;
```

Dividend yield, expressed as a decimal number between 0 and 1.

```matlab
Yield = 0.01;
```

### Create the chart.

```matlab
f = exampleFigure( "Name", "SettlementChart Example" );

SC = SettlementChart( "Parent", f, ...
    "Strike", Strike, ...
    "Price", Price, ...
    "Rate", Rate, ...
    "Time", Time, ...
    "Volatility", Volatility, ...
    "Yield", Yield );
```

### Access the option prices from the chart.

The corresponding call and put option prices are computed by the chart using the Black-Scholes model. We can access these using the `OptionPrices` chart property. This is a 2-column matrix containing the call and put prices in its columns, respectively.

```matlab
CallPrices = SC.OptionPrices(:, 1);
PutPrices  = SC.OptionPrices(:, 2);
```

The *at-the-money price*, where the call and put prices intersect, is also computed by the chart. We can query the chart property `AtTheMoneyPrice` to retrieve this. It is also displayed in the label of the constant line plotted on the chart's axes.

```matlab
disp( "At-the-money price: " + num2str( SC.AtTheMoneyPrice, "%.2f" ) )
```

### Adjust the chart data.

We can adjust any of the chart's data properties, including after the chart has been created.
For instance, we can change the underlying asset price.

```matlab
SC.Price = 99.5;
```

Multiple properties can be adjusted using the [set](https://www.mathworks.com/help/matlab/ref/set.html) command.

```matlab
set( SC, "Volatility", 0.75, "Yield", 0.05 )
```

The chart's graphics and controls update automatically.
Display the new at-the-money price.

```matlab
disp( "At-the-money price: " + num2str( SC.AtTheMoneyPrice, "%.2f" ) )
```

### Customize the chart appearance.

We can customize the chart appearance to meet our requirements. For instance, we can update the chart's annotations.

```matlab
xlabel( SC, "Strike price ($)", "FontSize", 14 )
ylabel( SC, "Option price ($)", "FontSize", 14 )
title( SC, "Settlement Chart", "FontSize", 16 )
```

We can also adapt various decorative properties of the lines.

```matlab
set( SC, "CallLineWidth", 1.5, ...
    "PutLineWidth", 1.5, ...
    "AtTheMoneyColor", [0.25, 0.25, 0.25], ...
    "AtTheMoneyLineWidth", 1.5, ...
    "AtTheMoneyLineStyle", ":" )
```

### Chart interactivity.

We can hide or show the chart's control panel via the `Controls` property.

```matlab
SC.Controls = "off";
```

### Reset the chart.

The control panel includes a button for restoring the default chart data. Programmatically, this is equivalent to invoking the chart's `reset` method.

```matlab
reset( SC )
```

## See Also

* [Settlement Chart](../landing/SettlementChart.md)
* [Source Code Listing](../source/SettlementChartSourceCode.md)
* [Test Code Listing](../tests/SettlementChartUnitTest.md)
* [Chart Examples](../../ChartExamples.md)

