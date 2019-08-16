library(caret) 

setwd(C:\\Users\\Goutham\\Desktop\\CDA Assignments - 2nd sem\\Data Mining\\Assignment 4") 

xy=read.table("DailyDataTranspose.csv",sep=',',header=F) 

y=xy[,5] 

x=xy[,1:4] 

myCvControl <- trainControl(method = "CV",number=10) 

 

#Linear regression: 

glmFitTime <- train(V5 ~ ., 

                     data = xy, 

                     method = "glm", 

                     preProc = c("center", "scale"), 

                     tuneLength = 10, 

                     trControl = myCvControl) 

glmFitTime 

y_pred = predict(glmFitTime, newdata = x) 

#Linear Regression - MAPE 

mean(100*abs(y_pred-y)/y) 

 

#Support vector regression: 

svmFitTime <- train(V5 ~ ., 

                     data = xy, 

                     method = "svmRadial", 

                     preProc = c("center", "scale"), 

                     tuneLength = 10, 

                     trControl = myCvControl) 

svmFitTime 

summary(svmFitTime) 

  

y_pred = predict(svmFitTime, newdata = x) 

#SVR - MAPE 

mean(100*abs(y_pred-y)/y) 

  

# Neural Network 

nnFitTime <- train(V5 ~ ., 

                   data = xy, 

                   method = "avNNet", 

                   preProc = c("center", "scale"), 

                   trControl = myCvControl, 

                   linout = T, 

                   trace = F, 

                   MaxNWts = 10 * (ncol(xy) + 1) + 10 + 1, 

                   maxit = 500) 

nnFitTime 

summary(nnFitTime) 

  

y_pred = predict(nnFitTime, newdata = x) 

#NN - MAPE 

mean(100*abs(y_pred-y)/y) 

 

#ARIMA: 

install.packages('tseries') 

library('tseries') 

install.packages("forecast", dependencies = TRUE) 

library("forecast") 

 

t=read.table("daily data.csv",sep=',',header=F) 

head(t) 

 tSeries = ts(t[,1],start=2011,freq=365) 

plot(tSeries) 

plot(stl(tSeries,s.window="periodic")) 

ar <- Arima(tSeries,order=c(7,0,7)) 

summary(ar) 