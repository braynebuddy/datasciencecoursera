# Assignment #1

# from the lectures:
# if (!file.exists("./data")) {
#     file.create("data")
# }
# fileUrl <- "http://somewhere.com")
# download.file(fileUrl, destfile="./data/a1_data.csv", method="curl")
# data <- read.xlsx("ExcelFile.xlsx")
# write.xlsx(varName)

# Question 1:
# Load the data
setwd("~/Documents/Data Analytics/datasciencecoursera/3-GetAndCleanData")
a1_data <- read.csv("getdata_data_ss06hid.csv")

# Get the properties worth more than $1M
over1m <- nrow(a1_data[a1_data$VAL>=24 & !is.na(a1_data$VAL),])

# Question 3
library(xlsx)
dat <- read.xlsx("getdata_data_DATA.gov_NGAP.xlsx", sheetIndex=1, 
                        colIndex=7:15, rowIndex=8:23)
sum(dat$Zip*dat$Ext,na.rm=T)

# Question 4
library(XML)
fileUrl <- "getdata_data_restaurants.xml"
r_dat <- xmlTreeParse(fileUrl, useInternal=TRUE)
zips <- xpathSApply(rootNode, "//zipcode", xmlValue)
zip21231 <- length(zips[zips=="21231"])

# Question 5
library(data.table)
DT[,mean(pwgtp15),by=SEX]
system.time(DT[,mean(pwgtp15),by=SEX])
sapply(split(DT$pwgtp15,DT$SEX),mean)
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
