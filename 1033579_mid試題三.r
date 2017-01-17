library(data.table)
library(dplyr)
library(tidyr)
#（一）將yyyymmddhh轉POSIXct分類中翻譯時間戳記格式，並新增為一個欄（變量），命名為timestamp。並將此樣本數據輸出為sample_data_parsed.csv（以逗號分隔，具有欄位名稱）

#匯入資料並移除特殊值
sampledata = fread('C:/Users/User/Desktop/ecoinfo2016fm-master/sample_data.txt',
                   header = T,
                   na.strings = c('-9996','-9997','-9999'))

#將yyyymmddhh轉POSIXct分類中翻譯時間戳記格式，並新增一欄命名為timestamp
sampledata[, timestamp:= as.POSIXct(strptime(yyyymmddhh-1,'%Y%m%d%H'))]

#並輸出為sample_data_parsed.csv
write.csv(sampledata,'C:/Users/User/Desktop/生態資訊學/sample_data_parsed.csv',row.names = F)

#（二）請計算2014年年至2015年年這個測站的每月平均氣溫，每月平均濕度，每月累積降水，並用表格呈現表格範例如下：

#新增一欄，並將年月合併
sampledata[, month:= format.Date(timestamp, '%Y %m')]

#計算2014-2015每月的月平均氣溫、月平均濕度和月累積降水
monthTX01=aggregate(sampledata$TX01,by=list(sampledata$month),FUN=mean,na.rm=TRUE)
monthRH01=aggregate(sampledata$RH01,by=list(sampledata$month),FUN=mean,na.rm=TRUE)
monthPP01=aggregate(sampledata$PP01,by=list(sampledata$month),FUN=sum,na.rm=TRUE)

#將月平均氣溫、月平均濕度和月累積降水合併為一表格
xy=dplyr::full_join(monthTX01,monthRH01,by = "Group.1")
xyz=dplyr::full_join(xy,monthPP01,by = "Group.1")
monthtable=dplyr::select(xyz,x.x,x.y,x)
#平均值取至小術後第二位
monthtable=round(monthtable, digits=2)
#將表格欄位定名
mouth=monthTX01[,1]
rownames(monthtable)=mouth
colnames(monthtable)=c("月平均氣溫","月平均濕度","月累積降水")
#將表格翻轉
monthtable=t(monthtable)

#(三）請計算2014年年和2015年年最冷月分別是在哪個月份？
min_2014=min(monthtable[1,1:12])
#2014最冷月為一月
min_2015=min(monthtable[1,12:24])
#2015最冷月為一月
#（四）在2015年年最冷的那個月份中，該月中每日的最低溫平均是幾度C
mouthday=group_by(monthtable)
min_2015day=summarise(mouthday,min(TX01))
