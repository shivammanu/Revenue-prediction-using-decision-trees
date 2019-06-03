toy<-read.csv("CustomerData.csv",header=TRUE,sep=",")
toy<-toy[,-1]
which(is.na(toy))
toy<-knnImputation(toy,scale=T,k=5) #KNN Imputation
sum(is.na(toy))
str(toy)

toy$City<-as.factor(toy$City)



for (i in 1:nrow(toy))
{
  if (toy$Revenue[i]<150)
  { 
    toy$Revenue[i]='Regular'
  }
  else 
  { 
    toy$Revenue[i]='Premium'
  }
  
}
toy$Revenue<-as.factor(toy$Revenue)
library(infotheo)
Bin <- discretize(toy$NoOfChildren, disc="equalfreq",nbins=4)


require(caTools)
set.seed(123)
sample = sample.split(toy, SplitRatio = .70)
train = subset(toy, sample == TRUE)
test = subset(toy, sample == FALSE)


library(C50)
DT_C50 <- C5.0(Revenue~.,data=train)
plot(DT_C50)


