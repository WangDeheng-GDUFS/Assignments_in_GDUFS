# Import packages
install.packages("ggplot2")
install.packages("corrplot")
install.packages("car")
library(ggplot2)
library(corrpolt)
library(car)



# In order to reduce the workload, I use 'gdp' for  many times.
# Altough they have different means.
# The gdp of cities in GuangDong
gdp <- read.csv("/home/nico/Github/Assignments_in_GDUFS/LangR/gdp.csv", header=1)
c1 <- gdp[1, 2: 8]
c2 <- gdp[2, 2: 8]
c3 <- gdp[3, 2: 8]
c4 <- gdp[4, 2: 8]
c5 <- gdp[5, 2: 8]
c6 <- gdp[6, 2: 8]
c7 <- gdp[7, 2: 8]
c8 <- gdp[8, 2: 8]
c9 <- gdp[9, 2: 8]
c10 <- gdp[10, 2: 8]
c11 <- gdp[11, 2: 8]
c12 <- gdp[12, 2: 8]
c13 <- gdp[13, 2: 8]
c14 <- gdp[14, 2: 8]
c15 <- gdp[15, 2: 8]
c16 <- gdp[16, 2: 8]
c17 <- gdp[17, 2: 8]
c18 <- gdp[18, 2: 8]
c19 <- gdp[19, 2: 8]
c20 <- gdp[20, 2: 8]
c21 <- gdp[21, 2: 8]
c22 <- gdp[22, 2: 8]


c1 = do.call(c, c1)
c2 = do.call(c, c2)
c3 = do.call(c, c3)
c4 = do.call(c, c4)
c5 = do.call(c, c5)
c6 = do.call(c, c6)
c7 = do.call(c, c7)
c8 = do.call(c, c8)
c9 = do.call(c, c9)
c10 = do.call(c, c10)
c11 = do.call(c, c11)
c12 = do.call(c, c12)
c13 = do.call(c, c13)
c14 = do.call(c, c14)
c15 = do.call(c, c15)
c16 = do.call(c, c16)
c17 = do.call(c, c17)
c18 = do.call(c, c18)
c19 = do.call(c, c19)
c20 = do.call(c, c20)
c21 = do.call(c, c21)
c22 = do.call(c, c22)
timeline <- c(2010, 2011, 2012, 2013, 2014, 2015, 2016)


plot(timeline, c1, type="l", lty=1)
lines(timeline, c2, col="brown",lty=2)
lines(timeline, c3, col="red", lty=3)
lines(c4~timeline, col="beige", lty=4)
lines(c5~timeline, col="yellow",lty=5)
lines(c6~timeline, col="pink",lty=6)
lines(c7~timeline, col="red",lty=7)
lines(c8~timeline, col="brown",lty=8)
lines(c9~timeline, col="yellow",lty=9)
lines(c10~timeline, col="green",lty=10)
lines(c11~timeline, col="blue",lty=11)
lines(c12~timeline, col="gray",lty=12)
lines(c13~timeline, col="brown",lty=13)
lines(c14~timeline, col="yellow",lty=14)
lines(c15~timeline, col="red",lty=15)
lines(c16~timeline, col="red",lty=16)
lines(c17~timeline, col="pink",lty=17)
lines(c18~timeline, col="brown",lty=18)
lines(c19~timeline, col="yellow",lty=19)
lines(c20~timeline, col="green",lty=20)
lines(c21~timeline, col="blue",lty=21)
lines(c22~timeline, col="gray",lty=22)



# The gdp rate of GuangDong
gdp <- read.csv("/home/nico/Github/Assignments_in_GDUFS/LangR/gdp_rate.csv", header=1)
c1 <- gdp[1, 2: 7]
c2 <- gdp[2, 2: 7]
c3 <- gdp[3, 2: 7]
c4 <- gdp[4, 2: 7]
c5 <- gdp[5, 2: 7]
c6 <- gdp[6, 2: 7]
c7 <- gdp[7, 2: 7]
c8 <- gdp[8, 2: 7]
c9 <- gdp[9, 2: 7]
c10 <- gdp[10, 2: 7]
c11 <- gdp[11, 2: 7]
c12 <- gdp[12, 2: 7]
c13 <- gdp[13, 2: 7]
c14 <- gdp[14, 2: 7]
c15 <- gdp[15, 2: 7]
c16 <- gdp[16, 2: 7]
c17 <- gdp[17, 2: 7]
c18 <- gdp[18, 2: 7]
c19 <- gdp[19, 2: 7]
c20 <- gdp[20, 2: 7]
c21 <- gdp[21, 2: 7]
c22 <- gdp[22, 2: 7]


c1 = do.call(c, c1)
c2 = do.call(c, c2)
c3 = do.call(c, c3)
c4 = do.call(c, c4)
c5 = do.call(c, c5)
c6 = do.call(c, c6)
c7 = do.call(c, c7)
c8 = do.call(c, c8)
c9 = do.call(c, c9)
c10 = do.call(c, c10)
c11 = do.call(c, c11)
c12 = do.call(c, c12)
c13 = do.call(c, c13)
c14 = do.call(c, c14)
c15 = do.call(c, c15)
c16 = do.call(c, c16)
c17 = do.call(c, c17)
c18 = do.call(c, c18)
c19 = do.call(c, c19)
c20 = do.call(c, c20)
c21 = do.call(c, c21)
c22 = do.call(c, c22)
timeline <- c(2011, 2012, 2013, 2014, 2015, 2016)


