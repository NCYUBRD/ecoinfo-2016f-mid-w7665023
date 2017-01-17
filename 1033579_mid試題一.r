#請隨機產生 10000 組正整數儲存成 vector 格式，並輸出成 random10k.csv 
#隨機產生10000個整數，使用sample()函式
#使用c()函式來把資料聚合成"向量(vector)"的形式
x = c(sample(10000))
write.csv(x,'C:/Users/User/Desktop/生態資訊學/random10k.csv',row.names = F)
