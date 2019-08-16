# This code is to sum up data points with respect to time intervals 
import pandas as pd
electConsum15MinData = pd.read_csv('fifteen minute data.csv', header=None)
Min15consumption = electConsum15MinData[0]
hourlyData = []
i = 0
while(i < Min15consumption.count()):
    iSum = 0
    for j in range(i, i+4):
        iSum += Min15consumption[j]
    hourlyData.append(iSum)
    i = i+4

dfHourlyData = pd.DataFrame(hourlyData)
dfHourlyData.to_csv(path_or_buf='hourly data.csv', sep=',')


dailyData = []
i = 0
fullRow = True 
while(i < Min15consumption.count()):
    iSum = 0
    for j in range(i, i+(4*24)):
        if(j < Min15consumption.count()):
            iSum += Min15consumption[j]
        else:
            fullRow = False
    if(fullRow):
        dailyData.append(iSum)
    i = i+(4*24)

dfDailyData = pd.DataFrame(dailyData)
dfDailyData.to_csv(path_or_buf='daily data.csv', sep=',')

##########################################################################

# This code is to transpose data and is used for models expect Time series
import numpy as np

Min15DataTranspose = pd.DataFrame(Min15consumption.values.reshape(-1,12))
Min15DataTranspose.to_csv(path_or_buf='Min15DataTranspose.csv', sep=',')

HourlyDataTranspose = pd.DataFrame(np.asarray(hourlyData[5:]).reshape(-1, 8))
HourlyDataTranspose.to_csv(path_or_buf='HourlyDataTranspose.csv', sep=',')

DailyDataTranspose = pd.DataFrame(np.asarray(dailyData).reshape(-1,5))
DailyDataTranspose.to_csv(path_or_buf='DailyDataTranspose.csv', sep=',')








