---
title: "Homework11"
author: "Laura Ludwig"
date: "November 18, 2017"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Brief Financial Data
### a. Extract the DAX time series
```{r data1}
DAX <- EuStockMarkets[,"DAX"] #Extract the DAX variable from the multivariate time series
```

Pull the DAX variable out of the multivariate time series.

### b. Plot the data
```{r plot1}
plot(DAX,col="blue",ann=FALSE)
title(main="DAX Stock Index Trend",xlab="Year",ylab="DAX Index Value")
abline(v=1997, col="red")
```

This plot shows the trend of the DAX Index value. There is an event of note in 1997, which is indicated by the red line.

### c. Decompose the Time Series
```{r decompose}
fit <- decompose(DAX,type="multiplicative")
plot(fit,col="blue")
abline(v=1997,col="red")
```

Decomposing the time series to show trend, seasonality and noise.

## Temperature Data
### a. Examining Data
```{r data2}
library(fpp2)
autoplot(maxtemp)
```

Maximum temperatures in Melbourne, Australia, given in Celsius, from 1971 to 2016.

### b. Subsetting to view 1990 and beyond
```{r subet2}
recent <- window(maxtemp,start=c(1990,1))
```

Subsetting the data from maxtemp to show 1990 and beyond.

### c. Forecasting 
```{r forecast2c}
forecast <- ses(recent, h=5)
plot(forecast)
lines(forecast$fitted,col="blue")
aicc<-forecast$model$aicc
```

Using Simple Exponential Smoothing, a five-year prediction is shown. The predicted values for each year in the dataset from 1990 forward are shown in blue.

### d. Damped Holt's Linear Trend
```{r forecast2d}
holtforecast <-holt(recent,h=5,damped=TRUE,inital="optimal")
plot(holtforecast)
lines(holtforecast$fitted,col="blue")
aiccHolt <- holtforecast$model$aicc
```

Using Holt linear trend (with damping), a five-year prediction is shown. The predicted values for each year in the dataset from 1990 forward are shown in blue.

### e. Comparing AICCs
```{r AICCs}
aicc
aiccHolt
```

The preferred model it typically the one with the smaller AICc value, in this case, the SES model. 

## The Wands Choose the Wizard
### a. Getting Data
```{r data3}
library(dygraphs)
Olliv <- read.csv("Unit11TimeSeries_Ollivander.csv", header=FALSE)
Grego <- read.csv("Unit11TimeSeries_Gregorovitch.csv", header=FALSE)
```

Read in data from two files about the wand sales over time by two wand makers.

### b. Converting Data
```{r convert3}
Olliv$V1 <- as.Date(Olliv$V1,"%m/%d/%Y")
Grego$V1 <- as.Date(Grego$V1,"%m/%d/%Y")
```

Converting the string/factor variable into an appropriate Date type.

### c. Convert to Time Series Object
```{r timseries3}
library(xts)
OllivTS <- xts(Olliv,order.by=Olliv$V1)
GregoTS <- xts(Grego,order.by=Grego$V1)
names(OllivTS) <- c("Date","Olliv Sales")
names(GregoTS) <- c("Date","Grego Sales")
```

Creating XTS objects from data frame objects. Also cleaned up the variable names to be easier to identify.

### d. Putting it all together
```{r alltogether}
combined <- merge(OllivTS[,2],GregoTS[,2])
dygraph(combined,main="Wand Sales by Maker",xlab="Date",ylab="Sales") %>%
  dySeries("Olliv.Sales", label="Ollivander", col="blue") %>%
  dySeries("Grego.Sales", label="Gregorovitch",col="orange") %>%
  dyOptions(fillGraph=TRUE)%>%
  dyRangeSelector() %>%
  dyShading(from="1995-01-01",to="1999-07-31") %>%
  dyHighlight(highlightSeriesOpts = list(strokeWidth =3))%>% 
  dyLegend(width=500)
```

Creating a merged data set from which to build a dygraph. Creating a dygraph with a number of different features.