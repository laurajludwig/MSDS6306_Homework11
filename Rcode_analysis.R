class(EuStockMarkets)
head(EuStockMarkets)
DAX <- EuStockMarkets[,"DAX"] #Extract the DAX variable from the multivariate time series

plot(DAX,col="blue",ann=FALSE)
title(main="DAX Stock Index Trend",xlab="Year",ylab="DAX Index Value")
abline(v=1997, col="red")

fit <- decompose(DAX,type="multiplicative")
plot(fit,col="blue")
abline(v=1997,col="red")

install.packages('fpp2')
library(fpp2)
autoplot(maxtemp)
recent <- window(maxtemp,start=c(1990,1))
forecast <- ses(recent, h=5)
plot(forecast)
lines(forecast$fitted,col="blue")
aicc<-forecast$model$aicc
holtforecast <-holt(recent,h=5,damped=TRUE,inital="optimal")
plot(holtforecast)
lines(holtforecast$fitted,col="blue")
aiccHolt <- holtforecast$model$aicc



dygraph(combined,main="Wand Sales by Maker",xlab="Date",ylab="Sales") %>%
  dySeries("Olliv.Sales", label="Ollivander", col="blue") %>%
  dySeries("Grego.Sales", label="Gregorovitch",col="orange") %>%
  dyOptions(fillGraph=TRUE)%>%
  dyRangeSelector() %>%
  dyShading(from="1995-01-01",to="1999-07-31") %>%
  dyHighlight(highlightSeriesOpts = list(strokeWidth =3))%>% 
  dyLegend(width=500)