plot(timeline, c1, type="l", lty=1)
lines(timeline, c2, col="brown",lty=2)
lines(timeline, c3, col="red", lty=3)
lines(c4~timeline, col="beige", lty=4)
lines(c5~timeline, col="yellow",lty=5)
lines(c6~timeline, col="pink",lty=6)
lines(c7~timeline, col="red",lty=7)
lines(c8~timeline, col="brown",lty=8)
lines(c9~timeline, col="yellow",lty=9)
lines(c10~timeline, col="green",lty=10)
lines(c11~timeline, col="blue",lty=11)
lines(c12~timeline, col="gray",lty=12)
lines(c13~timeline, col="brown",lty=13)
lines(c14~timeline, col="yellow",lty=14)
lines(c15~timeline, col="red",lty=15)
lines(c16~timeline, col="red",lty=16)
lines(c17~timeline, col="pink",lty=17)
lines(c18~timeline, col="brown",lty=18)
lines(c19~timeline, col="yellow",lty=19)
lines(c20~timeline, col="green",lty=20)
lines(c21~timeline, col="blue",lty=21)
lines(c22~timeline, col="gray",lty=22)


# The gdp of the third industy of cities in GuangDong
gdp <- read.csv("/home/nico/Github/Assignments_in_GDUFS/LangR/The_Third.csv", header=1)
c1 <- gdp[1, 2: 8]
c2 <- gdp[2, 2: 8]
c3 <- gdp[3, 2: 8]
c4 <- gdp[4, 2: 8]
c5 <- gdp[5, 2: 8]
c6 <- gdp[6, 2: 8]
c7 <- gdp[7, 2: 8]
c8 <- gdp[8, 2: 8]
c9 <- gdp[9, 2: 8]
c10 <- gdp[10, 2: 8]
c11 <- gdp[11, 2: 8]
c12 <- gdp[12, 2: 8]
c13 <- gdp[13, 2: 8]
c14 <- gdp[14, 2: 8]
c15 <- gdp[15, 2: 8]
c16 <- gdp[16, 2: 8]
c17 <- gdp[17, 2: 8]
c18 <- gdp[18, 2: 8]
c19 <- gdp[19, 2: 8]
c20 <- gdp[20, 2: 8]
c21 <- gdp[21, 2: 8]
c22 <- gdp[22, 2: 8]


c1 = do.call(c, c1)
c2 = do.call(c, c2)
c3 = do.call(c, c3)
c4 = do.call(c, c4)
c5 = do.call(c, c5)
c6 = do.call(c, c6)
c7 = do.call(c, c7)
c8 = do.call(c, c8)
c9 = do.call(c, c9)
c10 = do.call(c, c10)
c11 = do.call(c, c11)
c12 = do.call(c, c12)
c13 = do.call(c, c13)
c14 = do.call(c, c14)
c15 = do.call(c, c15)
c16 = do.call(c, c16)
c17 = do.call(c, c17)
c18 = do.call(c, c18)
c19 = do.call(c, c19)
c20 = do.call(c, c20)
c21 = do.call(c, c21)
c22 = do.call(c, c22)
timeline <- c(2010, 2011, 2012, 2013, 2014, 2015, 2016)


plot(timeline, c1, type="l", lty=1)
lines(timeline, c2, col="brown",lty=2)
lines(timeline, c3, col="red", lty=3)
lines(c4~timeline, col="beige", lty=4)
lines(c5~timeline, col="yellow",lty=5)
lines(c6~timeline, col="pink",lty=6)
lines(c7~timeline, col="red",lty=7)
lines(c8~timeline, col="brown",lty=8)
lines(c9~timeline, col="yellow",lty=9)
lines(c10~timeline, col="green",lty=10)
lines(c11~timeline, col="blue",lty=11)
lines(c12~timeline, col="gray",lty=12)
lines(c13~timeline, col="brown",lty=13)
lines(c14~timeline, col="yellow",lty=14)
lines(c15~timeline, col="red",lty=15)
lines(c16~timeline, col="red",lty=16)
lines(c17~timeline, col="pink",lty=17)
lines(c18~timeline, col="brown",lty=18)
lines(c19~timeline, col="yellow",lty=19)
lines(c20~timeline, col="green",lty=20)
lines(c21~timeline, col="blue",lty=21)
lines(c22~timeline, col="gray",lty=22)



# Predit
gdp <- read.csv("/home/nico/Github/Assignments_in_GDUFS/LangR/gdp.csv", header=1)

y <- gdp[,8]
x1 <- gdp[,2]
x2 <- gdp[,3]
x3 <- gdp[,4]
x4 <- gdp[,5]
x5 <- gdp[,6]
x6 <- gdp[,7]

gdp_model <- lm(y ~ x6)
predict_gdp <- predict(gdp_model)
names(predict_gdp) <- gdp[,1]
barplot(predict_gdp)

gdp <- read.csv("/home/nico/Github/Assignments_in_GDUFS/LangR/The_Third.csv", header=1)
head(gdp)
y <- gdp[,9]
x2 <- gdp[,3]
x3 <- gdp[,4]
x4 <- gdp[,5]
x5 <- gdp[,6]
x6 <- gdp[,7]
x7 <- gdp[,8]

gdp_model <- lm(y ~ x6)
predict_gdp <- predict(gdp_model)
names(predict_gdp) <- gdp[,2]
barplot(predict_gdp)
