###############################
######## Assignment 5 #########
###############################

# Data manipulation
rm(list = ls())

setwd("/Users/emanuelastruffolino/Desktop/SequenceCourse/Lezione 5_02102012")
library (TraMineRextras)
library (foreign)
getwd() 

#1. Read the SPSS data file bfsp1.sav and store the result in a data frame named bfsp
#(tips: use the command read.spss() from the foreign library).

bfsp<-read.table("bfsp1.txt")

#2. Look at the content of bfsp using head(). In what format is the sequence data organized?
head(bfsp)
#state sequence (spell)

#3. Read the space delimited text data file bfsp2.txt and store the result 
#in a data frame named bfdata (Tips: use the command read.table()). 
#This file contains additional individual data for each case considered 
#in the sequence file. Look at the first records in bfdata.
bfdata<-read.table("bfsp2.txt")
head(bfdata)

#4. Using seqformat(), transform the bfsp data frame into a data frame with 
   #sequence data in STS format. Tips 1: you should use the birthdate bfdata 
   #birthyr and the id bfdata idpers. Tips 2: set the limit argument to 16 
   #(maximum length of a sequence).

bf.pdata <- bfdata[, c("idpers", "birthyr")]
bf.pdata <- aggregate(bf.pdata, by = list(bf.pdata$idpers),
                          FUN = min)[, -1]
bf.pdata[1:3, ]

limit=16
bf.sts<- seqformat(bfsp, id = "id", begin = "begin",
                        end = "end", status = "states", from = "SPELL", to = "STS",
                        compressed = FALSE, process = TRUE, pdata = bf.pdata,
                        pvar = c("idpers", "birthyr"), limit = limit)

#this last command doesn't work...